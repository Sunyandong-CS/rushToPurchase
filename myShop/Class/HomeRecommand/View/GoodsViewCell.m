//
//  GoodsViewCell.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/13.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsViewCell.h"
#import "GoodsModel.h"
#import <UIImageView+WebCache.h>
@interface GoodsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPricelabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

@end
@implementation GoodsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 重写setter方法，加载cell信息
- (void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    
    // 加载控件信息
    [self.goodsPic sd_setImageWithURL:[NSURL URLWithString:goods.PictUrl]];
    self.goodsDescriptionLabel.text = goods.Title;
    
    // 当前价格
    NSString *currStr = [NSString stringWithFormat:@"￥%@",goods.ZkFinalPrice];
    self.currentPricelabel.text = currStr;
    
    // 划中划线
    NSString *oldStr = [NSString stringWithFormat:@"￥%@",goods.ReservePrice];
    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:oldStr attributes:attribtDic];
    self.oldPriceLabel.attributedText = attribtStr;
}

@end

