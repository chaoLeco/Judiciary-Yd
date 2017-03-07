//
//  YdeditorInfoViewController.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/2.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdBasisViewController.h"

@interface YdeditorInfoViewController : YdBasisViewController
@property (assign ,nonatomic) NSInteger row;//@[@"姓名",@"电话",@"微信",@"邮箱",@"简介"];
@property (strong ,nonatomic) NSString *info;
typedef void(^backInfo)(NSInteger row ,NSString *info);
@property (strong,nonatomic) backInfo block;
@end
