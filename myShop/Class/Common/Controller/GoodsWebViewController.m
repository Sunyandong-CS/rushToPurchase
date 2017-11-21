//
//  GoodsWebViewController.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/19.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsWebViewController.h"
#import <WebKit/WKWebView.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "SYDConst.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface GoodsWebViewController ()
/* progressView */
@property (nonatomic, weak) UIProgressView *progress;
/* wkWebView */
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation GoodsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    // 1.创建进度条控件
    [self setUpProgressView];
    // 2.创建WkWebView并展示
    [self setUpWebView];
}

- (void)setUpProgressView {
    UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavbarH, ScreenW, 20)];
    [self.view addSubview:progress];
    self.progress = progress;
}

- (void)setUpWebView {
    CGRect frame = CGRectMake(0,
                              0,
                              [UIScreen mainScreen].bounds.size.width,
                              [UIScreen mainScreen].bounds.size.height);
    WKWebView *webView = [[WKWebView alloc] initWithFrame:frame];
    [self.view addSubview:webView];
    self.webView = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // 监听属性方法
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [SVProgressHUD showProgress:self.progress.progress status:@"正在加载商品信息..."];
}

/**
 监听变化加载进度条
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.progress.progress = self.webView.estimatedProgress;
    
    if (self.webView.estimatedProgress >= 1) {
        self.progress.hidden = YES;
        [SVProgressHUD dismiss];
    }
}

/**
 移除通知
 */
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
