//
//  YdApi.h
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#ifndef YdApi_h
#define YdApi_h


#endif /* YdApi_h */


//#define Yd_RCIM_APPKEY @"m7ua80gbmy02m" //develop key
//#define Yd_RCIM_APPKEY @"m7ua80gbmy02m" //production key
#define Yd_RCIM_APPKEY @"n19jmcy59f1q9" //不知咱的 key

#define Yd_RCIM_TOKEN @"RwwgHQRgvUiOVCngXMoEM6+YsUIoF3ojin3K277sfOnuhl89uRMYPRVSVLV/ftdVSxnRWBWZ2zdLM1cqohnLnatdpZUyLdaH" //token
#define Yd_RCIM_ID @"Ed1fnUzBZ" //ID

#pragma mark - key 键值 -
#define Yd_user_token @"com.Yd.userToken"
#define Yd_user_id @"com.Yd.userId"
#define Yd_user_phone @"com.Yd.userphone"
#define Yd_user_pw @"com.Yd.userpw"
//登录、登出成功通知
#define Yd_Notification_login @"com.Yd.Notificationlogin"
#define Yd_Notification_logout @"com.Yd.Notificationlogout"
//跳转tabbar
#define Yd_Tabbar_selectedIndex @"com.Yd.TabbarSelectedIndex"
#pragma mark - api 基础地址 -

#define Yd_url_basis @"http://59.110.166.204/"
#define Yd_url_sifanvsheng Yd_url_basis@"sifanvshen/index.php/"

#pragma mark - 注册登录 -
//1、用户注册
//接口地址：/sifanvshen/index.php/Home/User/userRegister
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/userRegister?username=老王&userphone=18797090972&usercode=123456&userpassword=123456789
//提交数据：username-用户昵称 ， userphone-用户手机号 ， usercode-验证码 ， userpassword-密码
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"注册成功"}

#define Yd_url_userRegister Yd_url_sifanvsheng@"Home/User/userRegister"

//2、用户登录
//接口地址：/sifanvshen/index.php/Home/User/userLogin
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/userLogin?userphone=187970973&userpassword=123456789
//
//提交数据：userphone-手机号 userpassword-密码
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功 token:登录令牌 userid:用户id
//{"flag":"1","message":"登录成功","token":"148818005225112","userid":"1"}

#define Yd_url_userLogin Yd_url_sifanvsheng@"Home/User/userLogin"

//3、修改密码
//接口地址：sifanvshen/index.php/Home/User/resetPassword
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/resetPassword?userphone=18797090972&vercode=123456&userpassword=123123123
//
//提交数据：userphone-手机号 vercode-验证码 userpassword-密码
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"密码修改成功"}
#define Yd_url_resetPassword Yd_url_sifanvsheng@"Home/User/resetPassword"

//4、修改用户个人基本信息（昵称、微信号、邮箱）
//接口地址：sifanvshen/index.php/Home/User/resetUserInfo
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/resetUserInfo?userid=1&username=张三丰&userwx=myweixin&useremail=123@qq.com
//
//提交数据：userid-用户id username-用户昵称 userwx-微信 useremail-邮箱
//(备注：修改的字段填修改的数据、不需要修改的字段传入空即可)
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"修改成功"}

#define Yd_url_resetUserInfo Yd_url_sifanvsheng@"Home/User/resetUserInfo"

//5、修改头像
//接口地址：sifanvshen/index.php/Home/User/uploadHeadImg
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/uploadHeadImg?userid=1&headerphoto=123
//
//提交数据：userid-用户id headerphoto-图片
//提交类型：POST
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"修改成功"}

#define Yd_url_uploadHeadImg Yd_url_sifanvsheng@"Home/User/uploadHeadImg"


//6、获取个人信息
//接口地址：sifanvshen/index.php/Home/User/getUserInfo
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/getUserInfo?userid=1
//
//提交数据：userid-用户id
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": {
//        "user_id": "1",
//        "user_phone": "18797090972",
//        "user_name": "张三丰",
//        "user_password": "123456789",
//        "user_time": "2017-02-28 18:14:30",
//        "user_headimage": "./uploads/headimage/20170228/58b54d86365b0.png",
//        "user_headsmallimage": "./uploads/headimage/20170228/thumb_58b54d86365b0.png",
//        "user_flag": "0",
//        "user_balance": "0",
//        "user_wx": "myweixin",
//        "user_email": null, 
//        "user_abstract": null, 
//        "user_token": "0" 
//    } 
//}
#define Yd_url_getUserInfo Yd_url_sifanvsheng@"Home/User/getUserInfo"

