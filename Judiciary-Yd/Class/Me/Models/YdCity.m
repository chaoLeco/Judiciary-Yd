//
//  YdCity.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/7.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdCity.h"

@implementation YdCity
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"_id"}];
}
@end
