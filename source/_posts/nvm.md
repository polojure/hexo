---
link: null
title: nvm文档手册 - nvm是一个nodejs的版本管理工具
description: NVM中文网:nvm一个nodejs的版本管理工具,为windows或mac提供nodejs各种版安装配置详情教程,包括nvm安装,nvm教程,nvm命令中文文档教程。
keywords: nvm,nvm管理工具,nvm安装,nvm教程,nvm命令
author: null
date: 2022.11.14
publisher: nvm
stats: paragraph=77 sentences=97, words=352
updated:
type: 
comments:
top_img: https://img-cnd.noel.ga/blog/covers/2.jpg
mathjax:
katex:
aside:
aplayer:
highlight_shrink:
---
### nvm是什么

nvm全英文也叫node.js version management，是一个nodejs的版本管理工具。nvm和n都是node.js版本管理工具，为了解决node.js各种版本存在不兼容现象可以通过它可以安装和切换不同版本的node.js。

### nvm下载

可在点此在[github](https://github.com/coreybutler/nvm-windows/releases)上下载最新版本,本次下载安装的是windows版本。打开网址我们可以看到有两个版本：

* [nvm 1.1.7-setup.zip](/nvm1.1.7-setup.zip)：安装版，推荐使用
* [nvm 1.1.7-noinstall.zip](/nvm1.1.7-noinstall.zip): 绿色免安装版，但使用时需进行配置。

### nvm安装

1. **卸载之前的node后安装nvm**, nvm-setup.exe安装版，直接运行nvm-setup.exe

![](https://nvm.uihtm.com//images/step1.png)

2.选择nvm安装路径

![](https://nvm.uihtm.com//images/step2.png)

3.选择nodejs路径

![](https://nvm.uihtm.com//images/step3.png)

4.确认安装即可

![](https://nvm.uihtm.com//images/step4.png)

5.安装完确认

![](https://nvm.uihtm.com//images/step5.png)

打开CMD，输入命令 `nvm` ，安装成功则如下显示。可以看到里面列出了各种命令，本节最后会列出这些命令的中文示意。

### nvm命令提示

* `nvm arch`：显示node是运行在32位还是64位。
* `nvm install <version> [arch]</version>` ：安装node， version是特定版本也可以是最新稳定版本latest。可选参数arch指定安装32位还是64位版本，默认是系统位数。可以添加--insecure绕过远程服务器的SSL。
* `nvm list [available]` ：显示已安装的列表。可选参数available，显示可安装的所有版本。list可简化为ls。
* `nvm on` ：开启node.js版本管理。
* `nvm off` ：关闭node.js版本管理。
* `nvm proxy [url]` ：设置下载代理。不加可选参数url，显示当前代理。将url设置为none则移除代理。
* `nvm node_mirror [url]` ：设置node镜像。默认是https://nodejs.org/dist/。如果不写url，则使用默认url。设置后可至安装目录settings.txt文件查看，也可直接在该文件操作。
* `nvm npm_mirror [url]` ：设置npm镜像。https://github.com/npm/cli/archive/。如果不写url，则使用默认url。设置后可至安装目录settings.txt文件查看，也可直接在该文件操作。
* `nvm uninstall <version></version>` ：卸载指定版本node。
* `nvm use [version] [arch]` ：使用制定版本node。可指定32/64位。
* `nvm root [path]` ：设置存储不同版本node的目录。如果未设置，默认使用当前目录。
* `nvm version` ：显示nvm版本。version可简化为v。

### 安装node.js版本

`nvm list available` 显示可下载版本的部分列表

![](https://nvm.uihtm.com//images/nvm-list-available.png)

`nvm install latest`安装最新版本 ( 安装时可以在上面看到 node.js 、 npm 相应的版本号 ，不建议安装最新版本)

![](https://nvm.uihtm.com//images/nvm-install-latest.png)

`nvm install` 版本号 安装指定的版本的nodejs

![](https://nvm.uihtm.com//images/nvm-install-node.png)

### 查看已安装版本

`nvm list`或 `nvm ls`查看目前已经安装的版本 （ 当前版本号前面没有 * ， 此时还没有使用任何一个版本，这时使用 node.js 时会报错 ）

![](https://nvm.uihtm.com//images/nvm-list1.png)![](https://nvm.uihtm.com//images/nvm-list2.png)

### 切换node版本

`nvm use`版本号 使用指定版本的nodejs （ 这时会发现在启用的 node 版本前面有 * 标记，这时就可以使用 node.js ）

![](https://nvm.uihtm.com//images/nvm-use.png)

### nvm常见问题

如果下载node过慢，请更换国内镜像源, 在 nvm 的安装路径下，找到 settings.txt，设置node_mirro与npm_mirror为国内镜像地址。下载就飞快了~~

root: D:\nvm
path: D:\nodejs
node_mirror: https://npm.taobao.org/mirrors/node/
npm_mirror: https://npm.taobao.org/mirrors/npm/

### 赞助我们

![](https://nvm.uihtm.com//images/pay.png)

## NVM For Linux

下载链接: [https://pan.baidu.com/s/1pRIlge6-OoD54YLo1ecVJg?pwd=2ct5](https://pan.baidu.com/s/1pRIlge6-OoD54YLo1ecVJg?pwd=2ct5) 提取码: 2ct5

下载压缩包

```
cd /
wget https://github.com/nvm-sh/nvm/archive/refs/tags/v0.39.1.tar.gz
```

解压

```
mkdir -p /.nvm
tar -zxvf nvm-0.39.0.tar.gz -C /.nvm
```

配置环境

```
vim ~/.bashrc
```

在~/.bashrc的末尾，添加如下语句：

```
export NVM_DIR="$HOME/.nvm/nvm-0.38.0"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

使能配置

```
source ~/.bashrc
```

使用NVM安装node v8.16.0

```
nvm install 8.16.0
```

切换node版本

```
nvm use 14.17.3
```

## 在 Mac 下安装 nvm 管理 node

在使用 `node` 的过程中，用 `npm` 安装一些模块，特别是全局包的时候，由于 `Mac` 系统安全性的限制，经常出现安装没有权限，或者安装完成使用时出现 `Command not found` 的情况。

之前我都是通过使用修改权限的方式来解决，但是太麻烦又感觉不太安全，于是我就到网上找解决的方法，发现其实官方也是推荐我们使用 `node` 的管理工具来解决这个问题的。官方推荐了两个 `n` 和 `nvm`，这里我选择的是 `nvm`。

至于两者的区别可以看一下淘宝团队的一篇文章[管理node版本，选择nvm还是n？](https://fed.taobao.org/blog/taofed/do71ct/nvm-or-n/?spm=taofed.homepage.header.7.7eab5ac8dDRkRS)

### Mac 安装

在 `Mac` 下 `nvm` 的安装和遇到的问题。

> 注意：不要使用 `Homebrew`安装 `nvm`，这个在 `nvm`的官方文档中有说明。

具体的步骤如下：首先打开终端，进入当前用户的 home 目录中。

```
cd ~
```

然后使用 `ls -a` 显示这个目录下的所有文件（夹）（包含隐藏文件及文件夹），查看有没有 `.bash_profile` 这个文件。

```
ls -a
```

如果没有，则新建一个。

```
touch ~/.bash_profile
```

如果有或者新建完成后，我们通过官方的说明在终端中运行下面命令中的一种进行安装：

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```

```
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
```

在安装完成后，也许你会在终端输入 `nvm` 验证有没有安装成功，这个时候你会发现终端打出 `Command not found`，其实这并不是没有安装成功，你只需要重启终端就行，再输入 `nvm` 就会出现 `Node Version Manager` 帮助文档，这表明你安装成功了。

## 注意

这里需要注意的几点就是：

第一点 不要使用 `homebrew` 安装 `nvm`

第二点 关于 `.bash_profile` 文件。如果用户 `home` 目录下没有则新建一个就可以了，不需要将下面的两段代码写进去，因为你在执行安装命令的时候，系统会自动将这两句话写入 `.bash_profile` 文件中。

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

网络上我找了好多文章都是说在安装前先手动将下面这两句话写进去，经过测试是不正确的，并且会造成安装不成功，这一点需要注意一下。

```
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

第三点 保证 `Mac` 中安装了 `git`，一般只要你下载了 `Mac` 的 `Xcode` 开发工具，它是自带 `git` 的。