//7、意见反馈提交
//接口地址：sifanvshen/index.php/Home/User/uploadFeedback
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/uploadFeedback?userid=2&content=反馈内容
//
//提交数据：userid-用户id content-反馈内容（500字以内）
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"添加成功"}

#define Yd_url_uploadFeedback Yd_url_sifanvsheng@"Home/User/uploadFeedback"


//9、获取反馈详情
//接口地址：sifanvshen/index.php/Home/User/getFeedbackDetail
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/getFeedbackDetail?id=1
//
//提交数据：id-反馈id
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": null,
//    "data": {
//        "feedback_id": "1",
//        "feedback_content": "1",
//        "feedback_time": "2017-02-28 18:43:52",
//        "feedback_userid": "反馈反馈反馈反馈反馈反馈反馈反馈反馈反馈反馈"
//    } 
//}
#define Yd_url_getFeedbackDetail Yd_url_sifanvsheng@"Home/User/getFeedbackDetail"

//10、删除反馈
//接口地址：sifanvshen/index.php/Home/User/deleteFeedback
//
//接口示例：http://localhost/sifanvshen/index.php/Home/User/deleteFeedback?id=1
//
//提交数据：id-反馈id
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"删除成功"}

#define Yd_url_deleteFeedback Yd_url_sifanvsheng@"Home/User/deleteFeedback"

#pragma mark - 新闻接口 -

//1、添加新闻
//接口地址：/sifanvshen/index.php/Home/News/newsAdd
//
//接口示例：
//http://localhost/sifanvshen/index.php/Home/News/newsAdd?newstitle=新闻标题&newscontent=新闻内容&newstype=4&newslistimage=123213123123
//
//提交数据：newstitle-新闻标题 newscontent-新闻内容 newstype-新闻类型（ 1：法律条文 2：司法解释 3：司法案例 4：法律文献） newslistimage-新闻列表图片链接
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"新增成功"}
#define Yd_url_newsAdd Yd_url_sifanvsheng@"Home/News/newsAdd"

//2、获取新闻列表
//接口地址：sifanvshen/index.php/Home/News/getNewsList
//
//接口示例：http://localhost/sifanvshen/index.php/Home/News/getNewsList?newtype=1&rownum=10&page=1
//
//提交数据：newtype-新闻类型（1：法律条文 2：司法解释 3：司法案例 4：法律文献） rownum-每页条数 page-当前页数
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": "4",
//    "data": [
//    {
//        "news_id": "4",
//        "news_title": "这是新闻标题2",
//        "news_content": "这是新闻内容",
//        "news_time": "2017-02-27 15:54:14",
//        "news_type": "1",
//        "news_listimage": "123213123123"
//    },
//    {
//        "news_id": "3",
//        "news_title": "这是新闻标题1",
//        "news_content": "这是新闻内容",
//        "news_time": "2017-02-27 15:54:09", 
//        "news_type": "1", 
//        "news_listimage": "123213123123" 
//    } 
//             ] 
//}

#define Yd_url_getNewsList Yd_url_sifanvsheng@"Home/News/getNewsList"

//3、获取新闻详情
//接口地址：sifanvshen/index.php/Home/News/getNewsDetail
//
//接口示例：http://localhost/sifanvshen/index.php/Home/News/getNewsDetail?newid=1
//
//提交数据：newid-新闻id
//
//提交类型：POST、GET
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": null,
//    "data": {
//        "news_id": "1",
//        "news_title": "这是新闻标题",
//        "news_content": "这是新闻内容",
//        "news_time": "2017-02-27 15:52:38",
//        "news_type": "1",
//        "news_listimage": "123213123123" 
//    } 
//}
#define Yd_url_getNewsDetail Yd_url_sifanvsheng@"Home/News/getNewsDetail"

//4、新闻删除
//接口地址：sifanvshen/index.php/Home/News/deleteNews
//
//接口示例：http://localhost/sifanvshen/index.php/Home/News/deleteNews?newid=1
//
//提交数据：newid-新闻id
//
//提交类型：POST、GET
//返回数据：flag=0:失败 flag=1:成功
//
//{"flag":"1","message":"删除成功"}

#define Yd_url_deleteNews Yd_url_sifanvsheng@"Home/News/deleteNews"

//5、新闻修改
//接口地址：sifanvshen/index.php/Home/News/updateNews
//
//接口示例：http://localhost/sifanvshen/index.php/Home/News/updateNews?newid=2&newstitle=修改的标题&newscontent=修改的内容&newstype=3&newslistimage=aaaaaaaaaaaa
//
//提交数据：newid-新闻id newstitle-新闻标题 newscontent-新闻内容 newstype-新闻类型（1：法律条文 2：司法解释 3：司法案例 4：法律文献） newslistimage-新闻列表图片
//
//提交类型：POST、GET
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"修改成功"}

