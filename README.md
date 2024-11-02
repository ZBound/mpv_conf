### 简介：
基于 [dyphire/mpv-config](https://github.com/dyphire/mpv-config/)，精简修改添加部分组件，适配个人习惯


### 设为默认播放器教程：
进入 mpv 根目录找到 “installer” 文件夹，右键以管理员权限运行 “mpv-install.bat”


### 单击左键暂停 双击左键全屏/取消全屏 怎么改：
\portable_config\input.conf  16,17行替换成这两个
```
MBTN_LEFT        cycle pause;script-message-to uosc flash-pause-indicator
MBTN_LEFT_DBL    ignore
```
\portable_config\inputevent_key.conf 最底下加上这两行
```
MBTN_LEFT       cycle pause;script-message-to uosc flash-pause-indicator  #event:click
MBTN_LEFT       cycle fullscreen                                          #event:double_click
```

## 感谢
感谢 [mpv-player](https://github.com/mpv-player) 项目以及所有开发者们

感谢以下开源项目以及开发该项目中组件所有开发者们:


[MPV_lazy](https://github.com/hooke007/MPV_lazy)

[mpv_doc-CN](https://github.com/hooke007/mpv_doc-CN)

[mpv-config](https://github.com/dyphire/mpv-config)

[uosc](https://github.com/tomasklaen/uosc)