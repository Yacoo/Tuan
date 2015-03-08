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
#import "YKCityResultViewController.h"
#import <UIView+AutoLayout.h>


@interface YKCityViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
/** 遮盖*/
@property (nonatomic, weak)UIButton * cover;
/** 城市搜索结果*/
@property (nonatomic, weak)YKCityResultViewController * cityResultVC;//搜索很频繁只创建一次
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation YKCityViewController
#pragma mark --懒加载
- (YKCityResultViewController *)cityResultVC
{
    if(!_cityResultVC){
        YKCityResultViewController * cityResutVC = [[YKCityResultViewController alloc] init];
        self.cityResultVC = cityResutVC;
        [self addChildViewController:cityResutVC];
        [self.view addSubview:cityResutVC.view];
        
        [cityResutVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [cityResutVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableview];
        
    }
    return _cityResultVC;
}
- (UIButton *)cover
{
    if(!_cover){
        UIButton * cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor blackColor];
        [cover addTarget:self.searchBar action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = CGRectMake(0, 44, 100, 100);
        cover.alpha = 0.5;
        [self.view addSubview:cover];
        
        //添加约束
        [cover autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [cover autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.tableview];
//        [cover autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.tableview];
//        [cover autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.tableview];
//        [cover autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.tableview];
        self.cover = cover;
    }
    return _cover;
}
#pragma mark --初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换城市";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"btn_navigation_close" highImage:@"btn_navigation_close_hl" target:self action:@selector(close)];
    //设置表格的索引文字颜色
    self.tableview.sectionIndexColor = [UIColor blackColor];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark --<UISearchBarDelegate>
/**
 * 当搜索框已经进入编辑状态（键盘已经弹出）
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 1.让文本框变成绿色。
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    // 2.出现cancel按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    // 3.导航条消失（通过动画向上消失）
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // 4.添加蒙版
    self.cover.hidden = NO;
    
}
/**
 * 当搜索框已经退出编辑状态（键盘已经弹出）
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 1.让文本框变成灰色。
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    // 2.隐藏cancel按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    // 3.导航条出现（通过动画向下出现）
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 4.移除蒙版
    self.cover.hidden = YES;
}
/**
 * 点击取消按钮
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
  //  [searchBar resignFirstResponder];
    [searchBar endEditing:YES];
}
/**
 * 搜索框文字改变
 */
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    if(searchText.length){
//        self.cityResultVC.view.hidden = NO;
//    }else{
//        self.cityResultVC.view.hidden = YES;
//    }
   // self.cityResultVC.view.hidden = !searchText.length;
    //当文字长度为零时隐藏
    self.cityResultVC.view.hidden = searchText.length == 0;
    self.cityResultVC.searchText = searchText;

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
//    NSMutableArray * titles = [NSMutableArray array];
//    [[YKDataTool cityGroups] enumerateObjectsUsingBlock:^(YKCityGroup * cityGroup, NSUInteger idx, BOOL *stop) {
//        [titles addObject:cityGroup.title];
//    }];
//    
//    return titles;
    
//    NSArray * groups = [YKDataTool cityGroups];
//    YKCityGroup * group = [groups lastObject];
//    YKLog(@"%@",[group valueForKeyPath:@"title"]);//相当于group.title
//    YKLog(@"%@",[groups valueForKeyPath:@"title"]);//将groups数组中所有元素的title属性取出来，放到一个新数组中。
//    //用keyPath，不要用key
    return [[YKDataTool cityGroups] valueForKeyPath:@"title"];
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
