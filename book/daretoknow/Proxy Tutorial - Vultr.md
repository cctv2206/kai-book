# Proxy Tutorial - Vultr
# 吞下这颗红药丸 | 手把手教你科学上网
## 0. 前言
为了避免可能存在的审查，标题中就不带关键字了。目前科学上网的方式主要有两种，VPN 和 Proxy，本文将教你搭建 Proxy，即代理服务器。至于二者有什么区别，按本文提供的方法成功翻墙之后，就可以自行 Google 了。本文面向零基础用户，操作步骤会写得非常详细。

本文主要分为如下四个部分：1. 基本原理的直观描述。2. 租用 VPS (虚拟专用服务器)，含新用户奖励金。3. 安装 Shadowsocks 服务器端。4. 安装 Shadowsocks 客户端。

注意，本文中提到的绝大多数操作都需要在电脑上完成，如果你正在手机上阅读这篇文章，请在电脑上打开文章。如何做呢？第一步，收藏或分享本文。第二步，发送文章链接到电脑，可以用 email，微信，或者保存到笔记软件如印象笔记，OneNote 等。第三步，在电脑上打开。(哎第一步好像不是必须的。安妮微，请务必在电脑上阅读本文。)

## 1. 基本原理的直观描述
我们之所以不能连接到 Google，是因为我们当我们在墙内大喊「我要上Google！」的时候，墙识别到了这个信息，然后主动把这个信息挡住了。所以为了翻过这道墙，我们需要建立一个无法被墙识别的交流方式。于是我们在墙内和墙外各找了一个代理人，他们会说一种墙听不懂的语言。我们“偷偷地”在墙内跟代理人说我们要上 Google，他将我们要说的话翻译成墙听不懂的语言，然后向墙外的代理人喊话，墙外的代理人再与 Google 自由交流。如下图所示。

![](Proxy%20Tutorial%20-%20Vultr/%E5%A2%99%20%E7%A4%BA%E6%84%8F%E5%9B%BE.png)

本文的第二和第三部分将讲解如何创建一个墙外的代理人。第四部分负责安装和配置墙内的代理人。

## 2. 租一台电脑
代理人其实就是电脑程序，电脑程序自然要在电脑上运行，所以我们需要的，是一台能在墙外运行的电脑。如何能搞一台在墙外，方便我们远程控制，能够全天候运行的电脑呢？
有一些这样的公司，他们在全球各地买了很多电脑，然后把电脑租出去。这些公司就是 VPS 提供商。VPS 中的 V 是虚拟的意思，S 是服务器（也就是电脑），我们将要租来的其实是一台虚拟的电脑，那为啥不是实体而是虚拟的电脑呢？按本文提供的方法成功翻墙之后，就可以自行 Google 了。
VPS 提供商有很多，比如 Linode，Vultr，DigitalOcean 和阿里云等。本文选用 Vultr，5 美元一个月，可以和几个小伙伴一起分享。高速，稳定，价格合理。
打开[Vultr 注册链接](https://www.vultr.com/?ref=8601364-6G)，点击右上角的「Sign Up」进行注册。**请使用本文提供的**[注册链接](https://www.vultr.com/?ref=8601364-6G)**进行注册，成功注册之后，会得到 100 美元的新用户奖励金，供第一个月内随意使用。**

输入邮箱，用户名和密码，建立新帐号。
邮箱里应该收到了一封标题为「Welcome to [Vultr.com](http://vultr.com/)」的邮件 (注意查看垃圾邮件)，点击验证邮箱的链接。

![](Proxy%20Tutorial%20-%20Vultr/v2-c207483879860a64c95df92f6ad4c3d4_b.jpg)

在弹开的 Vultr 网页中设置支付方式并进行首次充值，可以使用信用卡，Paypal，Bitcoin，支付宝或微信支付。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5.jpg)

充值成功后，就可以部署我们自己的服务器啦。(页面应该自动跳转到了部署服务器的界面。如果没有的话，点击左侧菜单栏中的「Products」，然后点击屏幕右侧的蓝色加号)

### 2.1 部署一个服务器

如果在上一步注册并充值成功，页面应该自动跳转到了部署服务器的界面。如果没有的话，点击左侧菜单栏中的「Products」，然后点击屏幕右侧的蓝色加号即可。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%202.jpg)

