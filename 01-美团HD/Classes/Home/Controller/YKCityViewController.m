//
//  YKCityViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-6.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKCityViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YKDataTool.h"
#import "YKCityGroup.h"

@interface YKCityViewController ()

@end

@implementation YKCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_navigation_close" highImage:@"btn_navigation_close_hl" target:self action:@selector(close)];
    
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [YKDataTool cityGroups].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YKCityGroup * cityGroup = [YKDataTool cityGroups][section];
    return cityGroup.cities.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"city";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    YKCityGroup * cityGroup = [YKDataTool cityGroups][indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return cell;
}
#pragma mark --代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YKCityGroup * cityGroup = [YKDataTool cityGroups][section];
    return cityGroup.title;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * titles = [NSMutableArray array];
    for(YKCityGroup * cityGroup in [YKDataTool cityGroups]){
        
    }
    return @"";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
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
