//
//  PictureModel.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/13.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject
/* 点击图片要跳转的链接 */
@property (nonatomic, copy) NSString *ClickUrl;
/* 图片地址 */
@property (nonatomic, copy) NSString *PictUrl;
/* ItemUrl */
@property (nonatomic, copy) NSString *ItemUrl;
/* 标题 */
@property (nonatomic, copy) NSString *Title;
@end
