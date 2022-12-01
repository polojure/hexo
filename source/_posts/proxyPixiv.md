---
title: 记录一次反代pixiv的过程
categories:
  - interesting
tags:
  - nginx
date: 2022-12-01 11:34:52
updated:
type:
comments: 
cover:
description: 利用nginx进行反向代理
keywords:
top_img:
mathjax:
katex:
aside:
aplayer:
highlight_shrink:
---



# 记录一次反代pixiv的过程



> **参考** [[Pixiv] Nginx 真·反代P站](https://img-cnd.noel.ga/html/%5BPixiv%5D%20Nginx%20%E7%9C%9F%C2%B7%E5%8F%8D%E4%BB%A3P%E7%AB%99%20-%20%E7%A5%9E%E4%BB%A3%E7%B6%BA%E5%87%9B%E3%81%AE%E9%9A%8F%E6%B3%A2%E9%80%90%E6%B5%81%20%282022_12_1%2012_28_00%29.html)



```nginx
# *.junezate.ml
server
{
    listen 80;
    listen [::]:80;

    # listen 443 ssl http2;
    # listen [::]:443 ssl http2;
    # ssl_certificate /etc/nginx/cert/fullchain.crt;
    # ssl_certificate_key /etc/nginx/cert/private.pem;
    # ssl_session_timeout 1d;
    # ssl_session_cache shared:MozSSL:10m;
                # ssl_session_tickets off;
  
    # ssl_protocols TLSv1.2 TLSv1.3;
    # ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    # ssl_prefer_server_ciphers off;

    server_name ~^([^.]+)\.junezate\.ml$;
    set $domain $1;
    proxy_set_header Cookie $http_cookie;
    resolver 8.8.8.8;

    location ~ .*
    {
        proxy_set_header Host $domain.pixiv.net;
        proxy_set_header Referer "https://www.pixiv.net";
        proxy_cookie_domain pixiv.net junezate.ml;
        proxy_pass https://$domain.pixiv.net;
        proxy_ssl_server_name on;
        proxy_set_header Accept-Encoding "";
        proxy_redirect https://accounts.pixiv.net/ https://accounts.junezate.ml/;

        sub_filter "i-cf.pximg.net" "i.highcool.ga";
        sub_filter "source.pixiv.net" "source.highcool.ga";
        sub_filter "pixiv.net" "junezate.ml";
        sub_filter "pximg.net" "highcool.ga";
        sub_filter "js_error.php" "block_js_error";
        sub_filter "www.google" "block_google";
        sub_filter_once off;
        sub_filter_types *;
    }
}

# *.zeropava.ml
server
{
    listen 80;
    listen [::]:80;
    # listen 443 ssl http2;
    # listen [::]:443 ssl http2;
    # ssl_certificate /etc/nginx/cert/pximg/fullchain.crt;
    # ssl_certificate_key /etc/nginx/cert/pximg/private.pem;
    # ssl_session_timeout 1d;
    # ssl_session_cache shared:MozSSL:10m;
                # ssl_session_tickets off;
  
    # ssl_protocols TLSv1.2 TLSv1.3;
    # ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    # ssl_prefer_server_ciphers off;

    server_name ~^([^.]+)\.zeropava\.ml$;
    set $domain $1;

    resolver 8.8.8.8;

    location ~ .*
    {
        proxy_set_header Host $domain.pximg.net;
        proxy_set_header Referer "https://www.pixiv.net";
        proxy_pass https://$domain.pximg.net;
        proxy_ssl_server_name on;
        proxy_set_header Accept-Encoding "";

        sub_filter "i-cf.pximg.net" "i.highcool.ga";
         sub_filter "source.pixiv.net" "source.highcool.ga";
        sub_filter "pixiv.net" "junezate.ml";
        sub_filter "pximg.net" "highcool.ga";
        sub_filter "js_error.php" "block_js_error";
        sub_filter "www.google" "block_google";
        sub_filter_once off;
        sub_filter_types *;
    }
}
```

用了2个域名，因为cloudflare不支持3级域名证书发布，但是不知道为何用自己申请的证书开启cloudflare的full状态会出现错误页面？

## cloudflare worker

因为vps小水管加载速度不太行，因此除了  www.pixiv.net  在nginx进行反向代理（这个貌似用cloudflare worker代理不了，反正我是失败了），source.pixiv.net，pximg.net，i-cf.pximg.net（好像还有个s.pixiv.net,但是不知道为什么后面加载没遇到了）均使用cloudflare worker进行反向代理获取，都是些css，js，img类型内容，代理方式大致如下：

```js
addEventListener("fetch", event => {
  let url = new URL(event.request.url);
  url.hostname = "i.pximg.net";
  let request = new Request(url, event.request);
  event.respondWith(
    fetch(request, {
      headers: {
        'Referer': 'https://www.pixiv.net/',
        'User-Agent': 'Cloudflare Workers'
      }
    })
  );
});
```

下面那个要复杂很多，网上找的反向代理（应该可以简化的）

```js
// 替换成你想镜像的站点
const upstream = 's.pximg.net'
 
// 如果那个站点有专门的移动适配站点，否则保持和上面一致
const upstream_mobile = 's.pximg.net'
 
// 你希望禁止哪些国家访问
const blocked_region = ['RU']
 
// 禁止自访问
const blocked_ip_address = ['0.0.0.0', '127.0.0.1']
 
// 替换成你想镜像的站点
const replace_dict = {
    '$upstream': '$custom_domain',
    '//s.pximg.net': ''
}
 
//以下内容都不用动
addEventListener('fetch', event => {
    event.respondWith(fetchAndApply(event.request));
})
 
async function fetchAndApply(request) {
 
    const region = request.headers.get('cf-ipcountry').toUpperCase();
    const ip_address = request.headers.get('cf-connecting-ip');
    const user_agent = request.headers.get('user-agent');
 
    let response = null;
    let url = new URL(request.url);
    let url_host = url.host;
 

    //强制https
    if (url.protocol == 'http:') {
        url.protocol = 'https:'
        response = Response.redirect(url.href);
        return response;
    }
 

    //手机，PC端转换
    if (await device_status(user_agent)) {
        upstream_domain = upstream
    } else {
        upstream_domain = upstream_mobile
    }
 
    url.host = upstream_domain;
 
    if (blocked_region.includes(region)) {
        response = new Response('Access denied: WorkersProxy is not available in your region yet.', {
            status: 403
        });
    } else if(blocked_ip_address.includes(ip_address)){
        response = new Response('Access denied: Your IP address is blocked by WorkersProxy.', {
            status: 403
        });
    } else{
        let method = request.method;
        let request_headers = request.headers;
        let new_request_headers = new Headers(request_headers);
 
        new_request_headers.set('Host', upstream_domain);
        new_request_headers.set('Referer', url.href);
 
        let original_response = await fetch(url.href, {
            method: method,
            headers: new_request_headers
        })
 
        let original_response_clone = original_response.clone();
        let original_text = null;
        let response_headers = original_response.headers;
        let new_response_headers = new Headers(response_headers);
        let status = original_response.status;
 
        new_response_headers.set('access-control-allow-origin', '*');
        new_response_headers.set('access-control-allow-credentials', true);
        new_response_headers.delete('content-security-policy');
        new_response_headers.delete('content-security-policy-report-only');
        new_response_headers.delete('clear-site-data');
 
        const content_type = new_response_headers.get('content-type');
        if (content_type.includes('text/html') && content_type.includes('UTF-8')) {
            original_text = await replace_response_text(original_response_clone, upstream_domain, url_host);
        } else {
            original_text = original_response_clone.body
        }
 
        response = new Response(original_text, {
            status,
            headers: new_response_headers
        })
    }
    return response;
}
 
//替换
async function replace_response_text(response, upstream_domain, host_name) {
    let text = await response.text()
 
    var i, j;
    for (i in replace_dict) {
        j = replace_dict[i]
        if (i == '$upstream') {
            i = upstream_domain
        } else if (i == '$custom_domain') {
            i = host_name
        }
 
        if (j == '$upstream') {
            j = upstream_domain
        } else if (j == '$custom_domain') {
            j = host_name
        }
 
        let re = new RegExp(i, 'g')
        text = text.replace(re, j);
    }
    return text;
}
 
async function device_status (user_agent_info) {
    var agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < agents.length; v++) { if (user_agent_info.indexOf(agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}
```

## 登录问题

由于有谷歌验证，无法直接登录，无奈只能使用cookie（其实code，refresh-token，cookie好像都可以，但是无奈太菜，选择最简单的）

本想使用登录的api获取cookie的，但是网上教程的登录接口404了，新的接口传递参数不明白是什么含义，所以只能手动添加了

随便找个页面，我是在cloudflare worker，set-cookie就可以了

```js
addEventListener('fetch', event => {
  event.respondWith(addHeaders(event.request));
});

async function addHeaders(req) {
  let response = await fetch(req);
  let newHeaders = new Headers(response.headers);
  newHeaders.append("Set-Cookie", "PHPSESSID=88495727_vn2bXhRrFhcRyxVYdjZuLEnNgjkD5ZzJ; expires=Fri, 30-Dec-2022 02:32:45 GMT; Max-Age=2592000; path=/; domain=.junezate.ml; secure; HttpOnly");
  newHeaders.append("Set-Cookie", "device_token=fd4fcd47164576c1e74f0470a2ce7db0; expires=Fri, 30-Dec-2022 02:32:45 GMT; Max-Age=2592000; path=/; domain=.junezate.ml; secure; HttpOnly");
  return new Response("<a href=\"https://www.junezate.ml\">go go then go</a>", {headers: newHeaders});
}  

```



总结：说实话，这次反向代理属实有点失败，局限性还是太大了，不过对于个人使用还是没问题的吧😢

