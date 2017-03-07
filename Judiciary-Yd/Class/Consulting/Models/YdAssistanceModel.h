//
//  YdAssistanceModel.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/3.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YdAssistanceModel : JSONModel
@property (nonatomic, retain) NSString *lawyer_id;
@property (nonatomic, retain) NSString <Optional>*lawyer_userid;
@property (nonatomic, retain) NSString <Optional>*lawyer_address;
@property (nonatomic, retain) NSString <Optional>*lawyer_addresstext;
@property (nonatomic, retain) NSString <Optional>*lawyer_username;
@property (nonatomic, retain) NSString <Optional>*lawyer_company;
@property (nonatomic, retain) NSString <Optional>*lawyer_lowyercode;
@property (nonatomic, retain) NSString <Optional>*lawyer_inimage;
@property (nonatomic, retain) NSString <Optional>*lawyer_yearimage;
@property (nonatomic, retain) NSString <Optional>*lawyer_abstract;
@property (nonatomic, retain) NSString <Optional>*lawyer_state;
@property (nonatomic, retain) NSString <Optional>*lawyer_praise;
@property (nonatomic, retain) NSString <Optional>*lawyer_comment;
@end
//"data": [
//{
//    "lawyer_id": "12",
//    "lawyer_userid": "11",
//    "lawyer_address": "100-1002",
//    "lawyer_username": "老狼啊",
//    "lawyer_company": "北京律师事务所",
//    "lawyer_lowyercode": "12345678901234",
//    "lawyer_inimage": "/uploads/lawyerimage/20170302/58b7e1b17d7ba.jpg",
//    "lawyer_yearimage": "/uploads/lawyerimage/20170302/58b7e1b17f507.jpg",
//    "lawyer_abstract": "我是个律师",
//    "lawyer_state": "0",
//    "lawyer_praise": "1",
//    "lawyer_comment": "0" 
//} 
//         ]