选择左侧第一个

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%203.jpg)

选择服务器的位置，在此先选择位于日本的服务器。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%204.jpg)

为我们租的电脑选择一个操作系统，在此先选择 Ubuntu 20.04 x64 版本。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%205.jpg)

选择一个服务器的规格，价格越贵，服务器性能越强。在此选择第一个 25 GB SSD。每月只需 5 美元，拥有 25G 存储空间，单核 CPU，1G 内存，1000G 流量，足够几个人一起分享了。

点击屏幕右下方的「Deploy Now」部署我们的服务器。页面跳转到服务器列表，等待我们的服务器部署完成，状态显示「Running」。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%206.jpg)

至此，我们已经成功地租到了一台位于东京某处的电脑，获得了 100 美元奖励，并且这台电脑已经在正常运行啦。下一部分我们将在这台电脑上安装墙外代理人程序。

## 3. 安装 Shadowsocks 服务器 (墙外代理人)
Shadowsocks 服务器就是我们所说的墙外代理人，我们将这个代理人安装到我们刚刚租到的墙外的电脑上。但是如何操纵这台在美国的电脑呢？我们将使用 SSH 与这台电脑进行远程交流。SSH 可以简单地理解为两台电脑之间的一种交流方式。

### 3.1 SSH 连接到服务器
回到刚才的服务器列表页，点击服务器进入服务器详情页。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%207.jpg)

在页面左下角有我们服务器的 IP 地址，以及登录服务器需要使用的用户名和密码。为了同这台电脑进行远程交流，我们需要借助一些工具。

苹果操作系统 (macOS) 请打开 Terminal (终端) 应用。如果找不到，就请打开 Application (应用) 文件夹，搜索 Terminal。

Window 操作系统，请购买一台苹果电脑，不是，请打开 Command Prompt 应用。可以在「开始」图标的右侧搜索框中搜索「command prompt」或「cmd」，第一个搜索结果就是。

在 Terminal 或 Command Prompt 应用中输入下面这个指令，注意将「ping」后面的数字换成刚才部署的服务器的 IP 地址，按回车键执行。

```
ping 45.76.114.71
```

`ping`指令可以用于判断网络连接是否正常，在我们正式登录服务器之前，用这个指令判断一下，我们自己的电脑是否能够与部署的服务器建立稳定的网络连接。

如果执行的结果如下图所示，则说明连接正常。按`control + c`键终止测试。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%208.jpg)

如果执行的结果如下图所示，则说明与服务器连接不成功。

![](Proxy%20Tutorial%20-%20Vultr/v2-7ed2c810d7baf23c7878e713f4c508a0_b.jpg)

如果与服务器连接失败，请按照**「2.1 部署一个服务器」**的步骤重新部署一个服务器，然后用`ping`指令测试网络连接。如果依然失败，则重复这个步骤，直至找到能正常连接的服务器。之后再将无法连接的那些服务器，一个个删除掉就好了。**完全不用担心部署多个服务器会浪费钱，因为 1. 服务器的收费是按小时计的，一个 5 美元/月的服务器，每小时仅需 0.007 美元。2. 如果使用本文提供的**[链接注册](https://www.vultr.com/?ref=8601364-6G)**，会有 100 美元的新用户奖励，在第一个月内可以随意使用。**

要删掉一个服务器，只需在服务器列表右侧打开下拉菜单，点击「Server Destroy」，然后二次确认即可。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%209.jpg)

![](Proxy%20Tutorial%20-%20Vultr/v2-fa298a9f958474c8a66c99fcf01b7020_b.jpg)

