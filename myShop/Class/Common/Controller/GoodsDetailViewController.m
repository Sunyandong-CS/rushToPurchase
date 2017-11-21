//
//  GoodsDetailViewController.m
//  myShop
//
//  Created by 孙艳东 on 2017/11/16.
//  Copyright © 2017年 孙艳东. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GoodsModel.h"
#import "SYDConst.h"
#import "GoodsWebViewController.h"
#import "GoodsDetailCell.h"
#import "GoodsPictureCell.h"

static NSString * const GoodsDetail = @"GoodsDetailCell";
static NSString * const GoodsPicture = @"GoodsPictureCell";

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsDetailCell class]) bundle:nil] forCellReuseIdentifier:GoodsDetail];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GoodsPictureCell class]) bundle:nil] forCellReuseIdentifier:GoodsPicture];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.SmallImages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetail forIndexPath:indexPath];
        cell.goods = self.goods;
        
        // 给cell的按钮点击block赋值
        __weak typeof(self) wself = self;
        cell.purchaseBlock = ^(NSString *url) {
            GoodsWebViewController *webVC = [[GoodsWebViewController alloc] init];
            webVC.url = wself.goods.ItemUrl;
            [wself.navigationController pushViewController:webVC animated:YES];
        };
        return cell;
    }else {
        GoodsPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsPicture forIndexPath:indexPath];
        cell.pictureUrl = self.goods.SmallImages[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.goods.cellHeight;
    }else {
        return [UIScreen mainScreen].bounds.size.width - SYDMargin;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
