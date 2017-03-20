//
//  YdMianViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdMianViewController.h"
#import "YdLodinTools.h"
@interface YdMianViewController ()

@end

@implementation YdMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(selectedIndex:) name:Yd_Tabbar_selectedIndex object:nil];
    [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [YdLodinTools getTokenAndLoginRongcloudsuccess:^{
        NSLog(@"rc 登录成功");
    } fail:^(NSError *error) {
        [self showHint:error.domain];
        UIViewController *lodinVc = [self.storyboard instantiateViewControllerWithIdentifier:@"YdLodinNavigationViewController"];
        [self presentViewController:lodinVc animated:YES completion:nil];
        [kNotificationCenter postNotificationName:Yd_Notification_logout object:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedIndex:(NSNotification *)obj
{
    if (obj) {
        self.selectedIndex = [obj.object integerValue];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
