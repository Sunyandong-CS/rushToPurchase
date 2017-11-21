//
//  GoodsDetailViewController.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/16.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface GoodsDetailViewController : UITableViewController
/* 商品信息 */
@property (nonatomic, strong) GoodsModel *goods;
@end
