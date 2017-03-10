//
//  YdAboutmeViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/22.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdAboutmeViewController.h"

@interface YdAboutmeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbltxt;

@end

@implementation YdAboutmeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSource];
}

- (IBAction)gobackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataSource
{
    [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_getAboutus Params:nil success:^(id json) {
        if ([self isFlag:json]) {
           
            _lbltxt.text = json[@"data"][@"aboutus_content"];
        }
    } fail:^(NSError *error) {
        [self showHint:@"网络错误获取失败"];
    }];
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
