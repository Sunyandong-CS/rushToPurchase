//
//  CategoryModel.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/14.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *FavoritesId;
@property (nonatomic, copy) NSString *FavoritesTitle;
@property (nonatomic, copy) NSString *Icon;
@property (nonatomic, copy) NSString *Id;

/* 保存商品数组 */
@property (nonatomic, strong) NSMutableArray *goodsArr;

@end
