//
//  YdeditorInfoViewController.m
//  Judiciary-Yd
//
//  Created by lecochao on 2017/3/2.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdeditorInfoViewController.h"

@interface YdeditorInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbltxt;
@property (strong,nonatomic) NSString *txt;
@property (assign,nonatomic) NSInteger sum;
@property (strong,nonatomic) NSString *key;
@end

@implementation YdeditorInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settxt];
}

- (void)settxt
{
    switch (_row) {
        case 0:
            _txt = @"昵称（8个字符内）";
            self.title = @"昵称";
            _sum = 8;
            _key = @"username";
            break;
        case 1:
            self.title = @"手机号";
            _txt = @"请输入手机号";
            _sum = 11;
            _key = @"userphone";
            break;
        case 2:
            _txt = @"请输入微信号";
            self.title = @"微信号";
            _sum = 30;
            _key = @"userwx";
            break;
        case 3:
            _txt = @"请输入邮箱";
            self.title = @"邮箱";
            _sum = 30;
            _key = @"useremail";
            break;
        case 4:
            _txt = @"简单介绍一下（200个字符内）";
            self.title = @"简介";
            _sum = 200;
            _key = @"userabstract";
            break;
        default:
            break;
    }
    if (_info.length>0) {
        _lbltxt.text = @"";
        _txtInfo.text = _info;
    }else
        _lbltxt.text = _txt;
}

#pragma mark - TextFieldDelegate -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lbltxt.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _lbltxt.text = _txt;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _lbltxt.text = _txt;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>_sum-1) {
        if (text.length==0) {
            return YES;
        }else
            return NO;
    }
    if (text.length>0) {
        _lbltxt.text = @"";
    }
    if (text.length == 0 &textView.text.length==1) {
        _lbltxt.text = _txt;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lbltxt.text = @"";
    }else{
        _lbltxt.text = _txt;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    [_txtInfo resignFirstResponder];
    if (_txtInfo.text.length>0) {
        NSString *token = k_GET_TOKEN
        NSString *userid= k_GET_OBJECT(Yd_user_id);
        if (token&&userid) {
            [self showHUDWithHint:nil];
            [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_resetUserInfo Params:@{@"userid":userid,_key:_txtInfo.text} success:^(id json) {
                [self hideHud];
                if ([self isFlag:json]) {
                    [self showHint:@"修改成功"];
                    [kNotificationCenter postNotificationName:Yd_Notification_login object:nil];
                }
            } fail:^(NSError *error) {
                [self showHint:@"网络错误,修改失败"];
                [self hideHud];
            }];
        }else{
            [self notLogin];
        }
        [self.navigationController popViewControllerAnimated:YES];
        if (_block) {
            _block(_row,_txtInfo.text);
        }
    }else{
        [self showHint:@"请正确输入"];
    }
    
} 

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
