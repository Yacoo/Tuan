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
@property (nonatomic, strong)NSMutableArray * resultNames;
@end

@implementation YKCityResultViewController
- (NSMutableArray *)resultNames
{
    if(!_resultNames){
        _resultNames = [[NSMutableArray alloc] init];
    }
    return _resultNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)setSearchText:(NSString *)searchText
{
    if(searchText.length == 0)return;
    _searchText = [searchText copy];
    searchText = searchText.lowercaseString;
    // 清除旧数据
    [self.resultNames removeAllObjects];
    //根据搜索条件 - 搜索城市
    NSArray * cities = [YKDataTool cities];
    for(YKCity * city in cities){
        if([city.name containsString:searchText]){ //名字中包含了搜索结果
            [self.resultNames addObject:city.name];
        }else if ([city.pinYin containsString:searchText]){//name == 北京 -》beijing
            [self.resultNames addObject:city.name];
        }else if ([city.pinYinHead containsString:searchText]){
            [self.resultNames addObject:city.name];
        }
    }
    
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

    return self.resultNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * ID = @"city";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    //设置城市名字
    cell.textLabel.text = self.resultNames[indexPath.row];
    
    return cell;
}
#pragma mark - 代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%zd个搜索结果",self.resultNames.count];
}


@end
