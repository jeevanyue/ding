#' DingTalk Robot send message
#'
#' @param webhook Webhook applied on Dingtalk
#' @param content Message content
#' @param title Message title
#' @param text Message text
#' @param messageUrl Message URL
#' @param picUrl Picture URL
#' @param singleTitle Title of the single button. when singleTitle and singleURL are set, btns option is not available.
#' @param singleURL The URL of the singleTitle button
#' @param btns Button information list. Including title(button title), actionURL(the URL triggered by clicking the button). when singleTitle and singleURL are set, btns option is not available.
#' @param btnOrientation btns arranged direction, Vertical or horizontal. 0-vertically, 1-horizontally.
#' @param hideAvatar The sender's profile picture, 0-show, 1-hide
#' @param links The links list. Each link includes title, messageURL and picURL
#' @param atMobiles The mobile phone number of the person
#' @param isAtAll All the people, default is FALSE
#' @param msgtype Message type, includes text, markdown, link, actionCard and  feedCard. Default text.
#'
#' @examples
#' webhook <- 'https://oapi.dingtalk.com/robot/send?access_token=your_token'
#' sendChat(
#'   webhook = webhook, msgtype = 'text',
#'   content = "妞妞最可爱",
#'   atMobiles = list('152****7197'))
#'
#' sendChat(
#'   webhook = webhook, msgtype = 'link',
#'   title = '中“毒”已深',
#'   text = '有 “毒” 的 \n 运动x潮流x装备',
#'   messageUrl = 'http://www.poizon.com',
#'   picUrl = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png')
#'
#' sendChat(
#'   webhook = webhook, msgtype = 'markdown',
#'   title = '上海天气',
#'   text = paste0(
#'     '#### 上海天气\n',
#'     '> 14度，东北风2级，空气良53，相对温度48%\n\n',
#'     '> ![spring](http://www.ccdi.gov.cn/lswh/wenhua/wyzd/201803/W020180301632355806894.jpg)\n',
#'     '> ###### 10点20分发布 [天气](https://www.seniverse.com/) \n'))
#'
#' sendChat(
#'   webhook = webhook, msgtype = 'actionCard',
#'   title = '中“毒”已深',
#'   text = "![Du APP](https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png) \n ### 有 “毒” 的 运动x潮流x装备 \n 球鞋鉴别靠谱有效，你喜欢的不容错过，看上就买严格把控，志趣相投玩在一起，商家入驻优惠快捷",
#'   singleTitle = "阅读全文",
#'   singleURL = 'http://www.poizon.com/')
#'
#' sendChat(
#'   webhook = webhook, msgtype = 'actionCard',
#'   title = '中“毒”已深',
#'   text = '![Du APP](https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png) \n ### 有 “毒” 的 \n 运动x潮流x装备',
#'   btns = list(
#'     list(title = '内容不错', actionURL = 'http://www.poizon.com/'),
#'     list(title = '不感兴趣', actionURL = 'http://www.poizon.com/')
#'   ))
#'
#' links <- list(
#'   list(title = '毒APP',
#'        messageURL = 'http://www.poizon.com',
#'        picURL = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png'),
#'   list(title = '中“毒”已深',
#'        messageURL = 'http://www.poizon.com',
#'        picURL = 'https://du.hupucdn.com/news_byte1022byte_9774f29b986b8773640120bf4c07cc2e_w100h100.png'))
#' sendChat(
#'   webhook = webhook, msgtype = 'feedCard',
#'   links = links)
#' @export
#'

sendChat <- function(webhook = NULL, msgtype = 'text', content = NULL, title = NULL, text = NULL, messageUrl = NULL, picUrl = NULL, singleTitle = NULL, singleURL = NULL, btns = NULL, btnOrientation = '0', hideAvatar = '0', links = NULL, atMobiles = NULL, isAtAll = FALSE, result = FALSE){
  msgtypes <- c('text', 'link', 'markdown', 'actionCard', 'feedCard')
  if(is.null(webhook) | is.null(msgtype)){
    stop('webhook and msgtype cannot be NULL.')
  }
  if(!(msgtype %in% msgtypes)){
    stop(paste0('msgtype must be ', paste0(msgtypes, collapse = ', ')))
  }
  if(!is.null(atMobiles)){
    if(is.character(atMobiles)){
      atMobiles <- as.list(atMobiles)
    }
  }
  ## text
  if(msgtype == 'text'){
    if(is.null(content)){
      stop('if msgtype is text, content cannot be null')
    }
    post_body <- list(
      msgtype = msgtype,
      text = list(content = content),
      at = list(
        atMobiles = atMobiles,
        isAtAll = isAtAll))
  }
  ## link
  if(msgtype == 'link'){
    if(is.null(title) | is.null(text) | is.null(messageUrl)){
      stop('if msgtype is link, title, text or messageUrl cannot be NULL.')
    }
    if(is.null(picUrl)){
      picUrl = ''
    }
    post_body <- list(
      msgtype = msgtype,
      link = list(
        title = title,
        text = text,
        messageUrl = messageUrl,
        picUrl = picUrl))
  }
  ## markdown
  if(msgtype == 'markdown'){
    if(is.null(title) | is.null(text)){
      stop('if msgtype is link, title or text cannot be NULL.')
    }
    post_body <- list(
      msgtype = msgtype,
      markdown = list(
        title = title,
        text = text),
      at = list(
        atMobiles = atMobiles,
        isAtAll = isAtAll))
  }
  ## actionCard
  if(msgtype == 'actionCard'){
    if(is.null(title) | is.null(text)){
      stop('if msgtype is actionCard, title or text cannot be NULL.')
    }
    if(!is.null(singleTitle)){
      post_body <- list(
        msgtype = msgtype,
        actionCard = list(
          title = title,
          text = text,
          singleTitle = singleTitle,
          singleURL = singleURL,
          btnOrientation = btnOrientation,
          hideAvatar = hideAvatar))
    }
    if(is.null(singleTitle) & is.null(singleURL) & !is.null(btns)){
      post_body <- list(
        msgtype = msgtype,
        actionCard = list(
          title = title,
          text = text,
          btns = btns,
          btnOrientation = btnOrientation,
          hideAvatar = hideAvatar))
    }
  }
  ## actionCard
  if(msgtype == 'feedCard'){
    # if(is.null(title) | is.null(messageURL) | is.null(picURL)){
    #   stop('if msgtype is feedCard, title, messageURL or picURL cannot be NULL.')
    # }
    post_body <- list(
      msgtype = msgtype,
      feedCard = list(
        links = links))
  }
  message <- httr::POST(
    url = webhook,
    httr::add_headers('Content-Type' = 'application/json;charset=utf-8'),
    encode = 'json',
    body = post_body
  )
  if(isTRUE(result)){
    httr::content(message)
  }
}
