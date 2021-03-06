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


#define Yd_RCIM_APPKEY @"m7ua80gbmy02m" //develop key
//#define Yd_RCIM_APPKEY @"m7ua80gbmy02m" //production key
//#define Yd_RCIM_APPKEY @"n19jmcy59f1q9" //不知咱的 key

#define Yd_RCIM_TOKEN @"RwwgHQRgvUiOVCngXMoEM6+YsUIoF3ojin3K277sfOnuhl89uRMYPRVSVLV/ftdVSxnRWBWZ2zdLM1cqohnLnatdpZUyLdaH" //token
#define Yd_RCIM_ID @"Ed1fnUzBZ" //ID

#pragma mark - key 键值 -
#define Yd_userRc_token @"com.Yd.userRongCloudToken"
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
#define Yd_imgUrl_basis Yd_url_basis@"sifanvshen/"
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

#pragma mark - 城市接口 -

//1、获取省份列表
//接口地址：sifanvshen/index.php/Home/Citys/getProvince
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Citys/getProvince
//
//提交数据：
//提交类型：GET
//
//返回数据：flag=0:失败 flag=1:成功 id-省份id parent_id-省份id（城市的父id） name-城市名 sort-分类
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": [
//    {
//        "id": "100",
//        "parent_id": "0",
//        "name": "安徽",
//        "sort": "1"
//    },
//    {
//        "id": "200",
//        "parent_id": "0",
//        "name": "澳门",
//        "sort": "2"
//    }
//             ]
//}
#define Yd_url_getProvince Yd_url_sifanvsheng@"Home/Citys/getProvince"
//2、获取城市列表
//
//接口地址：sifanvshen/index.php/Home/Citys/getCity
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Citys/getCity?id=3400
//
//提交数据：id-省份id
//提交类型：GET
//
//返回数据：flag=0:失败 flag=1:成功 id-城市id parent_id-省份id（城市的父id） name-城市名 sort-分类
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": [
//    {
//        "id": "3401",
//        "parent_id": "3400",
//        "name": "杭州", 
//        "sort": "34" 
//    }, 
//    { 
//        "id": "3402", 
//        "parent_id": "3400", 
//        "name": "湖州", 
//        "sort": "34" 
//    } 
//             ] 
//}
#define Yd_url_getCity Yd_url_sifanvsheng@"Home/Citys/getCity"

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

//6、首页头部新闻列表查询接口
//接口地址：sifanvshen/index.php/Home/News/getNewsListByType
//
//接口示例：http://59.110.166.204/sifanvshen/index.php/Home/News/getNewsListByType?newtype=1&keyword=不知道&rownum=10&page=1
//
//提交数据： newtype-新闻类型（1：法律条文（搜索里面的法律法规） 2：司法解释 3：司法案例（搜索里面的法律案例） 4：法律文献 5：法律流程（搜做里面的法律流程）） keyword-搜索关键字 rownum-每页条数 page-当前页数
//
//提交类型：POST、GET
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": "1",
//    "data": [
//    {
//        "news_id": "8",
//        "news_title": "生孩子怎么处理不知道",
//        "news_content": "拉克丝打飞机看来就是地方了看见爱上对方立刻就阿萨德六块腹肌熬枯受淡放",
//        "news_time": "2017-03-08 10:48:56",
//        "news_type": "1",
//        "news_listimage": "./uploads/newsimage/20170308/58bf71189994c.jpg",
//        "news_smalllistimage": "./uploads/newsimage/20170308/thumb_58bf71189994c.jpg"
//    } 
//             ] 
//}
#define Yd_url_getNewsListByType Yd_url_sifanvsheng@"Home/News/getNewsListByType"

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

#define Yd_url_assistanceAdd Yd_url_sifanvsheng@"Home/Assistance/assistanceAdd"


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

#define Yd_url_getAssistanceList Yd_url_sifanvsheng@"Home/Assistance/getAssistanceList"

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

#define Yd_url_getAssistanceDetail Yd_url_sifanvsheng@"Home/Assistance/getAssistanceDetail"

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
#define Yd_url_deleteAssistance Yd_url_sifanvsheng@"Home/Assistance/deleteAssistance"

#pragma mark - 律师接口 -

//1、认证律师提交
//接口地址：sifanvshen/index.php/Home/Lawyer/lawyerAuthenUpload
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Lawyer/lawyerAuthenUpload
//
//提交数据：
//userid-律师对应普通用户id lowyeraddress-律师地址（省代码-市代码 青海-西宁 例：2200-2201） lowyername-律师真实姓名 lowyercompany-律师事务所 lowyercode-律师执业证号（暂定14位）
//lowyerabstract-律师简介 lowyerwx-律师微信 lowyerqq-律师QQ lowyerphone-律师手机号
//inimage-律师执业证内页 yearimage-年检证
//提交类型：POST
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"新增成功"}

#define Yd_url_lawyerAuthenUpload Yd_url_sifanvsheng@"Home/Lawyer/lawyerAuthenUpload"

