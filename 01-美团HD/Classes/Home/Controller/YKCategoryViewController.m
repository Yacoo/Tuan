//
//  YKCategoryViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-4.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKCategoryViewController.h"
#import "YKDataTool.h"
#import "YKCategory.h"
#import "YKDropdownLeftCell.h"
#import "YKDropdownRightCell.h"
@interface YKCategoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *leftTableview;
@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@end

@implementation YKCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredContentSize = CGSizeMake(400, 40*[[YKDataTool categories] count]);
    CGFloat rowHeight = 40;
    self.leftTableview.rowHeight = rowHeight;
    self.rightTableview.rowHeight = rowHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.leftTableview){//左边
        return [[YKDataTool categories] count];
    }else{//右边
       NSInteger leftSelectedRow = [self.leftTableview indexPathForSelectedRow].row;
        YKCategory * category = [YKDataTool categories][leftSelectedRow];
        return category.subcategories.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    if(tableView == self.leftTableview){//左边
       cell = [YKDropdownLeftCell cellWithTableview:self.leftTableview];
        YKCategory * category = [YKDataTool categories][indexPath.row];
         cell.textLabel.text = category.name;
        cell.accessoryType = category.subcategories.count ?  UITableViewCellAccessoryDisclosureIndicator :
        UITableViewCellAccessoryNone;
        //当一个cell被选中时内部所有子空间都达到高亮状态，如果设置高亮图片就会切换
        //cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:category.small_highlighted_icon];
      
    }else{//右边
        cell = [YKDropdownRightCell cellWithTableview:self.rightTableview];
        //左边表格中的行号
        NSInteger leftSelectedRow = [self.leftTableview indexPathForSelectedRow].row;
        YKCategory * category = [YKDataTool categories][leftSelectedRow];
         cell.textLabel.text = category.subcategories[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableview){//左边
        //刷新右边
        [self.rightTableview reloadData];
    }else{//右边
        YKLog(@"点击了右边第%d行",indexPath.row);
    }

    
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
