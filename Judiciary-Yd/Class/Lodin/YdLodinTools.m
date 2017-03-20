//
//  YdLodinTools.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/2/28.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdLodinTools.h"
#import <RongIMKit/RongIMKit.h>
@implementation YdLodinTools

//http://api.sealtalk.im/user/login
// region 86
//phone 131
//password 123456

+ (void)loginRongCloud:(NSString *)userName
              password:(NSString *)password
{
    RCNetworkStatus status =
    [[RCIMClient sharedRCIMClient] getCurrentNetworkStatus];
    
    if (RC_NotReachable == status) {
        NSLog(@"当前网络不可用，请检查！");
        return;
    } else {
       
    }
    NSDictionary *params = @{
                             @"region" : @"86",
                             @"phone" : userName,
                             @"password" : password
                             };
    [XCNetworking XC_Post_JSONWithUrl:@"http://api.sealtalk.im/user/login"
                           parameters:params
                              success:^(id json) {
                                  if ([json[@"code"] intValue] == 200) {
                                      NSString *token = json[@"result"][@"token"];
                                      NSString *userId = json[@"result"][@"id"];
                                      [self loginRongCloud:userName userId:userId token:token password:password success:^{
                                          
                                      } fail:^(NSError *error) {
                                          
                                      }];
                                  } else {
                                      int _errCode = [json[@"code"] intValue];
                                      NSLog(@"NSError is %d", _errCode);
                                      if (_errCode == 1000) {
                                          NSLog(@"手机号或密码错误！");
                                      }
                                  }
                              }
                                 fail:^(NSError *error) {
                                     NSLog(@"登录失败！网络错误！");
                                 }];
}

/**
 *  登录融云服务器
 *
 *  @param userName 用户名
 *  @param token    token
 *  @param password 密码
 */
+ (void)loginRongCloud:(NSString *)userName
                userId:(NSString *)userId
                 token:(NSString *)token
              password:(NSString *)password
               success:(void (^)(void))success
                  fail:(void (^)(NSError *error))faill {
//    self.loginUserName = userName;
//    self.loginUserId = userId;
//    self.loginToken = token;
//    self.loginPassword = password;
    
    //登录融云服务器
    [[RCIM sharedRCIM] connectWithToken:token
                                success:^(NSString *userId) {
                                    NSLog([NSString
                                           stringWithFormat:@"token is %@  userId is %@", token, userId],
                                          nil);
                                    if (success) {
                                        success();
                                    }
//                                    self.loginUserId = userId;
//                                    [self loginSuccess:self.loginUserName userId:self.loginUserId token:self.loginToken password:self.loginPassword];
                                }
                                  error:^(RCConnectErrorCode status) {
                                      if (faill) {
                                          NSError *error = [[NSError alloc] initWithDomain:@"远程服务器登录失败" code:7777 userInfo:@{@"domain":@"网络错误,Rc未能成功登录"}];
                                          faill(error);
                                      }
                                      //关闭HUD
                                      
                                      //        [hud hide:YES];
                                      //        NSLog(@"RCConnectErrorCode is %ld", (long)status);
                                      //        _errorMsgLb.text = [NSString stringWithFormat:@"登陆失败！Status: %zd", status];
                                      //        [_pwdTextField shake];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          //关闭HUD
//                                          [hud hide:YES];
                                          NSLog(@"RCConnectErrorCode is %ld", (long)status);
//                                          _errorMsgLb.text = [NSString stringWithFormat:@"登录失败！Status: %zd", status];
//                                          [_pwdTextField shake];
                                          
                                          //SDK会自动重连登录，这时候需要监听连接状态
//                                          [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
                                      });
                                      //        //SDK会自动重连登陆，这时候需要监听连接状态
                                      //        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
                                  }
                         tokenIncorrect:^{
                             NSLog(@"IncorrectToken");
                         }];
}

+ (void)getTokenAndLoginRongcloudsuccess:(void (^)(void))success
                                    fail:(void (^)(NSError *error))faill
{
    NSString *userid = k_GET_OBJECT(Yd_user_id);
    NSString *userPhone = k_GET_OBJECT(Yd_user_phone);
    NSString *userpw = k_GET_OBJECT(Yd_user_pw);
    
    if (userid) {
        NSString *rcToken = k_GET_OBJECT(Yd_userRc_token);
        if (rcToken) {
            [self loginRongCloud:userPhone userId:userid token:rcToken password:userpw success:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (faill) {
                    faill(error);
                }
            }];
            return;
        }
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getToken Params:@{@"userid":userid} success:^(id json) {
            if ([json[@"flag"] intValue] ==1) {
                NSString *token = json[@"token"];
                if (token) {
                    k_SET_OBJECT(json[@"token"], Yd_userRc_token);
                    [self loginRongCloud:userPhone userId:userid token:token password:userpw success:^{
                        if (success) {
                            success();
                        }
                    } fail:^(NSError *error) {
                        if (faill) {
                            faill(error);
                        }
                    }];
                }else{
                    if (faill) {
                        NSError *error = [[NSError alloc] initWithDomain:@"Rc token 获取失败" code:8888 userInfo:@{@"domain":@"网络错误,Rc未能成功登录"}];
                        faill(error);
                    }
                }
            }
        } fail:^(NSError *error) {
            if (faill) {
                NSError *error = [[NSError alloc] initWithDomain:@"Rc token 获取失败" code:8888 userInfo:@{@"domain":@"网络错误,Rc未能成功登录"}];
                faill(error);
            }
        }];
    }else{
        //    未登录的处理
        k_REMOVE_TOKEN;
        k_REMOVE_OBJECT(Yd_user_id);
        k_REMOVE_OBJECT(Yd_user_phone);
        k_REMOVE_OBJECT(Yd_user_pw);
        
        WGAlertView *alter = [[WGAlertView alloc]initWithTitle:@"未登录" message:@"是否重新登录" block:^(NSInteger buttonIndex, WGAlertView *alert_) {
            if (buttonIndex ==0) {
                if (faill) {
                    NSError *error = [[NSError alloc] initWithDomain:@"用户未登录" code:9999 userInfo:nil];
                    faill(error);
                }
            }
        } cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
        [alter show];
    }
    
}

@end
