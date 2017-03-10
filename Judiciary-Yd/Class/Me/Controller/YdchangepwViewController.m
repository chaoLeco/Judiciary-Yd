//
//  YdchangepwViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/22.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdchangepwViewController.h"

@interface YdchangepwViewController ()

@property (weak, nonatomic) IBOutlet UITextField *pwnew;
@property (weak, nonatomic) IBOutlet UITextField *pwagain;
@property (weak, nonatomic) IBOutlet UITextField *txtcode;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeTime;

@property (assign, nonatomic) NSInteger tt;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation YdchangepwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _codeTime.hidden = YES;
    _codeBtn.hidden = NO;
}

- (IBAction)gobackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getcodeAction:(id)sender {
    [self.view endEditing:YES];
    NSString *phone = k_GET_OBJECT(Yd_user_phone);
    if (phone) {
        //请求短信验证码
        _codeBtn.hidden = YES;
        _codeTime.hidden = NO;
        _tt = 60;
        if (!_timer) {
            _timer = [NSTimer initWithTimeInterval:1 target:self selector:@selector(deal) userInfo:nil repeats:YES];
        }
        [_timer resume];
        
    }else
        [self notLogin];
}

- (void)deal
{
    _codeTime.text = [NSString stringWithFormat:@"%lds",(long)--_tt];
    if (_tt<1) {
        [_timer stop];
        _codeBtn.hidden = NO;
        _codeTime.hidden = YES;
    }
}

- (IBAction)changeVisible:(UIButton *)sender {
    switch (sender.tag) {
        case 200:
            _pwnew.secureTextEntry = sender.selected;
            break;
        case 300:
            _pwagain.secureTextEntry = sender.selected;
            break;
        default:
            break;
    }
    sender.selected = !sender.selected;
}

- (IBAction)commitAction:(id)sender {
    
    [self.view endEditing:YES];
    if ([self isvalue]) {
        [self showHUDWithHint:nil];
        NSString *phone = k_GET_OBJECT(Yd_user_phone);
        
        NSDictionary *dic = @{@"userphone":phone,
                              @"vercode":_txtcode.text,
                              @"userpassword":_pwagain.text};
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_resetPassword Params:dic success:^(id json) {
            [self hideHud];
            if ([self isFlag:json]) {
                [kNotificationCenter postNotificationName:Yd_Notification_logout object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self showHint:@"密码修改成功！需重新登录"];
            }
        } fail:^(NSError *error) {
            [self showHint:@"网络错误"];
            [self hideHud];
        }];
    }
}

- (BOOL)isvalue
{
    if (_txtcode.text.length==6) {
        if ([_pwnew.text isMatchingRegularEpressionByPattern:RE_SecretLeast(6, 15)]) {
            if ([_pwnew.text isEqualToString:_pwagain.text]) {
                return YES;
            }else{
                [self showHint:@"两次密码输入不一致"];
                return NO;
            }
        }else{
            [self showHint:@"请输入6~15位密码"];
            return NO;
        }
    }else {
        [self showHint:@"请输入6位验证码"];
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
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
