//
//  HomeViewController.m
//  rushToPurchase
//
//  Created by 孙艳东 on 2017/11/8.
//  Copyright © 2017年 孙艳东. All rights reserved.
//
/************分享功能*************/
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
/********************************/
#import "HomeViewController.h"
#import "SYDConst.h"
#import <AFNetworking.h>
#import <SDCycleScrollView.h>
#import "PictureModel.h"
#import "GoodsViewCell.h"
#import "CategoryModel.h"
#import "MenuView.h"
#import "TitleCell.h"
#import "GoodsModel.h"
#import "GoodsViewController.h"
#import "GoodsDetailViewController.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define CycleScrollViewH 200
#define CategoryH 200
#define Margin 4

static NSString * const TableCellId = @"tableCell";
static NSString * const CollectionCellID = @"cell";

@interface HomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
/* 保存顶部滚动图片数据的数组 */
@property (nonatomic, strong) NSMutableArray *pictureArr;

/* 保存商品列表数据数组 */
@property (nonatomic, strong) NSMutableArray *goodsArr;
/* 滚懂得scrollView */
@property (nonatomic, weak) SDCycleScrollView *cycleScrollView;
/* collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/* categoriesView */
@property (nonatomic, weak) MenuView *categoriesView;
/* 保存顶部两个视图的View */
@property (nonatomic, strong) UIView *contentV;
/* 请求管理者对象 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/* 加载页数记录器 */
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation HomeViewController

- (UIView *)contentV {
    if (_contentV == nil) {
        CGFloat menuH = CategoryH;
        menuH =  ScreenW > 320 ? CategoryH : CategoryH - 20;
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(0, NavbarH,ScreenW, CycleScrollViewH + menuH)];
    }
    return _contentV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置标题和分享按钮
    [self setUpNavBar];
    
    // 2.设置顶部图片滚动区域 scrollview
    [self setCircleImageView];
    
    // 3.添加底部collectionView
    [self setUpCollectionView];
    
    // 4.添加底部刷新控价
    [self setUpFootRefresh];
    
    // 5.加载商品列表数据
    [self loadCollectionViewData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TitleCell class]) bundle:nil] forCellReuseIdentifier:TableCellId];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
}

#pragma mark -- 初始化页面

- (void)setCircleImageView {
    
    CGRect rect = CGRectMake(0, 0, ScreenW, CycleScrollViewH);
    // 添加顶部循环展示的图片
    UIImage *placeHolderImage = [UIImage imageNamed:@""];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:placeHolderImage];
    self.cycleScrollView = cycleScrollView;
    cycleScrollView.imageURLStringsGroup = @[@"",@"",@"",@"",@""];
    [self.contentV addSubview:cycleScrollView];
    
    
    // 添加Categories部分
    CGFloat menuH = CategoryH;
    menuH =  ScreenW > 320 ? CategoryH : CategoryH - 20;
    
    MenuView *menuView = [[MenuView alloc] initWithFrame:CGRectMake(0, CycleScrollViewH, ScreenW, menuH)];
    self.categoriesView = menuView;
    menuView.autoresizesSubviews = YES;
    menuView.backgroundColor = [UIColor whiteColor];
    
    // 点击按钮跳转页面的Block执行事件
    menuView.pushViewBlock = ^(NSString *favoritesId) {
        GoodsViewController *goodsVC = [[GoodsViewController alloc] initWithNibName:NSStringFromClass([GoodsViewController class]) bundle:nil];
        goodsVC.favoritesId = favoritesId;
        [self.navigationController pushViewController:goodsVC animated:YES];
    };
    [self.contentV addSubview:menuView];
    
    self.tableView.tableHeaderView  = self.contentV;
    // 加载数据
    [self loadCycleScrollViewData];
}


- (void)setUpNavBar {
    
    // 设置标题
    self.navigationItem.title = @"首页";
    
    // 把按钮包装成View添加到navigationItem中,直接添加按钮会导致在导航栏其他地方也能点击，需要创建UIView 并添加Button才行
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"share-select"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchDown];
    
    [barButton sizeToFit];
    UIView *cusntomView = [[UIView alloc] initWithFrame:barButton.bounds];
    [cusntomView addSubview:barButton];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:cusntomView];
    
    // 添加view
    [self.navigationItem setRightBarButtonItem:rightItem];
}

- (void)setUpCollectionView {
    
    
    /**
     使用collectionView 注意事项
     1.使用流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置collection的尺寸需要使用layout
    CGFloat itemW = (ScreenW - 3 * Margin) / 2;
    
    layout.itemSize = CGSizeMake(itemW,itemW + 40);
    layout.minimumLineSpacing = Margin;
    layout.minimumInteritemSpacing = Margin;
    
    // 设置frame
    CGRect frame = CGRectMake(0,
                              CycleScrollViewH + CategoryH + NavbarH,
                              ScreenW,
                              ScreenH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    self.collectionView = collectionView;
    // 设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    // 添加View
    self.tableView.tableFooterView = collectionView;
    
    // 注册collectionCell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsViewCell class]) bundle:nil] forCellWithReuseIdentifier:CollectionCellID];
}

- (void)setUpFootRefresh {
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCollectionViewData)];
}

// 顶部分享功能
- (void)share {
    
    //1、创建分享参数
    NSArray* imageArray = @[@"http://mob.com/Assets/images/logo.png?v=20150320"];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }
    
}

#pragma mark 网络请求
- (void)loadCycleScrollViewData {
    // 创建请求对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"favoritesId"] = @"2056439";
    paramerters[@"pageNo"] = @"1";
    paramerters[@"pageSize"] = @"5";
    
    // 发送请求
    [mgr GET:Products_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存请求数据 --- 字典数组转模型数组
        NSMutableArray *itemArr = [PictureModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.pictureArr  = itemArr;
        
        
        NSMutableArray *urlArr = [NSMutableArray array];
        if (itemArr.count) {
            for (PictureModel *model in itemArr) {
                NSString *url =  model.PictUrl;
                [urlArr addObject:url];
            }
        }
        self.cycleScrollView.imageURLStringsGroup = urlArr;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
    }];
}


- (void)loadCollectionViewData {
    
    // 解决连续下拉共存的方法，取消之前的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (!self.pageNo) {
        self.pageNo = 1;
    }
    // 设置请求参数
    NSMutableDictionary *paramerters = [NSMutableDictionary dictionary];
    paramerters[@"favoritesId"] = @"2056439";
    paramerters[@"pageNo"] = [NSString stringWithFormat:@"%li",(long)self.pageNo];
    paramerters[@"pageSize"] = @"20";
    
    // 发送请求
    [self.manager GET:Products_URL parameters:paramerters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 保存请求数据 --- 字典数组转模型数组
        NSMutableArray *itemArr = [GoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.goodsArr addObjectsFromArray:itemArr];
        
        // 刷新数据
        [self.collectionView reloadData];
        self.pageNo ++;
        // 结束上拉刷新
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 设置请求数据失败的提示
    }];
}


#pragma mark 懒加载
- (NSMutableArray *)pictureArr {
    if (_pictureArr == nil) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr;
}

- (NSMutableArray *)goodsArr {
    if (_goodsArr == nil) {
        _goodsArr = [NSMutableArray array];
    }
    return _goodsArr;
}

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return  _manager;
}

#pragma mark collectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
    collectionCell.goods = self.goodsArr[indexPath.row];

    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 跳转至商品详情界面
    GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
    // 传递商品详细信息
    detailVC.goods = self.goodsArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CycleScrollViewH + CategoryH;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TitleCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TableCellId forIndexPath:indexPath];
    return cell;
}


@end