//2、律师列表获取
//接口地址：sifanvshen/index.php/Home/Lawyer/getAssistanceList
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Lawyer/getAssistanceList?page=1&rownum=10
//
//提交数据：
//page-页数 rownum-每页显示条数
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": "12",
//    "data": [
//    {
//        "lawyer_id": "12",
//        "lawyer_userid": "11",
//        "lawyer_address": "100-1002",
//        "lawyer_username": "老狼啊",
//        "lawyer_company": "北京律师事务所",
//        "lawyer_lowyercode": "12345678901234",
//        "lawyer_inimage": "/uploads/lawyerimage/20170302/58b7e1b17d7ba.jpg",
//        "lawyer_yearimage": "/uploads/lawyerimage/20170302/58b7e1b17f507.jpg",
//        "lawyer_abstract": "我是个律师",
//        "lawyer_state": "0",
//        "lawyer_praise": "1",
//        "lawyer_comment": "0"
//    }
//             ]
//}
#define Yd_url_lawyergetAssistanceList Yd_url_sifanvsheng@"Home/Lawyer/getAssistanceList"
//3、获取律师详情
//接口地址：sifanvshen/index.php/Home/Lawyer/getLawyerDetail
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Lawyer/getLawyerDetail?id=2
//
//提交数据：
//id-律师id
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": {
//        "lawyer_id": "1",
//        "lawyer_userid": "1",
//        "lawyer_address": "青海-西宁",
//        "lawyer_username": "老狼",
//        "lawyer_company": "北京律师事务所",
//        "lawyer_lowyercode": "12345678901234",
//        "lawyer_inimage": "/uploads/lawyerimage/20170302/58b7e8f6926fe.jpg",
//        "lawyer_yearimage": "/uploads/lawyerimage/20170302/58b7e8f694062.png",
//        "lawyer_abstract": "我是个律师啊", 
//        "lawyer_wx": "myweixin", 
//        "lawyer_qq": "547201260", 
//        "lawyer_phone": "15210181617", 
//        "lawyer_state": "0", 
//        "lawyer_praise": "1", 
//        "lawyer_comment": "0" 
//    } 
//}
#define Yd_url_getLawyerDetail Yd_url_sifanvsheng@"Home/Lawyer/getAssistanceList"


//6、首页优秀律师列表
//接口地址：sifanvshen/index.php/Home/Lawyer/getExcellentAssistanceList
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Lawyer/getExcellentAssistanceList=
//
//提交数据：
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{"flag":"1","message":"修改成功"}
//{
//    "flag": "1",
//    "message": "查询成功",
//    "sumnum": "5",
//    "data": [
//    {
//        "lawyer_id": "1",
//        "lawyer_userid": "1",
//        "lawyer_address": "2200-2201",
//        "lawyer_username": "老狼",
//        "lawyer_company": "北京律师事务所",
//        "lawyer_lowyercode": "12345678901234",
//        "lawyer_inimage": "/uploads/lawyerimage/20170302/58b7e8f6926fe.jpg",
//        "lawyer_yearimage": "/uploads/lawyerimage/20170302/58b7e8f694062.png",
//        "lawyer_abstract": "我是个律师啊",
//        "lawyer_wx": "myweixin",
//        "lawyer_qq": "547201260",
//        "lawyer_phone": "15210181617",
//        "lawyer_state": "1",
//        "lawyer_praise": "1", 
//        "lawyer_comment": "0", 
//        "lawyer_addresstext": "", 
//        "lawyer_isrecommend": "1" 
//    } 
//             ] 
//}

#define Yd_url_getExcellentAssistanceList Yd_url_sifanvsheng@"Home/Lawyer/getExcellentAssistanceList"

#pragma mark - banner  -

//2、banner列表查询 - 首页
//接口地址：sifanvshen/index.php/Home/Lawyer/Banner/getBannerList
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Lawyer/Banner/getBannerList
//
//提交数据：
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功 banner_newsid-图片对应新闻id
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": [
//    {
//        "banner_id": "4",
//        "banner_imagelink": "/uploads/newsimage/20170308/58bf855ed5b7d.png",
//        "banner_newsid": "5",
//        "banner_showflag": "1",
//        "banner_time": "2017-03-08 12:15:38" 
//    } 
//             ] 
//}

#define Yd_url_getBannerList Yd_url_sifanvsheng@"Home/Banner/getBannerList"


//2、获取关于我们
//接口地址：sifanvshen/index.php/Home/Lawyer/About/getAboutus
//
//接口示例：http://localhost/sifanvshen/index.php/Home/About/getAboutus
//
//提交数据：
//
//提交类型：POST、GET
//
//返回数据：flag=0:失败 flag=1:成功
//{
//    "flag": "1",
//    "message": "查询成功",
//    "data": {
//        "aboutus_id": "1",
//        "aboutus_content": "我们是一家非常专业的律师咨询机构。",
//        "aboutus_time": "2017-03-10 10:57:32"
//    } 
//}
#define Yd_url_getAboutus Yd_url_sifanvsheng@"Home/About/getAboutus"


//七、用户聊天
//appKey: m7ua80gbmy02m
//
//1、获取token
//接口地址：sifanvshen/index.php/Home/Userchat/getToken
//
//接口示例：http://localhost/sifanvshen/index.php/Home/Userchat/getToken?userid=1
//
//提交数据：
//
//提交类型：POST、GET
//
//返回数据：code=200:成功 code=其他失败
//{"code":200,"userId":"1","token":"nuv56g3r4jkLJht5btJQ1CjkPJDahLtLL5VknwRTztjLVWcOSwMkYYtUfsS9Kg+gh9E+

#define Yd_url_getToken Yd_url_sifanvsheng@"Home/Userchat/getToken"
