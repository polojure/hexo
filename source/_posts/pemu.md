---
title: qemu半虚拟化技术
date: 2022.11.16
updated:
type: 
comments:
description:
keywords:
top_img: 
mathjax:
katex:
aside:
aplayer:
highlight_shrink:
---
基本原理：用qemu-user半虚拟化技术与Docker技术融合。  
实验环境：Ubuntu16.04 (Ubuntu14.04亲测可用) docker version 1.13.0  
首先，安装qemu-user安装包，并更新qemu-arm的状态：

``` bash
apt-get update && apt-get install -y --no-install-recommends qemu-user-static binfmt-support
update-binfmts --enable qemu-arm
update-binfmts --display qemu-arm
sudo chmod a+x /usr/bin/qemu-*
```

查看qemu-arm的版本：

``` bash
qemu-arm-static -version
```

然后下载arm架构的容器：

``` bash
docker pull ioft/armhf-ubuntu:trusty
（docker hub上有各类其他版本，也可以下载使用）
docker run -itd --privileged -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static ioft/armhf-ubuntu:trusty /bin/bash（永久有效的容器）
```

最后进入容器访问：

``` bash
docker exec -it COTAINER_ID /bin/bash
```

参考文献：  
[Run ARM Docker images on x86\_64 hosts](https://blog.ubergarm.com/#/blog/archive/archive-arm-docker-images-on-x86-64)

 

  

本文转自 [https://blog.csdn.net/sunSHINEEzy/article/details/80015638](https://blog.csdn.net/sunSHINEEzy/article/details/80015638)，如有侵权，请联系删除。