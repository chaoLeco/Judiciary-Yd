//
//  YdLodinTools.h
//  Judiciary-Yd
//
//  Created by lecochao on 2017/2/28.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YdLodinTools : NSObject

+ (void)loginRongCloud:(NSString *)userName
                userId:(NSString *)userId
                 token:(NSString *)token
              password:(NSString *)password;

+ (void)loginRongCloud:(NSString *)userName
              password:(NSString *)password;
@end
