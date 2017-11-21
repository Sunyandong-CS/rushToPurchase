//
//  UIBarButtonItem+item.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/21.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (UIBarButtonItem *)navBackButtonWithImage:(NSString *)imageName AndHighlightImage:(NSString *)highlightImageName target:(id)target action:(SEL)action title:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    // 设置按钮的点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
