//
//  WGCategory+NSObject.h
//  WGCategoryAppend
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(WGObject)

/**
 *  UIAlertView 简化封装
 */
+ (void)alertShowErrorWithMsg:(NSString *)msg;

/**
 *  根据路径 计算文件大小
 *
 *  @param path 文件 绝对路径
 *
 *  @return long 整型
 */
+ (long)mathFileSize:(NSString *)path;

/**
 *  根据路径 计算文件夹大小
 *
 *  @param path 文件夹 绝对路径
 *
 *  @return long整型
 */
+ (long)mathDirSize:(NSString *)path;

/**
 *  注销响应链中的第一响应者
 */
+ (void)resignFirstResponder;

/**
 *  category方式修改系统方法
 *
 *  @param aClass          需要修改api的Class
 *  @param originSelector  原Class的selector
 *  @param replaceSelector 修改后的selector
 */
+ (void)replaceSystemAPI:(SEL )originSelector ByReplacedSelector:(SEL )replaceSelector;

/**
 *  获取系统语言
 */
+ (NSString *)systemLanguage;
@end