确认网络连接没有问题之后，就可以正式登录到服务器了。
如果你使用的是苹果操作系统，回到刚才的 Terminal (终端) 应用，进行后续的操作。如果你使用的是 Window 操作系统，请参考百度经验[PuTTY 安装及使用教程](https://jingyan.baidu.com/article/90bc8fc8b9bca1f653640ca5.html)。

在 Terminal (终端) 应用中输入下面这条指令。注意把`@`后面的数字换成自己服务器的 IP 地址。按回车执行。

```
ssh root@45.76.216.218
```

然后你可能会看到如下的画面。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5.png)

由于我们第一次试图登录到这个陌生的地址，我们的电脑很谨慎地问我们是否要继续，输入`yes`，按回车键。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%202.png)

然后输入服务器详情页右下角的密码，建议通过复制粘贴的方式，输入密码时密码不会被显示出来，不必在意，只管输入就好。按回车确认。

![](Proxy%20Tutorial%20-%20Vultr/v2-7720bb3bfb8ba5670ee60c3ace52e5e3_b.jpg)

如果你使用的是 Windows 操作系统，请参考 [百度经验教程](https://jingyan.baidu.com/article/90bc8fc8b9bca1f653640ca5.html)，在第 4 步中填入 IP 地址，Port 一项填 22。 并在第 7 步中输入密码。

至此，我们就用 SSH 连接到墙外的那台电脑了，你应该能看到一个黑色背景的界面，上面有一行行的英文和数字，最下面一行是这样显示的。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%203.png)

root 是我们的身份，最后有一个方形的光标，用于输入指令。如果找不到，按几下回车屏幕就跳到最下一行了。我们将会在此输入一些指令，这些指令都是发送给墙外的那台电脑的。下面文章中的所有的指令，都会被单独放在一行，可以手动输入也可以复制粘贴，指令前后不需要空格，按回车键执行。

好了，输入并执行下面这个指令

```
apt-get update && apt-get upgrade
```

你会看到电脑执行了一些操作，然后可能会问你是否要继续？并给了你两个选项 `Y/n` 代表是和否。输入`y`并按回车键确认，大小写无所谓。然后又是一系列的操作，一行行文字在屏幕上闪过，很像电影里经常出现的黑客操作电脑的场景，以后再看到类似的镜头，你就知道这没什么特别的。用指令来操作电脑并不比用鼠标操作更高级。我们刚才执行的指令，是下载并安装软件更新，这有助于软件稳定与安全的运行。最好时不时执行一下这个指令。

接下来执行下面这个指令，它被称为哈哈指令。

```
haha
```

屏幕会这样显示

![](Proxy%20Tutorial%20-%20Vultr/v2-e1ca453ebf5eeb99f19e7598c719db41_b.jpg)

这代表电脑并不能识别哈哈指令。哈哈指令并不是一个真的指令，当你输错指令的时候，电脑就会说无法识别，不用紧张，检查一下指令的拼写，或者用剪切粘贴的方式，重新输入并执行一次。好的，接下来的都是真指令了。

### 3.2 安装 Shadowsocks 服务器 - 墙外代理人

