//
//  NetWorkTools.h
//  myShop
//
//  Created by 孙艳东 on 2017/11/29.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,RequestMethod) {
    POST,
    GET
};
typedef void(^responseBlock)(id response, NSError *error);

@interface NetWorkTools : NSObject



/**
 创建并返回networkTools的单利对象

 @return 返回networkTools的单例对象
 */
+ (instancetype)shareNetworkTools;
- (void)requestWithMethod:(RequestMethod)requestMethod urlString:(NSString *)urlString parameters:(id)parameters andFinished:(responseBlock)responseBlock;
@end
