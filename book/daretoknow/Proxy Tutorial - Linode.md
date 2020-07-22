# Proxy Tutorial - Linode
# 吞下这颗红药丸 | 手把手教你科学上网
## 0. 前言
为了避免可能存在的审查，标题中就不带关键字了。目前科学上网的方式主要有两种，VPN 和 Proxy，本文将教你搭建 Proxy，即代理服务器。至于二者有什么区别，按本文提供的方法成功翻墙之后，就可以自行 Google 了。本文面向零基础用户，操作步骤会写得非常详细。

本文分为如下四个部分：1.基本原理的直观描述。2.租用 VPS (虚拟专用服务器)，含优惠码。3.安装 Shadowsocks 服务器端。4.安装 Shadowsocks 客户端。

注意，本文中提到的绝大多数操作都需要在电脑上完成，如果你正在手机上读这篇文章，请在电脑上打开文章。如何做呢？第一步，将文章分享到朋友圈或微博。第二步，发送文章链接到电脑，可以用 email，微信，或者保存到笔记软件如 OneNote，有道云笔记。第三步，在电脑上打开。（哎第一步好像不是必须的。安妮微，请务必在电脑上阅读本文。）

## 1.基本原理的直观描述
我们之所以不能连接到 Google，是因为我们当我们在墙内大喊“我要上Google！”的时候，墙识别到了这个信息，然后主动把这个信息挡住了。所以为了翻过这道墙，我们需要建立一个无法被墙识别的交流方式。于是我们在墙内和墙外各找了一个代理人，他们会说一种墙听不懂的语言。我们“偷偷地”在墙内跟代理人说我们要上 Google，他将我们要说的话翻译成墙听不懂的语言，然后向墙外的代理人喊话，墙外的代理人再与 Google 自由交流。如下图所示。

![](Proxy%20Tutorial%20-%20Linode/%E5%A2%99%20%E7%A4%BA%E6%84%8F%E5%9B%BE.png)

本文的第二和第三部分将讲解如何创建一个墙外的代理人。第四部分负责安装和配置墙内的代理人。

## 2. 租一台电脑
代理人其实就是电脑程序，电脑程序自然要在电脑上运行，所以我们需要的，是一台能在墙外运行的电脑。如何能搞一台在墙外，方便我们远程控制，能够全天候运行的电脑呢？

你可以在国外买一套房，安装网络，买一台电脑，插上电让它一直运行。不现实。你也可以把电脑放在国外的亲戚朋友家，用他们家的电，上他们家的网。但是如果他们搬家了怎么办，一言不合友尽了怎么办？不稳定。

所以，最好还是寻求专业的服务。有一些这样的公司，他们在全球各地买了很多电脑，然后把电脑租出去。这些公司就是 VPS 提供商。VPS 中的 V 是虚拟的意思，S 是服务器（也就是电脑），我们将要租来的其实是一台虚拟的电脑，那为啥不是实体而是虚拟的电脑呢？按本文提供的方法成功翻墙之后，就可以自行 Google 了。

VPS 提供商有很多，比如 Linode，Vultr，DigitalOcean 和阿里云等。本文选用 Linode，5美元一个月，可以和几个小伙伴一起分享。高速，稳定，价格合理。

