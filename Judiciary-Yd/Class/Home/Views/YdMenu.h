//
//  YdMenu.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/8.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YdMenu : UIView<UITableViewDelegate,UITableViewDataSource>

typedef void(^menuBlock)(NSInteger nn,id data);
@property (strong,nonatomic) menuBlock block;
@property (strong,nonatomic) NSArray *datas;


+ (instancetype)menu;
@end
