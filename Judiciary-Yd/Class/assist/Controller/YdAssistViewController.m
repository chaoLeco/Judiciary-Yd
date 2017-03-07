//
//  YdAssistViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdAssistViewController.h"
#import "OrderPickerView.h"
@interface YdAssistViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scorllView;
@property (weak, nonatomic) IBOutlet UITextView *txtView_on;
@property (weak, nonatomic) IBOutlet UITextView *txtView_under;
@property (weak, nonatomic) IBOutlet UILabel *lblplaceholder_on;
@property (weak, nonatomic) IBOutlet UILabel *lblplaceholder_under;
@property (strong,nonatomic) NSMutableDictionary *parms;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;

@end

@implementation YdAssistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseAction:(UIButton *)sender {
    [self.view endEditing:YES];
    NSArray *titles;
    switch (sender.tag) {
            
        case 11:
            titles = @[@"原告",@"被告",@"第三人",@"上诉人",@"被上诉人",@"其他"];
            break;
        case 12:
            titles = @[@"刑事辩护",@"刑事被害人代理",@"民事诉讼代理",@"行政诉讼代理",@"仲裁代理",@"公证",@"非诉讼调解"];
            break;
        case 13:
            titles = @[@"婚姻、家庭",@"赡养、抚养、扶养",@"工伤",@"劳动纠纷",@"损害赔偿",@"请求抚恤金等",@"其他"];
            break;
        case 14:
            titles = @[@"诉讼中",@"侦查",@"起诉",@"一审",@"二审",@"重审",@"再审",@"仲裁中",@"调解中",@"行政处理中",@"行政复议中",@"投诉无答"];
            break;
        default:
            break;
    }
    if (!kArrayIsEmpty(titles)) {
        [OrderPickerView showViewStyleDefaultWithData:titles Block:^(id data, NSIndexPath *path) {
            [sender setTitle:data forState:UIControlStateNormal];
            switch (sender.tag) {
                    
                case 11:
                    [_parms setObject:[NSString stringWithFormat:@"0%d",path.row+1] forKey:@"yzsq_role"];
                    break;
                case 12:
                    [_parms setObject:[NSString stringWithFormat:@"0%d",path.row+1] forKey:@"yzsq_mode"];
                    break;
                case 13:
                    [_parms setObject:[NSString stringWithFormat:@"0%d",path.row+1] forKey:@"yzsq_reason"];
                    break;
                case 14:
                    [_parms setObject:[NSString stringWithFormat:@"0%d",path.row+1] forKey:@"yzsq_state"];
                    break;
                default:
                    break;
            }
        }];
    }
}

- (IBAction)submitAction:(id)sender {
    [self.view endEditing:YES];
    if (_txtName.text.length>0) {
        if ([_txtPhone.text isMatchingRegularEpressionByPattern:RE_MobileNumber]) {
            [_parms setObject:_txtName.text forKey:@"yzsq_username"];
            [_parms setObject:_txtPhone.text forKey:@"yzsq_userphone"];
            NSString *token = k_GET_TOKEN
            NSString *userid= k_GET_OBJECT(Yd_user_id);
            
            if (![self isAllParms]) {
                return;
            }
            if (token&&userid) {
                [self showHUDWithHint:@"援助申请中"];
                [_parms setObject:userid forKey:@"user_id"];
                [XCNetworking XC_GET_JSONDataWithUrl:Yd_url_assistanceAdd Params:_parms success:^(id json) {
                    if ([self isFlag:json]) {
                        [self showHint:@"已收到您的援助申请"];
                        [self reset];
                    }
                    [self hideHud];
                } fail:^(NSError *error) {
                    [self showHint:@"网络错误"];
                    [self hideHud];
                }];
            }else [self notLogin];
            
        }else{
            [self showHint:@"请正确输入手机号"];
        }
    }else{
        [self showHint:@"请输入姓名"];
    }
}

- (BOOL) isAllParms
{
    NSArray *keys = [_parms allKeys];
    if ([keys containsObject:@"yzsq_role"]) {
        if ([keys containsObject:@"yzsq_mode"]) {
            if ([keys containsObject:@"yzsq_reason"]) {
                if ([keys containsObject:@"yzsq_state"]) {
                    
                    if (_txtView_on.text.length>0) {
                        [_parms setObject:_txtView_on.text forKey:@"yzsq_reasonabstract"];
                        
                        if (_txtView_under.text.length>0) {
                            [_parms setObject:_txtView_under.text forKey:@"yzsq_other"];
                        }
                        return YES;
                    }else{
                        [self showHint:@"请输入案情理由概述(必填)"];
                        return NO;
                    }
                    
                }else{
                    [self showHint:@"请选择-法律状态"];
                    return NO;
                }
            }else{
                [self showHint:@"请选择-事项案由"];
                return NO;
            }
        }else{
            [self showHint:@"请选择-援助方式"];
            return NO;
        }
    }else{
        [self showHint:@"请选择-申请人角色"];
        return NO;
    }
}

- (void)reset
{
    _parms = [NSMutableDictionary dictionary];
    _txtView_on.text = nil;
    _txtView_under.text = nil;
    _txtPhone.text = nil;
    _txtName.text = nil;
    NSArray *titles =@[@"请选择申请人角色",@"请选择辩护方式",@"请选择事项案由",@"请选择法律状态"];
    for (int tag=11; tag<15; tag++) {
       UIButton *btn = (UIButton*)[self.view viewWithTag:tag];
        [btn setTitle:titles[tag-11] forState:UIControlStateNormal];
    }
    
}
#pragma mark - TextFieldDelegate -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length>0) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"";
        }else{
            _lblplaceholder_under.text = @"";
        }

    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述(必填)";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
        }

    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    CGFloat y = _scorllView.contentSize.height - _scorllView.bounds.size.height;
    if (textView==_txtView_on) {
        [_scorllView setContentOffset:CGPointMake(0, y) animated:YES];
    }else{
        [_scorllView setContentOffset:CGPointMake(0, y+200) animated:YES];
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述(必填)";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
            CGFloat y = _scorllView.contentSize.height - _scorllView.bounds.size.height;

             [_scorllView setContentOffset:CGPointMake(0, y) animated:YES];
        }
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length>499) {
        if (text.length==0) {
            return YES;
        }else
            return NO;
    }
    if (text.length>0) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"";
        }else{
            _lblplaceholder_under.text = @"";
        }
    }
    if (text.length == 0 &textView.text.length==1) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述(必填)";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"";
        }else{
            _lblplaceholder_under.text = @"";
        }
    }else{
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述(必填)";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
        }
    }
}

#pragma mark - UITextFieldDelegate -


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
