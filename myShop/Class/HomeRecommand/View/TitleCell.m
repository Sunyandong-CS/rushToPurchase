//
//  TitleCell.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/14.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "TitleCell.h"

@implementation TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 5;
    [super setFrame:frame];
}
@end
