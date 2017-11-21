//
//  GoodsDetailCell.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/18.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^openPurchaseBlock)(id sender);
@class GoodsModel;
@interface GoodsDetailCell : UITableViewCell
/* 商品信息 */
@property (nonatomic, strong) GoodsModel *goods;

/* 跳转至淘宝H5页面 */
@property (nonatomic, strong) openPurchaseBlock purchaseBlock;
@end
