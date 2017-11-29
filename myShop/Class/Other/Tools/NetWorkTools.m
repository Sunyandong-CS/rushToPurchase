//
//  NetWorkTools.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/29.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "NetWorkTools.h"
#import <AFNetworking.h>

@implementation NetWorkTools
+ (instancetype)shareNetworkTools {
    static NetWorkTools *networkTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkTools = [[self alloc] init];
    });
    return networkTools;
}

- (void)requestWithMethod:(RequestMethod)requestMethod urlString:(NSString *)urlString parameters:(id)parameters andFinished:(responseBlock)responseBlock {
    
    void (^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseBlock(responseObject,nil);
    };
    void (^failureBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseBlock(nil,error);
    };

    if (requestMethod == GET) {
        [[AFHTTPSessionManager manager] GET:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
    } else {
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:nil success:successBlock failure:failureBlock];
    }
    
}



@end
