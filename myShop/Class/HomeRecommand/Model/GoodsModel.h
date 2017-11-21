//
//  GoodsModel.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/15.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
@property (nonatomic, copy) NSString *ClickUrl;
@property (nonatomic, copy) NSString *ItemUrl;
@property (nonatomic, copy) NSString *PictUrl;
@property (nonatomic, copy) NSString *ProvCity;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Nick;
@property (nonatomic, copy) NSString *ReservePrice;
@property (nonatomic, copy) NSString *ZkFinalPrice;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *NumIid;
@property (nonatomic, copy) NSString *SellerId;
@property (nonatomic, copy) NSArray *SmallImages;
/* 保存cell的高度 */
@property (nonatomic, assign) NSInteger cellHeight;
@end
