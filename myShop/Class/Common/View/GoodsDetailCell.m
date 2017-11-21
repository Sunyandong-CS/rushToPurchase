//
//  GoodsDetailCell.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/18.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsDetailCell.h"
#import "GoodsModel.h"
#import <UIImageView+WebCache.h>
@interface GoodsDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageV;
@property (weak, nonatomic) IBOutlet UILabel *goodsCurrentPricelabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionlabel;

@end

@implementation GoodsDetailCell
- (IBAction)gotoBuy:(UIButton *)sender {
    if (self.purchaseBlock) {
        
        self.purchaseBlock(self.goods.ClickUrl);
    }
}

- (void)setGoods:(GoodsModel *)goods {
    _goods = goods;
    // 设置图片
    [self.goodsImageV sd_setImageWithURL:[NSURL URLWithString:goods.PictUrl]];
    // 设置当前价格
    NSString *curStr = [NSString stringWithFormat:@"￥%@",goods.ZkFinalPrice];
    self.goodsCurrentPricelabel.text = curStr;
    // 打折前价格，并划中划线
    NSString *oldStr = [NSString stringWithFormat:@"￥%@",goods.ReservePrice];
    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:oldStr attributes:attribtDic];
    self.goodsOldPriceLabel.attributedText = attribtStr;
    
    // 商品描述信息
    self.goodsDescriptionlabel.text = goods.Title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