### 2.1 注册
打开[Linode官网首页](https://www.linode.com)，输入邮箱，用户名，密码。建立新帐号。

![](Proxy%20Tutorial%20-%20Linode/linode%E6%B3%A8%E5%86%8C.png)

验证邮箱时，一个新网页会自动被打开，点击灰色按钮完善账户的注册。

![](Proxy%20Tutorial%20-%20Linode/%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81.png)

![](Proxy%20Tutorial%20-%20Linode/%E9%82%AE%E7%AE%B1%E9%AA%8C%E8%AF%81%E5%90%8E.png)

填写个人信息，优惠码和推荐码。

![](Proxy%20Tutorial%20-%20Linode/%E6%B3%A8%E5%86%8C%E5%AE%8C%E5%96%84%E4%B8%AA%E4%BA%BA%E8%B5%84%E6%96%99.png)

promotion code(优惠码)：`Linode10`
注册成功之后，会直接获得10美元奖励，相当于免费用两个月。

referral code(推荐码)：`4ae052ea06605760e53d092ea6cc91c0caf1b214`
请大家用这个推荐码，注册成功并持续使用这个帐号3个月，作者可以获得一点奖励，谢谢大家。

![](Proxy%20Tutorial%20-%20Linode/super%20power.gif)

使用 Visa, MasterCard, American Express 或 Discover 信用卡进行充值，首次充值可选5，20或50美元。阅读（或者不阅读）并同意各种协议。点击网页最下方灰色按按钮完成注册。

然后打开菜单中的第一项 Linode 选择一个虚拟机。选择第一个 Nanode 1G。每月只需5美元，拥有 25G 存储空间，单核 CPU，1TB 流量，足够几个人一起分享了。在网页下方的列表里选择服务器的位置。选之前可以测试一下哪里的服务器速度最快。用浏览器打开官方的[速度测试网站](https://www.linode.com/speedtest)。点击表格右侧的链接，浏览器会自动从相应的服务器下载一个大小为100M的文件，找一个下载速度比较快的服务器。

![](Proxy%20Tutorial%20-%20Linode/%E4%B8%8B%E8%BD%BD%E9%80%9F%E5%BA%A6%E6%B5%8B%E8%AF%95.png)

我测试是位于日本的服务器最快最稳定，但本文在此先选择位于Atlanta,  GA的服务器，以后也可以重新选择。点击“添加这个 Linode！”

![](Proxy%20Tutorial%20-%20Linode/%E9%80%89linode.png)

点击在列表中刚刚创建的服务器，进入服务器的监控页面。

![](Proxy%20Tutorial%20-%20Linode/%E9%83%A8%E7%BD%B2%E4%B8%80%E4%B8%AA%E9%95%9C%E5%83%8F.png)

在 Image 这一项选择一个你喜欢的操作系统，本文在此选择 Ubuntu 18.04 LTS。设置一个密码（root password），记好，以后远程登录服务器的时候会使用。点击“Deploy”，页面跳回刚才的监控页面。

![](Proxy%20Tutorial%20-%20Linode/%E9%80%89%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F.png)

页面中下方 Host Job Queue 区域可以看到当前的进程，等任务都完成后就可以点击上方的“Boot”按钮。

![](Proxy%20Tutorial%20-%20Linode/%E5%90%AF%E5%8A%A8%EF%BC%81.png)

页面刷新后会看到在 Host Job Queue 区域又多了一项任务，等该任务完成之后，会看到在页面右侧的 Server Status（服务器状态）区域，服务器的状态从 Powered Off（关闭）变成了 Running（正在运行）。至此，我们成功地租到了一台位于美国乔治亚州某处的电脑，获得了10美元奖励，并且这台电脑已经在正常运行啦。下一部分我们将在这台电脑上安装墙外代理人程序。

## 3.安装 Shadowsocks 服务器（墙外代理人）
Shadowsocks 服务器就是我们所说的墙外代理人，我们将这个代理人安装到我们刚刚租到的墙外的电脑上。但是如何操纵这台在美国的电脑呢？我们将使用 SSH 与这台电脑进行远程交流。SSH 可以简单地理解为两台电脑之间的一种交流方式。

### 3.1 SSH 连接到服务器（必做）
回到刚才的 linode 服务器监控页面，点击页面上方的“remote access”按钮。表格的第一行，SSH Access  (SSH 访问) 后面写了这样一些字符（@后面的数字每个人都不一样）
```
ssh root@74.207.232.54
```
这其实是一行指令，将指令发送给电脑，电脑就会照我们说的做，非常听话。先解释一下这条指令，`ssh`就是告诉电脑我们要用 `ssh` 远程访问一台电脑，`@` 后面的用点分割的四个数字是远程电脑的`ip address` (电脑在网络中的地址)，类似于我们的家庭住址，全球唯一。有唯一的家庭地址，快递和外卖才能送到我们家里。有了计算机的IP地址，我们才能远程访问。`@`前面的`root`，代表我们要用`root`这个身份进行远程访问。（不必纠结为啥叫 root，老根儿）

如何将这条指令发送给电脑呢？我们需要一些小工具。
如果你使用的是 Linux 操作系统，你应该知道怎么做。
如果你使用的是苹果的操作系统（macOS），请打开Terminal（终端）应用。如果找不到，就请打开应用（Application）文件夹，搜索 Terminal。
如果你使用的是 Window 操作系统，请购买一台苹果电脑。或者，下载  PuTTY 应用。请参考百度经验[PuTTY安装及使用教程](https://jingyan.baidu.com/article/90bc8fc8b9bca1f653640ca5.html)

然后将 SSH Access 后面的这些字符输入到 Linux 命令行或苹果的终端应用中（可以用复制粘贴的方式），按回车键，发指令给电脑。然后你可能会看到如下的画面。

![](Proxy%20Tutorial%20-%20Linode/%E9%A6%96%E6%AC%A1ssh.png)

由于我们第一次试图连接到这个陌生的地址，我们的电脑很谨慎地问我们是否要继续，输入`yes`，按回车键。然后输入刚才在配置服务器时设置的密码（root password），输入密码时密码不会被显示出来，不必在意，只管输入就好。按回车确认。

如果你使用的是  Windows 操作系统，请参考百度经验教程，在第4步中填入 IP address，Port 一项填22。 在第7步中输入刚才设置的密码。

至此，我们就用 SSH 连接到墙外的那台电脑了，你应该能看到一个黑色背景的界面，上面有一行行的英文和数字，最下面一行是这样显示的

![](Proxy%20Tutorial%20-%20Linode/last%20line.png)

root 是我们的身份，最后有一个方形的光标，用于输入指令。如果找不到，按几下回车屏幕就跳到最下一行了。我们将会在此输入一些指令，这些指令都是发送给墙外的那台电脑的。下面文章中的所有的指令，都会被单独放在一行，可以手动输入也可以复制粘贴，指令前后不需要空格，按回车键执行。

好了，输入并执行下面这个指令
```
apt-get update && apt-get upgrade
```
你会看到电脑执行了一些操作，然后可能会问你是否要继续？并给了你两个选项`[Y/n]`代表是和否。输入 y 并按回车键确认，大小写无所谓。然后又是一系列的操作，一行行文字在屏幕上闪过，很像电影里经常出现的黑客操作电脑的场景，以后再看到类似的镜头，你就知道这没什么特别的。用指令来操作电脑并不比用鼠标操作更高级。我们刚才执行的指令，是下载并安装软件更新，这有助于软件稳定与安全的运行。最好时不时执行一下这个指令。

接下来执行下面这个指令，它被称为哈哈指令。
```
haha
```
屏幕会这样显示

![](Proxy%20Tutorial%20-%20Linode/haha%20command.png)

这代表电脑并不能识别哈哈指令，并问你是不是想输入别的指令。哈哈指令并不是一个真的指令，当你输错指令的时候，电脑就会说无法识别，不用紧张，检查一下指令的拼写，或者用剪切粘贴的方式，重新输入并执行一次。好的，接下来的都是真指令了。

### 3.2 安装 Shadowsocks 服务器 - 墙外代理人（必做）

Shadowsocks 有多个版本，感兴趣的同学可以去 Github 搜索 Shadowsocks。有多种方式可以安装 Shadowsocks 服务器，我们将使用最简单的一种方式，一个叫秋水逸冰的人制作了一个方便我们安装 Shadowsocks 的电脑程序。感谢秋水逸冰，欢迎大家去[他的博客](http://teddysun.com)逛逛。

输入并执行下面这行指令。请注意这是一行指令，中间不要有换行。它的作用就是下载一个叫`shadowsocks-all.sh`的文件，这是帮助我们“一键安装” Shadowsocks 服务器的程序。
```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
```
然后是下面这个指令
```
chmod +x shadowsocks-all.sh
```
再接再厉，执行下面这个指令将正式开始安装Shadowsocks服务器
```
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```
屏幕上会依次出现提示语和安装选项，输入数字选择相应的选项并按回车确认即可。我们还需要为 Shadowsocks 设定一个密码，这个密码是区别于 SSH 远程登录密码的，SSH 密码用于连接墙内外两台电脑，Shadowsocks 密码用于墙内外两个代理人之间的交流。安装哪个版本的 Shadowsocks 都可以，本文以 Shadowsocks-Python 为例。

![](Proxy%20Tutorial%20-%20Linode/ss%20python%20%E5%AE%89%E8%A3%85.png)

![](Proxy%20Tutorial%20-%20Linode/ss%20python%20%E5%AE%89%E8%A3%85%E5%AE%8C%E6%88%90.png)

好的，墙外的代理人已经安装完成了。代理服务器应该已经在正常运行了。下面四个指令分别用于 Shadowsocks 服务器的：启动，停止，重启和查看状态
```
/etc/init.d/shadowsocks-python start
/etc/init.d/shadowsocks-python stop
/etc/init.d/shadowsocks-python restart
/etc/init.d/shadowsocks-python status
```

如果想安装多个版本的  Shadowsocks  服务器，只需要多次运行下面这个安装指令即可

```
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```
如果想要卸载 Shadowsocks 服务器，执行下面的指令，并选择想要卸载的版本。
```
./shadowsocks-all.sh uninstall
```

### 3.3 开启多个端口与其他人分享 （选做）
如果需要和多个人分享代理服务器，我们可以设置多个端口和密码。非常简单，我们只需要更改一下 Shadowsocks 的配置文件。

执行下面这个指令。`config.json` 就是 Shadowsocks 的配置文件，我们用 nano 这个文本编辑器对其进行更改。

```
nano /etc/shadowsocks-python/config.json
```

屏幕上会直接显示配置文件的内容，一个方形的光标在左上角，屏幕下方有一些选项。按方向键移动光标，像其他文本编辑器一样正常输入和删除文本。可以看到目前只有一个`server_port`和一个`password`。删除这两行，并增加`port_password`。将文件改为如下的格式：

```
{
    "server":"0.0.0.0",
    "port_password": {
        "1111":"password1",
        "2222":"password2"
    },
    "local_address":"127.0.0.1",
    "local_port":1080,
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open":true
}
```
注意文件的格式，`port_password`后面一个冒号，之后是一对大括号，括号后面一个逗号，括号里面是我们要添加的多个端口和每个端口对应的密码，不同端口和密码之间用逗号分隔。
改好了之后，按 control 加 x 键退出，输入 y，回车保存。
之后执行下面这个指令重启  Shadowsocks 服务器。
```
/etc/init.d/shadowsocks-python restart
```

其他 Shadowsocks 版本的多端口配置请参考[秋水逸冰的博客](https://teddysun.com/532.html)

至此，我们已经安装配置好了墙外的代理人，只需最后一步，就可以科学上网了，有点激动。

## 4.安装 Shadowsocks 客户端 - 墙内代理人
我们安装在服务器上的 Shadowsocks 版本不一定要与手机电脑上的客户端版本相同。本文以 Shadowsocks 普通版为例。下载安装客户端之后，需要输入墙外代理人的服务器配置（刚才截图中红色字的部分），好让两个代理人之间能交流。

### 4.1 Mac 电脑
Shadowsocks [下载地址](https://github.com/shadowsocks/ShadowsocksX-NG/releases)
点击下载最新版本的`ShadowsocksX-NG.dmg`文件。打开文件后将 ShadowsocksX-NG-R8.app 文件移到Application（应用）文件夹里就可以使用了。
运行应用后，点击屏幕最上方状态栏的“小飞机”图标，然后在 Server 菜单中打开 Server Preference 窗口。在窗口右下角点击“+”号按钮添加一个 server。输入我们服务器端的配置，就是刚才截图中红色的部分。端口填在“:”号后面。填好后按 OK 保存。
在小飞机的主菜单中选择开启或关闭 Shadowsocks。

### 4.2 Windows 电脑
Shadowsocks [下载地址](https://github.com/shadowsocks/shadowsocks-windows/releases)
找到带有`Latest release`标识的版本，点击下载 zip 文件，解压缩后将 Shadowsocks.exe 文件移到一个全英文的路径下（例如 `C:\Program Files\Shadowsocks.exe`），然后用管理员权限运行。添加并配置服务器的参数。右下角的系统工具栏里会出现“小飞机”图标，右键可以打开 Shadowsocks 的菜单。

### 4.3 iOS
从应用商店中下载 Potatso Lite。注意，苹果已经将所有的 VPN 类 APP 从中国的应用商店中移除了。所以如果你搜索不到这个 app，你可能需要将苹果帐号的国家/地区改成美国，更改的方式请参考[苹果官方技术支持](https://support.apple.com/zh-cn/HT201389)。
打开 Potatso Lite 后，直接添加 proxy，选择手动添加，然后输入服务器的信息。添加完成后点“start_stop”按钮开启_关闭服务，手机可能会问你是否开启 vpn 权限，当然是。开启时手机最上方的状态栏应该会出现 vpn 的小图标。

### 4.4 Android
用手机浏览器打开下载地址。
Shadowsocks [下载地址](https://github.com/shadowsocks/shadowsocks-android/releases)
找到带有“Latest release”标识的版本，点击 Assets 展开可下载的文件，点击下载 apk 文件，下载完毕后打开文件安装 APP。打开 APP，输入服务器的设置，点右上角的圆形图标开启/关闭服务。开启时手机最上方状态栏应该会出现 vpn 的小图标。

### 4.5 关于 PAC 模式和 Global 模式
Global 模式下，访问任何网站都会通过墙外的代理服务器，这会导致访问国内网站时网速过慢。
使用 PAC 模式时，Shadowsocks 会读取 PAC 文件里的规则，判断要访问的网站是否被墙，如果是，就通过墙外的代理服务器访问。这个模式的问题是，有很多网站其实没有被墙，但是直接在墙内访问时网速超慢。感兴趣的同学可以研究一下如何配置 PAC 文件。
在我看来最简单可行的使用方式，就是根据自己要访问的网站，随时切换模式或开关代理服务器。

## 5. 结束
确保 Shadowsocks 的服务器和客户端都正常运行，就可以科学上网了。
测试一下网速，YouTube 自动选择了 1080p 的视频质量。非常好。

![](Proxy%20Tutorial%20-%20Linode/youtube%201080.png)

转载不用注明出处，不要更改邀请码和打赏地址就好了。如果喜欢本文，就请作者喝杯咖啡吧。Some of us need the occasional coffee to survive.

WeChat: 
![](Proxy%20Tutorial%20-%20Linode/Screen%20Shot%202018-08-20%20at%2011.54.16%20AM.png)

ETH: 0xe594eb449BA29759919E5BD7E003Ee11952AFa3E

> 参考资料  
>   
> https://www.linode.com/docs/getting-started/  
> https://www.tipsforchina.com/how-to-setup-a-fast-shadowsocks-server-on-vultr-vps-the-easy-way.html  
> https://teddysun.com/532.html  
> https://teddysun.com/486.html  
> https://www.zybuluo.com/gongzhen/note/472805  

#gitbook/DareToKnow