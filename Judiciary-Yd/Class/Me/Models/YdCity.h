//
//  YdCity.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/7.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface YdCity : JSONModel
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString <Optional>*parent_id;
@property (nonatomic, retain) NSString <Optional>*name;
@property (nonatomic, retain) NSString <Optional>*sort;
@end
//{"id":"100","parent_id":"0","name":"安徽","sort":"1"
