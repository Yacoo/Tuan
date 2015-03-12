//
//  YKCityResultViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-8.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKCityResultViewController.h"
#import "YKDataTool.h"
#import "YKCity.h"
@interface YKCityResultViewController ()
@property (nonatomic, strong)NSArray * resultCities;
@end

@implementation YKCityResultViewController
- (NSArray *)resultCities
{
    if(!_resultCities){
        _resultCities = [[NSArray alloc] init];
    }
    return _resultCities;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)setSearchText:(NSString *)searchText
{
    if(searchText.length == 0)return;
    _searchText = [searchText copy];
    searchText = searchText.lowercaseString;

    //根据搜索条件 - 搜索城市
    NSArray * cities = [YKDataTool cities];
    
    // 创建过滤调价
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@",searchText,searchText,searchText];
    self.resultCities =  [cities filteredArrayUsingPredicate:predicate];
    
    //谓词
    //过滤器
    //刷新表格
    [self.tableView reloadData];
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * ID = @"city";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    //设置城市名字
    YKCity * city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}
#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%zd个搜索结果",self.resultCities.count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 销毁
    [self dismissViewControllerAnimated:YES completion:nil];

    
    //取出城市模型
    YKCity * city = self.resultCities[indexPath.row];
    
    // 发出通知
    NSDictionary * userInfo = @{YKCurrentCityKey : city};
    [YKNoteCenter postNotificationName:YKCityDidChangeNotification object:nil userInfo:userInfo];
    
}


@end