#define Yd_url_updateNews Yd_url_sifanvsheng@"Home/News/updateNews"

#pragma mark - 法律援助在线申请  -

//1、新增法律援助申请
//接口地址：sifanvshen/index.php/Home/Assistance/assistanceAdd
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Assistance/assistanceAdd?user_id=111&yzsq_role=01&yzsq_mode=01&yzsq_reason=01&yzsq_state=01&yzsq_reasonabstract=原因原因&yzsq_other=其他其他
//
//提交数据：
//① yzsq_role-申请人角色-必填 （01：原告 02：被告 03:第三人 04：上诉人 05：被上诉人 06：其他 ）
//② user_id-申请人id-必填
//③ yzsq_mode-援助方式-必填 (01：刑事辩护 02：刑事被害人代理 03：民事诉讼代理 04：行政诉讼代理 05：仲裁代理 06：公正 07：非诉讼调解）
//                     
//                     ④ yzsq_reason-事项案由-必填 (01：婚姻、家庭 02：赡养、抚养、扶养 03：工伤 04：劳动纠纷 05：损害赔偿 06：请求抚恤金等 07：其他)
//                     
//                     ⑤ yzsq_state-法律状态-必填 (01：诉讼中 02：侦查 03：起诉 04：一审 05：二审 06：重审 07：再审 08：仲裁中 09：调解中 10：行政处理中 11：行政复议中 12：投诉无答）
//                                           
//                                           ⑥ yzsq_reasonabstract-案由概述-必填（500字以内）
//                                           
//                                           ⑦ yzsq_other-其他说明-选填（500字以内）
//                                           
//                                           提交类型：POST、GET
//                                           
//                                           返回数据：flag=0:失败 flag=1:成功 
//{"flag":"1","message":"新增成功"}

#define Yd_url_assistanceAdd Yd_url_sifanvsheng@"HHome/Assistance/assistanceAdd"


//2、法律援助列表查询
//
//接口地址：sifanvshen/index.php/Home/Assistance/getAssistanceList
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Assistance/getAssistanceList?rownum=10&page=1&userid=123
//
//提交数据：
//rownum-每页显示行数 page-当前页数 userid-用户id(选填，有：查询该用户援助申请列表 无：查询所有用户援助申请列表)
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功 sumnum-总条数
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": "15",
//    "data": [
//    {
//        "yzsq_id": "5",
//        "user_id": "123",
//        "yzsq_role": "01",
//        "yzsq_mode": "01",
//        "yzsq_reason": "01",
//        "yzsq_state": "01",
//        "yzsq_reasonabstract": "原因原因aaa",
//        "yzsq_other": "其他其他",
//        "yzsq_time": "2017-02-28 10:13:04"
//    },
//    {
//        "yzsq_id": "4",
//        "user_id": "123",
//        "yzsq_role": "01",
//        "yzsq_mode": "01",
//        "yzsq_reason": "01",
//        "yzsq_state": "01", 
//        "yzsq_reasonabstract": "原因原因321", 
//        "yzsq_other": "其他其他", 
//        "yzsq_time": "2017-02-28 10:13:01" 
//    } 
//             ] 
//}

#define Yd_url_getAssistanceList Yd_url_sifanvsheng@"HHome/Assistance/getAssistanceList"

//3、法律援助详情查询
//接口地址：sifanvshen/index.php/Home/Assistance/getAssistanceDetail
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Assistance/getAssistanceDetail?assid=1
//
//提交数据：
//assid-援助申请id
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": null,
//    "data": {
//        "yzsq_id": "1",
//        "user_id": "123",
//        "yzsq_role": "01",
//        "yzsq_mode": "01",
//        "yzsq_reason": "01",
//        "yzsq_state": "01",
//        "yzsq_reasonabstract": "原因原因",
//        "yzsq_other": "其他其他", 
//        "yzsq_time": "2017-02-28 10:12:49" 
//    } 
//}

#define Yd_url_getAssistanceDetail Yd_url_sifanvsheng@"HHome/Assistance/getAssistanceDetail"

//4、法律援助申请删除
//接口地址：sifanvshen/index.php/Home/Assistance/deleteAssistance
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Assistance/deleteAssistance?assid=1
//
//提交数据：
//assid-援助申请id
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"删除成功"}
#define Yd_url_deleteAssistance Yd_url_sifanvsheng@"HHome/Assistance/deleteAssistance"
