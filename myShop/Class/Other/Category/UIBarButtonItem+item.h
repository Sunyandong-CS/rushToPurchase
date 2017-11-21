//
//  UIBarButtonItem+item.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/21.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)
+ (UIBarButtonItem *)navBackButtonWithImage:(NSString *)imageName AndHighlightImage:(NSString *)highlightImageName target:(id)target action:(SEL)action title:(NSString *)title;
@end
