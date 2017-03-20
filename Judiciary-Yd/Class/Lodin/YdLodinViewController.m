//
//  YdLodinViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/23.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdLodinViewController.h"
#import "YdLodinTools.h"

@interface YdLodinViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtphone;
@property (weak, nonatomic) IBOutlet UITextField *txtpw;

@end

@implementation YdLodinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
    
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    
    if ([self isvalue]) {
        [self showHUDWithHint:nil];
        NSDictionary *dic = @{@"userphone":_txtphone.text,@"userpassword":_txtpw.text};
        [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_userLogin Params:dic success:^(id json) {
            if ([self isFlag:json]) {
                k_SET_TOKEN(json[@"token"])
                k_SET_OBJECT(json[@"userid"], Yd_user_id);
                k_SET_OBJECT(_txtphone.text, Yd_user_phone);
                k_SET_OBJECT(_txtpw.text, Yd_user_pw);
                [YdLodinTools getTokenAndLoginRongcloudsuccess:^{
                    NSLog(@"rc 登录成功");
                    [self cancelAction:_cancelBtn];
                    [kNotificationCenter postNotificationName:Yd_Notification_login object:json];
                } fail:^(NSError *error) {
                    [self showHint:error.domain];
                }];
                
            }
            [self hideHud];
        } fail:^(NSError *error) {
            NSLog(@"w-登录失败");
            [self showHint:@"登录失败！"];
            [self hideHud];
        }];
    }
}

- (BOOL)isvalue
{
    if ([_txtphone.text isMatchingRegularEpressionByPattern:RE_MobileNumber]) {
        if ([_txtpw.text isMatchingRegularEpressionByPattern:RE_SecretLeast(6, 15)]) {
            return YES;
        }else{
            [self showHint:@"请输入6~15密码"];
            return NO;
        }
        
    }else{
        [self showHint:@"请输入正确的手机号"];
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    if (textField == _txtpw ||textField == _txtagainpw) {
//        [UIView animateWithDuration:0.4 animations:^{
//            self.view.frame = CGRectMake(0, -150, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//        }];
//    }else{
//        [UIView animateWithDuration:0.4 animations:^{
//            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//        }];
//    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
//    if (self.view.frame.origin.y<0) {
//        [UIView animateWithDuration:0.2 animations:^{
//            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//        }];
//    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
//        if (self.view.frame.origin.y<0) {
//            [UIView animateWithDuration:0.5 animations:^{
//                self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
//            }];
//        }
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
