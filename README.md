
## 钉钉群机器人是什么？

群机器人是钉钉群的高级扩展功能。群机器人可以将第三方服务的信息聚合到群聊中，实现自动化的信息同步。例如：通过聚合GitHub，GitLab等源码管理服务，实现源码更新同步；通过聚合Trello，JIRA等项目协调服务，实现项目信息同步。不仅如此，群机器人支持Webhook协议的自定义接入，支持更多可能性，例如：你可将运维报警提醒通过自定义机器人聚合到钉钉群。

关于如何创建机器人，获取webhook，以及其他更多详细信息请参考[自定义机器人](https://open-doc.dingtalk.com/microapp/serverapi2/qf2nxq)

## 消息类型及数据格式

### 配置webhook

首先配置申请的webhook。

```
webhook <- 'https://oapi.dingtalk.com/robot/send?access_token=your_token'
```

### text类型

```
sendChat(
  webhook = webhook, msgtype = 'text',
  content = "妞妞最可爱",
  atMobiles = list('152****7197'))
```

### link类型

```
sendChat(
  webhook = webhook, msgtype = 'link',
  title = '中"毒"已深',
  text = '有 "毒" 的 \n 运动x潮流x装备',
  messageUrl = 'http://www.poizon.com',
  picUrl = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png')
```

### markdown类型

```
sendChat(
  webhook = webhook, msgtype = 'markdown',
  title = '上海天气',
  text = paste0(
    '#### 上海天气\n',
    '> 14度，东北风2级，空气良53，相对温度48%\n\n',
    '> ![spring](http://www.ccdi.gov.cn/lswh/wenhua/wyzd/201803/W020180301632355806894.jpg)\n',
    '> ###### 10点20分发布 [天气](https://www.seniverse.com/) \n'))
```

### 整体跳转actionCard类型

```
sendChat(
  webhook = webhook, msgtype = 'actionCard',
  title = '中"毒"已深',
  text = "![Du APP](https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png) \n ### 有 "毒" 的 运动x潮流x装备 \n 球鞋鉴别靠谱有效，你喜欢的不容错过，看上就买严格把控，志趣相投玩在一起，商家入驻优惠快捷",
  singleTitle = "阅读全文",
  singleURL = 'http://www.poizon.com/')
```

### 独立跳转actionCard类型

```
sendChat(
  webhook = webhook, msgtype = 'actionCard',
  title = '中"毒"已深',
  text = '![Du APP](https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png) \n ### 有 "毒" 的 \n 运动x潮流x装备',
  btns = list(
    list(title = '内容不错', actionURL = 'http://www.poizon.com/'),
    list(title = '不感兴趣', actionURL = 'http://www.poizon.com/')
  ))
```

### feedCard类型

```
links <- list(
  list(title = '毒APP',
       messageURL = 'http://www.poizon.com',
       picURL = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png'),
  list(title = '中"毒"已深',
       messageURL = 'http://www.poizon.com',
       picURL = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png'))
sendChat(
  webhook = webhook, msgtype = 'feedCard',
  links = links)
```