Shadowsocks 有多个版本，感兴趣的同学可以去 Github 搜索 Shadowsocks。有多种方式可以安装 Shadowsocks 服务器，我们将使用最简单的一种方式，一个叫秋水逸冰的人制作了一个方便我们安装 Shadowsocks 的电脑程序。感谢秋水逸冰，欢迎大家去[他的博客 (需翻墙)](https://teddysun.com/)逛逛。

输入并执行下面这行指令。请注意这是一行指令，中间不要有换行。它的作用就是下载一个名为`shadowsocks-all.sh`的文件，这是帮助我们「一键安装」Shadowsocks 服务器的程序。

```
wget —no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
```

然后是下面这个指令

```
chmod +x shadowsocks-all.sh
```

再接再厉，执行下面这个指令将正式开始安装 Shadowsocks 服务器

```
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

屏幕上会依次出现提示语和安装选项，输入数字选择相应的选项并按回车确认即可。我们还需要为 Shadowsocks 设定一个密码，这个密码是区别于 SSH 远程登录密码的，SSH 密码用于连接墙内外两台电脑，Shadowsocks 密码用于墙内外两个代理人之间的交流。安装哪个版本的 Shadowsocks 都可以，本文以 Shadowsocks-Python 为例。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%2010.jpg)

耐心等待 Shadowsocks 安装完毕。安装完成后，屏幕上会展示 Shadowsocks 服务器的配置，一会儿我们安装 Shadowsocks 客户端的时候，会用到这些配置。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%2011.jpg)

好的，墙外的代理人已经安装完成了。代理服务器应该已经在正常运行了。下面四个指令分别用于 Shadowsocks 服务器的：启动，停止，重启和查看状态

```
/etc/init.d/shadowsocks-python start
/etc/init.d/shadowsocks-python stop
/etc/init.d/shadowsocks-python restart
/etc/init.d/shadowsocks-python status
```

如果想安装多个版本的 Shadowsocks 服务器，只需要多次运行下面这个安装指令即可

```
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

如果想要卸载 Shadowsocks 服务器，执行下面的指令，并选择想要卸载的版本。

```
./shadowsocks-all.sh uninstall
```

### 3.3 开启多个端口与其他人分享 (非必须)
如果需要和多个人分享代理服务器，我们可以设置多个端口和密码。非常简单，我们只需要更改一下 Shadowsocks 的配置文件。

执行下面这个指令。`config.json`就是 Shadowsocks 的配置文件，我们用`nano`这个文本编辑器对其进行更改。

```
nano /etc/shadowsocks-python/config.json
```

屏幕上会直接显示配置文件的内容，一个方形的光标在左上角，屏幕下方有一些选项。按方向键移动光标，像其他文本编辑器一样正常输入和删除文本。可以看到目前只有一个`server_port`和一个`password`。删除这两行，并增加`port_password`。将文件改为如下的格式

```
{
    “server”:”0.0.0.0”,
    “port_password”: {
        “1111”:”password1”,
        “2222”:”password2”
    },
    “local_address”:”127.0.0.1”,
    “local_port”:1080,
    “timeout”:300,
    “method”:”aes-256-cfb”,
    “fast_open”:true
}
```

注意文件的格式，`port_password`对应了一对大括号，里面是我们要添加的多个端口和每个端口对应的密码，不同端口和密码之间用逗号分隔。 改好了之后，按`control`加`x`键退出，输入`y`，回车保存。 之后执行下面这个指令重启 Shadowsocks 服务器。

```
/etc/init.d/shadowsocks-python restart
```

至此，我们已经安装配置好了墙外的代理人，只需最后一步，就可以科学上网了，有点激动。

## 4. 安装 Shadowsocks 客户端 - 墙内代理人
我们安装在服务器上的 Shadowsocks 版本不一定要与手机电脑上的客户端版本相同。本文以 Shadowsocks 普通版为例。下载安装客户端之后，需要输入墙外代理人的服务器配置 (服务器安装完成之后屏幕展示的红色字部分)，好让两个代理人之间能交流。

### 4.1 Mac 电脑
打开 Shadowsocks[下载地址](https://github.com/shadowsocks/ShadowsocksX-NG/releases)。点击下载最新版本 (带有`Latest release`标识)的 ShadowsocksX-NG 文件。

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%2012.jpg)

解压 zip 文件后将`ShadowsocksX-NG.app`文件移到 Application (应用) 文件夹里就可以使用了。 运行应用后，点击屏幕最上方状态栏的「小飞机」图标，然后在下拉菜单中选择「服务器 -> 服务器设置」。在窗口右下角点击「+」号按钮添加一个服务器。输入我们服务器端的配置，就是刚才截图中红色的部分，分别是 IP 地址、Port 端口、加密方式和密码四项。

![](Proxy%20Tutorial%20-%20Vultr/v2-8c8f83ac61a3d2883525aefea0207ac7_b.jpg)

填好后按确定保存。 在小飞机的主菜单中选择开启或关闭 Shadowsocks。

### 4.2 Windows 电脑
打开 Shadowsocks[下载地址](https://github.com/shadowsocks/shadowsocks-windows/releases)。下载最新版本 (带有`Latest release`标识) 的`shadowsocks zip`文件，解压缩后将 Shadowsocks.exe 文件移到一个全英文的路径下 (例如 C:\Program Files\Shadowsocks.exe)，然后用管理员权限运行 (鼠标右键 -> 用管理员权限运行 / Run as administrator)。添加并配置服务器的参数 (同上)。右下角的系统工具栏里会出现「小飞机」图标，右键可以打开 Shadowsocks 的菜单。

### 4.3 iOS
从应用商店中下载 Potatso Lite。注意，苹果已经将所有的 VPN 类 APP 从中国的应用商店中移除了。所以如果你搜索不到这个 app，你可能需要将苹果帐号的「国家/地区」改成美国，更改的方式请参考[苹果官方技术支持](https://support.apple.com/zh-cn/HT201389)。 打开 Potatso Lite 后，直接添加 proxy，选择手动添加，然后输入服务器的信息。首次开启时，手机可能会问你是否开启 vpn 权限，当然是。开启 shadowsocks 时手机最上方的状态栏应该会出现 vpn 的小图标。

### 4.4 Android
用手机浏览器打开 Shadowsocks[下载地址](https://github.com/shadowsocks/shadowsocks-android/releases)。 找到带有`Latest release`标识的版本，点击 Assets 展开可下载的文件，点击下载 apk 文件，下载完毕后打开文件安装 APP。打开 APP，输入服务器的设置，点右上角的圆形图标开启 / 关闭服务。开启时手机最上方状态栏应该会出现 vpn 的小图标。

## 5. 其他
### 5.1 关于 PAC 模式和 Global 模式
Global 模式下，访问任何网站都会通过墙外的代理服务器，这会导致访问国内网站时网速过慢。 使用 PAC 模式时，Shadowsocks 会读取 PAC 文件里的规则，判断要访问的网站是否被墙，如果是，就通过墙外的代理服务器访问。这个模式的问题是，有很多网站其实没有被墙，但是直接在墙内访问时网速超慢。感兴趣的同学可以研究一下如何配置 PAC 文件。 在我看来最简单可行的使用方式，就是根据自己要访问的网站，随时切换模式或开关代理服务器。

### 5.2 关于 VPS 的选择
之前我个人一直使用 Linode，网速很稳，不容易被封。但是近期发现在 Linode 的登录过程中，会调用到 facebook 的服务，这意味着在科学上网之前，是无法注册或登录 Linode 的，不适宜大家从零开始搭建代理服务器。如果有人想在 Linode 上搭建服务器的话，可以使用这个[注册链接](https://www.linode.com/?r=4ae052ea06605760e53d092ea6cc91c0caf1b214)。

## 6. 常见问题及解决方案 Troubleshooting
### 6.1 登录 Vultr 时网页无反应
有时候登录 Vultr 会出现页面卡住的情况，此时直接刷新页面，就可成功登录。

### 6.2 开启 Shadowsocks 后无法上网
偶尔会遇到开启了 shadowsocks ，却无法打开任何网站的情况。这可能是因为墙把我们的墙外的代理人给封了，此时可按照上文中「2.1 部署一个服务器」及「3. 安装 Shadowsocks 服务器 (墙外代理人)」两部分，重新部署服务器并安装墙外代理人即可。

- - - -

有任何问题，请直接联系我。如果喜欢本文，就请作者喝杯咖啡吧。

> Some of us need the occasional coffee to survive.  

![](Proxy%20Tutorial%20-%20Vultr/%E6%9C%AA%E7%9F%A5%2013.jpg)

> 参考资料  
> [Getting Started with Linode](https://www.linode.com/docs/getting-started/)  
> [How to setup a FAST Shadowsocks server (Nov 2019 update)](https://www.tipsforchina.com/how-to-setup-a-fast-shadowsocks-server-on-vultr-vps-the-easy-way.html)  
> [https://teddysun.com](https://teddysun.com/)  
> [Shadowsocks PAC模式和全局模式的区别](https://www.zybuluo.com/gongzhen/note/472805)  
  

#gitbook/DareToKnow