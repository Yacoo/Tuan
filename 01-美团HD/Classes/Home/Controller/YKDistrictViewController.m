//
//  YKDistrictViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-4.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDistrictViewController.h"
#import "YKCityViewController.h"
#import "YKNavigationController.h"
#import "YKDistrict.h"
#import "YKDropdownLeftCell.h"
#import "YKDropdownRightCell.h"

@interface YKDistrictViewController ()
@property (weak, nonatomic) IBOutlet UITableView *leftTableview;
@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@end

@implementation YKDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(400, 400);
    CGFloat rowHeight = 40;
    self.leftTableview.rowHeight = rowHeight;
    self.rightTableview.rowHeight = rowHeight;
}
#pragma mark --私有方法
/**
 * 切换城市
 */
- (IBAction)changeCity:(id)sender {
   
    //2.销毁当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //1.弹出切换城市的控制器
    
    YKCityViewController * cityVC = [[YKCityViewController alloc] init];
    
    //self.presentedViewController引用这nav，所有即使nav是局部变量，但是它也不会死。但是如果self死了，nav也死了
    
    YKNavigationController * nav = [[YKNavigationController alloc] initWithRootViewController:cityVC];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC presentViewController:nav animated:YES completion:nil];
#warning 这里不能使用self来弹出控制器，因为当self销毁了，被self弹出的控制器也会被销毁
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.leftTableview){//左边
        return self.districts.count;
    }else{//右边
        NSInteger leftSelectedRow = [self.leftTableview indexPathForSelectedRow].row;
        YKDistrict * district = self.districts[leftSelectedRow];
        return district.subdistricts.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    if(tableView == self.leftTableview){//左边
        cell = [YKDropdownLeftCell cellWithTableview:self.leftTableview];
        YKDistrict * district = self.districts[indexPath.row];
        cell.textLabel.text = district.name;
        cell.accessoryType = district.subdistricts.count ?  UITableViewCellAccessoryDisclosureIndicator :
        UITableViewCellAccessoryNone;
        
    }else{//右边
        cell = [YKDropdownRightCell cellWithTableview:self.rightTableview];
        //左边表格中的行号
        NSInteger leftSelectedRow = [self.leftTableview indexPathForSelectedRow].row;
        YKDistrict * district = self.districts[leftSelectedRow];
        cell.textLabel.text = district.subdistricts[indexPath.row];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.leftTableview){//左边
        //刷新右边
        [self.rightTableview reloadData];
        
        //如果这个区域没有子区域，得发通知
        YKDistrict * district = self.districts[indexPath.row];
        if(district.subdistricts.count == 0){ //得发送通知
            [self postNote:district subdistrictIndex:nil];
            
        }
    }else{//右边
        //1.销毁当前控制器
        [self dismissViewControllerAnimated:YES completion:nil];
        
        //2.发送通知
        NSUInteger leftSelectedRow = [self.leftTableview indexPathForSelectedRow].row;
        YKDistrict * district = self.districts[leftSelectedRow];
        
        [self postNote:district subdistrictIndex:@(indexPath.row)];
    }
}
#pragma mark - 私有方法
- (void)postNote:(YKDistrict *)district subdistrictIndex:(id)subdistrictIndex
{
    //1.销毁当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //2.发送通知
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
    userInfo[YKCurrentDistrictKey] = district;
    if(subdistrictIndex){
        userInfo[YKCurrentSubdistrictKeyIndex] = subdistrictIndex;
    }
    [YKNoteCenter postNotificationName:YKDistrictDidChangeNotification object:nil userInfo:userInfo];
}
@end
