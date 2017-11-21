//
//  GoodsViewCell.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/13.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface GoodsViewCell : UICollectionViewCell
/* cell的属性 */
@property (nonatomic, strong) GoodsModel *goods;
@end
