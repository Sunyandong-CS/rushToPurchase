//
//  MenuView.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/13.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PushViewBlock) (NSString *type);

@class CategoryModel;
@interface MenuView : UIView
/* 保存categories数据模型数组 */
@property (nonatomic, strong) NSMutableArray<CategoryModel *> *categoriesArr;
/* 处理按钮点击事件的Block */
@property (nonatomic, strong) PushViewBlock pushViewBlock;
@end
