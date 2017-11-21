//
//  MenuView.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/13.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "MenuView.h"
#import "SYDButton.h"
#import <AFNetworking.h>
#import "UIView+frame.h"
#import <UIImageView+WebCache.h>
#import "SYDConst.h"
#import "UIImage+SYDImage.h"
#import "CategoryModel.h"
#import <MJExtension/MJExtension.h>

@interface MenuView()

@end

@implementation MenuView
- (void)awakeFromNib {
    [super awakeFromNib];

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 重写
        [self loadCategoriesViewData];
    }
    return self;
}

- (void)layoutSubviews {

}

- (void)addButton {
        
    /* 按钮属性 */
    NSInteger count = 4;
    CGFloat btnMargin = 10;
    CGFloat buttonW = ([UIScreen mainScreen].bounds.size.width - (count + 1) * btnMargin) / count ;
    CGFloat buttonH = buttonW;
    CGFloat btnY = 0;
    CGFloat BtnX = 0;
    
    NSArray *iconArr = @[@"xuefang.png",@"jeans.png",@"beixin.png",@"xuefang.png",@"jeans.png",@"beixin.png",@"xuefang.png",@"jeans.png"];
    
    for (NSInteger i = 0;i < self.categoriesArr.count ; i++) {
        // 创建button
        btnY = i / count * buttonH + btnMargin ;
        BtnX = buttonW * (i % count) + (i % count + 1) * btnMargin;
        SYDButton *button = [SYDButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage syd_circleImage:[UIImage imageNamed:iconArr[i]]] forState:UIControlStateNormal];
        
        [button setTitle:self.categoriesArr[i].FavoritesTitle forState:UIControlStateNormal];
        
        // 适配字体大小
        CGFloat fontSize = [UIScreen mainScreen].bounds.size.width > 320 ? 15 : 10;
        // 设置标题字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i;
        // 添加点击事件
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake( BtnX ,btnY, buttonW,buttonH);
        // 设置button的frame
        [self addSubview:button];
    }
    
    [self reloadInputViews];
}

- (void)loadCategoriesViewData {
    // 创建请求对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"appTag"] = @"dress";
    // 发送请求
    [mgr GET:Categories_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存请求数据 --- 字典数组转模型数组
        NSMutableArray<CategoryModel *> *itemArr = [CategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.categoriesArr = itemArr;
        [self addButton];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
    }];
}

- (void)btnClick:(SYDButton *)button {
    
    __weak typeof(self) wself = self;
    if (self.pushViewBlock) {
        // 传入favoritesId
        self.pushViewBlock(wself.categoriesArr[button.tag].FavoritesId);
    }
}

@end
