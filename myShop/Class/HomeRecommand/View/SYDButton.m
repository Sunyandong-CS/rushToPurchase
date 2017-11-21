//
//  SYDButton.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/14.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "SYDButton.h"
#import "UIView+frame.h"
@implementation SYDButton
// 重新设置按钮的排布
- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置图片的位置
    self.imageView.y = 10;
    self.imageView.centerX = self.width * 0.5;
    // 设置文字的位置
    self.titleLabel.y = self.height - self.titleLabel.height - 10;
    self.titleLabel.centerX = self.width * 0.5;
    [self.titleLabel sizeToFit];
    // 设置文字的大小
    // 适配字体大小
    CGFloat fontSize = [UIScreen mainScreen].bounds.size.width > 320 ? 15 : 10;
    [self.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}



@end
