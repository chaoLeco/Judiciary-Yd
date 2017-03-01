//
//  YdBasisViewController.m
//  judiciary
//
//  Created by lecochao on 2017/2/21.
//  Copyright © 2017年 yunduan. All rights reserved.
//

#import "YdBasisViewController.h"

@interface YdBasisViewController ()<WKUIDelegate>

@end

@implementation YdBasisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
        [self.view sendSubviewToBack:_wkWebView];
    }
    return _wkWebView;
}

- (void)webLoadRequestUrl:(NSString *)url
{
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


- (BOOL)isFlag:(id)json
{
    if (json) {
        if ([json[@"flag"] intValue] ==1) {
            return YES;
        }else{
            [self showHint:json[@"message"]];
            return NO;
        }
    }else{
        [self showHint:@"数据获取失败！"];
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKUIDelegate -
// 创建新的webview
// 可以指定配置对象、导航动作对象、window特性
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return webView;
}

// webview关闭时回调
- (void)webViewDidClose:(WKWebView *)webView
{
    
}

// 调用JS的alert()方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
}

// 调用JS的confirm()方法

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    
}

// 调用JS的prompt()方法
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    
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
