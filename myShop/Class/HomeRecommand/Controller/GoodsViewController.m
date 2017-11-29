//
//  GoodsViewController.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/15.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsViewCell.h"
#import "SYDConst.h"
#import "NetWorkTools.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "GoodsViewCell.h"
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
#import <SVProgressHUD.h>
#define ScreenW [UIScreen mainScreen].bounds.size.width

@interface GoodsViewController ()<UICollectionViewDelegateFlowLayout>
/* 请求管理者 */
//@property (nonatomic, strong) AFHTTPSessionManager *manager;
/* 下一次要请求的页面 */
@property (nonatomic, assign) NSInteger pageNo;
/* 保存商品的数组 */
@property (nonatomic, strong) NSMutableArray *goodsArr;
@end

@implementation GoodsViewController

static NSString * const reuseIdentifier = @"GoodsViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 顶部偏移适配ios11
    if (@available(iOS 11.0, *)){
       self.collectionView.contentInset = UIEdgeInsetsMake(NavbarH, 0, 0, 0);
    }
    
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    
    // 1.添加上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCollectionViewData)];
    // 加载数据
    [self loadCollectionViewData];

    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}
//- (void)loadCollectionViewData {
//
//    // 解决连续下拉共存的方法，取消之前的任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//
//    if (!self.pageNo) {
//        self.pageNo = 1;
//    }
//    // 设置请求参数
//    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
//    paramerters[@"favoritesId"] = self.favoritesId;
//    paramerters[@"pageNo"] = @"1";
//
//    // 发送请求
//    [self.manager GET:Products_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        // 保存请求数据 --- 字典数组转模型数组
//        NSMutableArray *itemArr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        [self.goodsArr addObjectsFromArray:itemArr];
//
//        // 刷新数据
//        [self.collectionView reloadData];
//        self.pageNo ++;
//        // 结束上拉刷新
//        [self.collectionView.mj_footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 设置请求数据失败的提示
//        [SVProgressHUD showErrorWithStatus:@"加载数据失败！请检查网络连接状况.."];
//
//    }];
//}
- (void)loadCollectionViewData {
    
    NetWorkTools *tools = [NetWorkTools shareNetworkTools];
    
    if (!self.pageNo) {
        self.pageNo = 1;
    }
    
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"favoritesId"] = self.favoritesId;
    paramerters[@"pageNo"] = @"1";
    
    [tools requestWithMethod:GET urlString:Products_URL parameters:paramerters andFinished:^(id response, NSError *error) {
        if (error != nil) {
            // 设置请求数据失败的提示
            [SVProgressHUD showErrorWithStatus:@"加载数据失败！请检查网络连接状况.."];
            [self.collectionView.mj_footer endRefreshing];
            return ;
        } else {
            // 保存请求数据 --- 字典数组转模型数组
            NSMutableArray *itemArr = [GoodsModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
            [self.goodsArr addObjectsFromArray:itemArr];
            
            // 刷新数据
            [self.collectionView reloadData];
            self.pageNo ++;
            // 结束上拉刷新
            [self.collectionView.mj_footer endRefreshing];
        }
    }];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.goods = self.goodsArr[indexPath.row];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (ScreenW - 3 * SYDCellMargin) / 2;
    
    CGSize itemSize = CGSizeMake(itemW,itemW + 40);
    return itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return SYDCellMargin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SYDCellMargin;
}
#pragma mark <UICollectionViewDelegate>

/**
 点击cell要执行的操作
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转至商品详情界面
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
    // 传递商品详细信息
    detailVC.goods = self.goodsArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark ---- lazy load
- (NSMutableArray *)goodsArr {
    if (_goodsArr == nil) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}
//- (AFHTTPSessionManager *)manager {
//    if (_manager == nil) {
//        _manager = [AFHTTPSessionManager manager];
//    }
//    return  _manager;
//}
@end
