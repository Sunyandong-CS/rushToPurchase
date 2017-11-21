//
//  UserInfoController.m
//  rushToPurchase
//
//  Created by 孙艳东 on 2017/11/8.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "UserInfoController.h"
#import "UserInfoWebViewController.h"

@interface UserInfoController ()
/* 保存链接的数组 */
@property (nonatomic, strong) NSArray *itemsArr;
@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    
    // 初始化tableView数据
    [self setUpTableView];
    
}

- (void)setUpTableView {
    
    NSArray *items = @[
             @{ @"title" : @"我的淘宝", @"link" : @"https://h5.m.taobao.com/mlapp/mytaobao.html#mlapp-mytaobao" },
             @{ @"title" : @"购物车" , @"link" : @"https://h5.m.taobao.com/mlapp/cart.html" },
             @{ @"title" : @"我的订单", @"link" : @"https://h5.m.taobao.com/mlapp/olist.html" },
             @{ @"title" : @"待付款", @"link" : @"https://h5.m.taobao.com/mlapp/olist.html?spm=a2141.7756461.2.1&tabCode=waitPay" },
             @{ @"title" : @"待发货", @"link" : @"https://h5.m.taobao.com/mlapp/olist.html?spm=a2141.7756461.2.2&tabCode=waitSend" },
             @{ @"title" : @"待收货", @"link": @"https://h5.m.taobao.com/mlapp/olist.html?spm=a2141.7756461.2.3&tabCode=waitConfirm" },
             @{ @"title" : @"待评价", @"link": @"https://h5.m.taobao.com/mlapp/olist.html?spm=a2141.7756461.2.4&tabCode=waitRate" }
             ];
    self.itemsArr = items;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.itemsArr[indexPath.row][@"title"];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoWebViewController *userWebVC = [[UserInfoWebViewController alloc] init];
    userWebVC.title = self.itemsArr[indexPath.row][@"title"];
    userWebVC.link = self.itemsArr[indexPath.row][@"link"];
    [self.navigationController pushViewController:userWebVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
