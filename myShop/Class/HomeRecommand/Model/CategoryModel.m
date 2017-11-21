//
//  CategoryModel.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/14.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (NSMutableArray *)goodsArr {
    if (!_goodsArr) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}
@end
