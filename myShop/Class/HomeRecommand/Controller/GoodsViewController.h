//
//  GoodsViewController.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/15.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GoodsType) {
    ChiffonType = 0,   // 雪纺
    JeansType ,        // 牛仔裤
    VestType,          // 小背心
    SkirtType,         // 半身裙
    ShirtType,         // 衬衫
    TShirtType,        // T恤
    DressType,         // 连衣裙
    TrousersType       // 休闲裤
};
@interface GoodsViewController : UICollectionViewController
/* 类型说明 */
@property (nonatomic, assign) GoodsType type;
/* favoritesId */
@property (nonatomic, copy) NSString *favoritesId;
@end
