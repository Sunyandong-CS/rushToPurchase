//
//  GoodsPictureCell.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/19.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsPictureCell.h"
#import <UIImageView+WebCache.h>
@interface GoodsPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsPictV;

@end

@implementation GoodsPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPictureUrl:(NSString *)pictureUrl {
    _pictureUrl = pictureUrl;
    
    // 设置图片
    [self.goodsPictV sd_setImageWithURL:[NSURL URLWithString:pictureUrl]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
