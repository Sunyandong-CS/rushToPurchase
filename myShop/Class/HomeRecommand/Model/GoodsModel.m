//
//  GoodsModel.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/15.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsModel.h"
#import "SYDConst.h"
#import <UIKit/UIKit.h>

@implementation GoodsModel

- (NSInteger)cellHeight {
    if (_cellHeight == 0) {
        // 图片的高度
        _cellHeight += [UIScreen mainScreen].bounds.size.width - SYDMargin;
        
        // 价格标签的高度
        _cellHeight += 25 + SYDMargin;
    
        // 商品描述的高度
        CGSize texMaxSize = CGSizeMake( [UIScreen mainScreen].bounds.size.height - SYDMargin * 2, MAXFLOAT); // 限定label的宽度，然后自适应计算高度
        _cellHeight += [self.Title boundingRectWithSize:texMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height + SYDMargin * 2;
        
        // 按钮的高度
        _cellHeight += 40 + SYDMargin;
        
    }
    return _cellHeight;
}
@end
