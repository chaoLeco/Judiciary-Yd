//
//  YdRegisteredViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/23.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdRegisteredViewController.h"

@interface YdRegisteredViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbltime;
@property (weak, nonatomic) IBOutlet UIButton *getcodebtn;
@property (weak, nonatomic) IBOutlet UITextField *txtNickName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtpw;
@property (weak, nonatomic) IBOutlet UITextField *txtagainpw;

@end

@implementation YdRegisteredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lbltime.hidden = YES;
    _getcodebtn.hidden = NO;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)gobackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getcodeAction:(id)sender {
    if ([_txtPhone.text isMatchingRegularEpressionByPattern:RE_MobileNumber]) {
        
        [XCNetworking XC_Post_JSONWithUrl:@"" parameters:@{} success:^(id json) {
            
        } fail:^(NSError *error) {
            
        }];
    }else{
        [self showHint:@"请输入正确的手机号"];
    }
}

- (IBAction)registeredAction:(id)sender {
//    username=老王&userphone=13162839999&usercode=123456&userpassword=123456789
    [self endEditing];
    if ([self isvalue]) {
        [self showHUDWithHint:nil];
        NSDictionary *dic = @{@"username":_txtNickName.text,
                              @"userphone":_txtPhone.text,
                              @"usercode":_txtCode.text,
                              @"userpassword":_txtpw.text};
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_userRegister Params:dic success:^(id json) {
            [self hideHud];
            if ([self isFlag:json]) {
                k_SET_TOKEN(json[@"token"])
                k_SET_OBJECT(json[@"userid"],Yd_user_id);
                [self showHint:@"注册成功"];
                [self gobackAction:nil];
            }
        } fail:^(NSError *error) {
            [self showHint:@"注册失败"];
            [self hideHud];
        }];
    }
}

- (BOOL)isvalue
{
    if (_txtNickName.text.length>0) {
        if ([_txtPhone.text isMatchingRegularEpressionByPattern:RE_MobileNumber]) {
            if (_txtCode.text.length==6) {
                if ([_txtpw.text isMatchingRegularEpressionByPattern:RE_SecretLeast(6, 15)]) {
                    if ([_txtpw.text isEqualToString:_txtagainpw.text]) {
                        return YES;
                    }else{
                        [self showHint:@"两次密码输入不一致"];
                        return NO;
                    }
                    
                }else{
                    [self showHint:@"请输入6~15位密码"];
                    return NO;
                }
            }else{
                [self showHint:@"请输入6位短信验证码"];
                return NO;
            }
        }else{
            [self showHint:@"请输入正确的手机号"];
            return NO;
        }
    }else{
        [self showHint:@"请输入昵称"];
        return NO;
    }
    
    
}

- (void)endEditing
{
    [self.view endEditing:YES];
    if (self.view.frame.origin.y<0) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        }];
    }
}

#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtpw ||textField == _txtagainpw) {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, -150, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        }];
    }else{
        [UIView animateWithDuration:0.4 animations:^{
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        }];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (self.view.frame.origin.y<0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        }];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        if (self.view.frame.origin.y<0) {
            [UIView animateWithDuration:0.5 animations:^{
                self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            }];
        }
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
