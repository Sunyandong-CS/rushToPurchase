//
//  SYDTabViewController.m
//  rushToPurchase
//
//  Created by 孙艳东 on 2017/11/8.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "SYDTabViewController.h"
#import "SYDNavgationViewController.h"
#import "HomeViewController.h"
#import "PreferentialViewController.h"
#import "UserInfoController.h"
#import "UIImage+SYDImage.h"
@interface SYDTabViewController ()

@end

@implementation SYDTabViewController

/**
 设置tabbar的属性及其渲染颜色
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加所有子控制器
    [self setUpAllChildViewControllers];
    
    // 2.设置tabBar按钮
    [self setUpAllTabBarButtons];
    
}

- (void)setUpAllChildViewControllers {
    // 首页控制器
    // 1.创建子控制器 ---->创建导航控制器 ----> 设置导航控制器的根控制器---->添加子控制器
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    SYDNavgationViewController *navHome = [[SYDNavgationViewController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:navHome];
    
    // 优惠精选控制器
    PreferentialViewController *preferVc = [[PreferentialViewController alloc] init];
    SYDNavgationViewController *navPrefer = [[SYDNavgationViewController alloc] initWithRootViewController:preferVc];
    [self addChildViewController:navPrefer];
    
    // 用户中心控制器
    UserInfoController *userInfoVc = [[UserInfoController alloc] init];
    SYDNavgationViewController *navUserInfo = [[SYDNavgationViewController alloc] initWithRootViewController:userInfoVc];
    [self addChildViewController:navUserInfo];
}

- (void)setUpAllTabBarButtons {
    // 设置UITabBarItem的渲染颜色
    UITabBarItem *item=[UITabBarItem appearance];
    [self setTabBarItem:item];
    
    // 设置按钮属性
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页推荐";
    nav.tabBarItem.image = [UIImage imageNamed:@"home-icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"home-select-icon"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"优惠抢购";
    nav1.tabBarItem.image = [UIImage imageNamed:@"prefer-icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"prefer-select-icon"];
    
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"个人中心";
    nav2.tabBarItem.image = [UIImage imageNamed:@"user-icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"user-select-icon"];
    
}

/**
 设置tabbaritem的渲染颜色
 */
- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    NSMutableDictionary *atts=[NSMutableDictionary dictionary];
    atts[NSForegroundColorAttributeName]=[UIColor grayColor];
    NSMutableDictionary *selectedAtts=[NSMutableDictionary dictionary];
    selectedAtts[NSForegroundColorAttributeName]=[UIColor redColor];
    [tabBarItem setTitleTextAttributes:atts forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
    
}
@end
