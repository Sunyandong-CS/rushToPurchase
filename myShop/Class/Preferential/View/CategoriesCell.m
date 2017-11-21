//
//  CategoriesCell.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/19.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "CategoriesCell.h"
@interface CategoriesCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@end
@implementation CategoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 设置背景颜色
    self.backgroundColor = [UIColor lightGrayColor];
    // 设置选中标示背景颜色
    
    self.selectView.backgroundColor = [UIColor colorWithRed:219 green:21 blue:26 alpha:1];
    
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = title;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // 设置选中View的状态
    self.selectView.hidden = !selected;
    self.titleLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
}

@end
