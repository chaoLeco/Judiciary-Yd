//
//  YdFeedbackViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/22.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdFeedbackViewController.h"

@interface YdFeedbackViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblplaceholder;

@end

@implementation YdFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gobackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TextFieldDelegate -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lblplaceholder.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        _lblplaceholder.text = @"请输入您要反馈的内容...";
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    if (textView==_txtView_on) {
//        [_scorllView setContentOffset:CGPointMake(0, 50) animated:YES];
//    }else{
//        [_scorllView setContentOffset:CGPointMake(0, 250) animated:YES];
//    }
//    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {

        _lblplaceholder.text = @"请输入您要反馈的内容...";

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

        _lblplaceholder.text = @"";

    }
    if (text.length == 0 &textView.text.length==1) {

        _lblplaceholder.text = @"请输入您要反馈的内容...";

    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>0) {
        _lblplaceholder.text = @"";

    }else{

        _lblplaceholder.text = @"请输入您要反馈的内容...";

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
