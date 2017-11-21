//
//  PreferentialViewController.m
//  rushToPurchase
//
//  Created by 孙艳东 on 2017/11/8.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "PreferentialViewController.h"
#import "CategoriesCell.h"
#import "GoodsViewCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
#import "SYDConst.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "CategoryModel.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width

static NSString * const categoriesCellId = @"categoriesCell";
static NSString * const goodsCellId = @"goodsCell";

@interface PreferentialViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/* 请求管理者对象 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/* 保存左边推荐栏的数组 */
@property (nonatomic, strong) NSMutableArray<CategoryModel *> *categoriesArr;

/* 保存当前页码 */
@property (nonatomic, assign) NSInteger pageNo;
/* 保存favoritesId */
@property (nonatomic, copy) NSString *favoritesId;

@end

@implementation PreferentialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠精选";
    // 1.加载tableview和collectionView
    [self setUpTableViewAndCollectionView];
    
    [self loadCategoriesViewData];
}
#pragma mark 初始化
/**
 设置tableview和collectionView
 */
- (void)setUpTableViewAndCollectionView {
    self.tableView.backgroundColor = [UIColor grayColor];
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoriesCell class]) bundle:nil] forCellReuseIdentifier:categoriesCellId];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsViewCell class]) bundle:nil] forCellWithReuseIdentifier:goodsCellId];
    // 添加上拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCollectionNewData)];
    
    // 添加下拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCollectionViewData)];
    
}

#pragma 数据请求

/**
 加载左边选项卡数据
 */
- (void)loadCategoriesViewData {
    // 加载左边数据时，禁止屏幕触摸事件
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
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
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
        // 默认选择第一个
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self loadCollectionViewData]; // 加载collectionViewdata
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
        if (error != nil) {
            [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
            return;
        }
    }];
}

/**
  加载右边collectionView的数据
 */
- (void)loadCollectionViewData {
    
    // 解决取消之前的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (!self.pageNo) {
        self.pageNo = 1;
    }
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"favoritesId"] = self.categoriesArr[self.tableView.indexPathForSelectedRow.row].FavoritesId;
    paramerters[@"pageNo"] = [NSString stringWithFormat:@"%li",(long)self.pageNo];
    
    // 发送请求
    [self.manager GET:Products_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存请求数据 --- 字典数组转模型数组
        NSMutableArray *itemArr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.categoriesArr[self.tableView.indexPathForSelectedRow.row].goodsArr addObjectsFromArray:itemArr];
        // 刷新数据
        [self.collectionView reloadData];
//        self.collectionView.contentOffset = CGPointMake(0, -NavbarH); // collectionView回滚到顶部
        self.pageNo ++;
        // 结束上拉刷新
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
        [SVProgressHUD showErrorWithStatus:@"加载数据失败！请检查网络连接状况.."];
    }];
}

/**
 加载右边collectionView的数据
 */
- (void)loadCollectionNewData {
    
    // 解决取消之前的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (!self.pageNo) {
        self.pageNo = 1;
    }
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"favoritesId"] = self.categoriesArr[self.tableView.indexPathForSelectedRow.row].FavoritesId;
    paramerters[@"pageNo"] = @"1";
    
    // 发送请求
    [self.manager GET:Products_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存请求数据 --- 字典数组转模型数组
        NSMutableArray *itemArr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.categoriesArr[self.tableView.indexPathForSelectedRow.row].goodsArr = itemArr;
        // 刷新数据
        [self.collectionView reloadData];
        self.pageNo ++;
        // 结束上拉刷新
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
        [SVProgressHUD showErrorWithStatus:@"加载数据失败！请检查网络连接状况.."];
    }];
}



#pragma mark -- tableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoriesCell *cell = [self.tableView dequeueReusableCellWithIdentifier:categoriesCellId forIndexPath:indexPath];
    cell.title = self.categoriesArr[indexPath.row].FavoritesTitle;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoriesArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

#pragma mark -- tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 选中category某项触发的事件
    self.pageNo = 1;
    if (!self.categoriesArr[indexPath.row].goodsArr.count) {
        [self.collectionView.mj_header beginRefreshing];
//        [self loadCollectionViewData];
        
    }else {
        [self.collectionView reloadData];
    }
}

#pragma mark -- collectionViewDataSource
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GoodsViewCell  *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:goodsCellId forIndexPath:indexPath];
    cell.goods = self.categoriesArr[self.tableView.indexPathForSelectedRow.row].goodsArr[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.categoriesArr.count) {
        return [self.categoriesArr[self.tableView.indexPathForSelectedRow.row] goodsArr].count;
    }else {
        return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat itemW = (ScreenW - self.tableView.frame.size.width) / 2 - SYDCellMargin;
    CGFloat itemH = itemW + 30;
    
    return CGSizeMake(itemW, itemH);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return SYDCellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SYDCellMargin;
}
#pragma mark -- collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转至商品详情界面
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
    // 传递商品详细信息
    detailVC.goods = self.categoriesArr[self.tableView.indexPathForSelectedRow.row].goodsArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark lazy load
- (NSMutableArray<CategoryModel *> *)categoriesArr {
    if (_categoriesArr == nil) {
        _categoriesArr = [NSMutableArray array];
    }
    return _categoriesArr;
}


- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
@end
