//
//  SYDNavgationViewController.m
//  rushToPurchase
//
//  Created by 孙艳东 on 2017/11/8.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "SYDNavgationViewController.h"

@interface SYDNavgationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SYDNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 统一设置标题栏颜色
    [self setNavigationBarStyle];
    
    // 添加全屏滑动返回手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setNavigationBarStyle {
    // 设置全局导航栏背景颜色和字体
    [self.navigationBar setBarTintColor:[UIColor redColor]];
    
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:22];
    attrDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:attrDict];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

@end
