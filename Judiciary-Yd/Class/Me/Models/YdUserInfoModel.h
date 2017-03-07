//
//  YdUserInfoModel.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/2.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YdUserInfoModel : JSONModel
@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString <Optional>*user_phone;
@property (nonatomic, retain) NSString <Optional>*user_name;
@property (nonatomic, retain) NSString <Optional>*user_password;
@property (nonatomic, retain) NSString <Optional>*user_headimage;
@property (nonatomic, retain) NSString <Optional>*user_headsmallimage;
@property (nonatomic, retain) NSString <Optional>*user_flag;
@property (nonatomic, retain) NSString <Optional>*user_balance;
@property (nonatomic, retain) NSString <Optional>*user_wx;
@property (nonatomic, retain) NSString <Optional>*user_email;
@property (nonatomic, retain) NSString <Optional>*user_abstract;
@property (nonatomic, retain) NSString <Optional>*user_token;
@end
//"data": {
//    "user_id": "1",
//    "user_phone": "18797090972",
//    "user_name": "张三丰",
//    "user_password": "123456789",
//    "user_time": "2017-02-28 18:14:30",
//    "user_headimage": "./uploads/headimage/20170228/58b54d86365b0.png",
//    "user_headsmallimage": "./uploads/headimage/20170228/thumb_58b54d86365b0.png",
//    "user_flag": "0",
//    "user_balance": "0",
//    "user_wx": "myweixin",
//    "user_email": null,
//    "user_abstract": null,
//    "user_token": "0"
//}
