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
@end

@implementation YdAssistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseAction:(UIButton *)sender {
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
        [OrderPickerView showViewStyleDefaultWithData:titles Block:^(id data) {
            if (data) {
                [sender setTitle:data forState:UIControlStateNormal];
            }
        }];
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
            _lblplaceholder_on.text = @"请输入案情理由概述";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
        }

    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView==_txtView_on) {
        [_scorllView setContentOffset:CGPointMake(0, 50) animated:YES];
    }else{
        [_scorllView setContentOffset:CGPointMake(0, 250) animated:YES];
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
             [_scorllView setContentOffset:CGPointMake(0, 50) animated:YES];
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
    if (text.length>0) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"";
        }else{
            _lblplaceholder_under.text = @"";
        }
    }
    if (text.length == 0 &textView.text.length==1) {
        if (textView==_txtView_on) {
            _lblplaceholder_on.text = @"请输入案情理由概述";
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
            _lblplaceholder_on.text = @"请输入案情理由概述";
        }else{
            _lblplaceholder_under.text = @"请输入其他情况说明";
        }
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
