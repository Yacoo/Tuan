//
//  YKHomeViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-2.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "YKHomeTopItem.h"
#import "YKSortViewController.h"
#import "YKDistrictViewController.h"
#import "YKCategoryViewController.h"
#import "YKSort.h"
#import "YKCategory.h"
#import "YKCity.h"
#import "YKDistrict.h"
#import "DPAPI.h"
#import "YKFindDealsResult.h"
#import "YKDealCell.h"
#import <MJExtension.h>

@interface YKHomeViewController ()
/** 类别item */
@property (nonatomic, strong)UIBarButtonItem * categoryItem;
/** 区域item */
@property (nonatomic, strong)UIBarButtonItem * districtItem;
/** 分类item */
@property (nonatomic, strong)UIBarButtonItem * sortItem;
/** 显示的所有团购 */
@property (nonatomic, strong) NSMutableArray * deals;

/** 记录一些当前数据 */
/** 当前的城市 */
@property (nonatomic, strong) YKCity * currentCity;
/** 当前的排序 */
@property (nonatomic, strong) YKSort * currentSort;
/** 当前的类别（发给服务器） */
@property (nonatomic, strong) NSString * currentCategoryName;
/** 当前的区域名字（发给服务器） */
@property (nonatomic, strong) NSString * currentRegionName;
@end

@implementation YKHomeViewController
- (NSMutableArray *)deals
{
    if(!_deals){
        _deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}
#pragma mark - 监听屏幕的旋转
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    //子类有一堆方法设置布局，父类是个抽象类，里面什么都没有
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat screenW = size.width;
    //根据屏幕尺寸决定每行的列数
    int cols = (screenW == YKScreenMaxWH) ? 3 : 2;
    NSLog(@"cols = %d",cols);
    //一行中所有cell的总宽度
    CGFloat allCellW = cols* layout.itemSize.width;
    //cell之间间距
    CGFloat xMargin = (screenW - allCellW)/(cols +1);
    CGFloat yMargin = (cols == 3) ? xMargin : 30;
    //每一行每个cell的间距
   //  CGFloat margin = (size.width - allCellW)/(cols +1);
    layout.sectionInset = UIEdgeInsetsMake(yMargin, xMargin, yMargin, xMargin);
    //每一行中每个cell之间的间距
    layout.minimumInteritemSpacing = xMargin;
    //每一行之间的间距
    layout.minimumLineSpacing = yMargin;
}
static NSString * const reuseIdentifier = @"deal";
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"YKDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    //使用storyboard创建已经有布局了，collection view flow layout,没有布局会直接崩溃的
    // self.view是self.collectionview的父视图
    self.collectionView.backgroundColor = YKColor(230, 230, 230);
    
    //根据当前屏幕尺寸，计算布局参数（比如间距）
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [self viewWillTransitionToSize:screenSize withTransitionCoordinator:nil];
   
    // 设置导航栏左边
    [self setupNavLeft];
    
    //设置导航栏右边
    [self setupNavRight];
    
    // 监听通知
    [self setupNotes];
    
}
/**
 * 监听通知
 */
- (void)setupNotes
{
    [YKNoteCenter addObserver:self selector:@selector(sortDidChange:) name:YKSortDidChangeNotification object:nil];
    
    [YKNoteCenter addObserver:self selector:@selector(categoryDidChange:) name:YKCategoryDidChangeNotification object:nil];
    
    [YKNoteCenter addObserver:self selector:@selector(cityDidChange:) name:YKCityDidChangeNotification object:nil];
    
    [YKNoteCenter addObserver:self selector:@selector(districtDidChange:) name:YKDistrictDidChangeNotification object:nil];
}
- (void)dealloc
{
    [YKNoteCenter removeObserver:self];
}
/**
 * 设置导航栏左边
 */
- (void)setupNavLeft
{
    //    UIImage * image = [UIImage imageNamed:@"icon_meituan_logo"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //只如下写法美团logo是蓝色，图片被渲染了，为避免这种情况有两种方法，第一，添加如上代码， 第二，在图片设置中选择 render as origin.
    UIBarButtonItem * logoItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //类别
    YKHomeTopItem * categoryTopItem = [YKHomeTopItem item];
    
    [categoryTopItem setIcon:@"icon_category_-1" highIcon:@"icon_category_highlighted_-1"];
    categoryTopItem.title = @"全部分类";
    categoryTopItem.subTitle = nil;
    [categoryTopItem addTarget:self action:@selector(categoryClick)];
    self.categoryItem = [[UIBarButtonItem alloc] initWithCustomView:categoryTopItem];
    
    //区域
    YKHomeTopItem * districtTopItem = [YKHomeTopItem item];
    [districtTopItem setIcon:@"icon_district" highIcon:@"icon_district_highlighted"];
    districtTopItem.title = @"广州";
    districtTopItem.subTitle = @"天河区";
    [districtTopItem addTarget:self action:@selector(districtClick)];
    self.districtItem = [[UIBarButtonItem alloc] initWithCustomView:districtTopItem];
    
    //排序
    YKHomeTopItem * sortTopItem = [YKHomeTopItem item];
    [sortTopItem setIcon:@"icon_sort" highIcon:@"icon_sort_highlighted"];
    sortTopItem.title = @"排序";
    sortTopItem.subTitle = nil;
    [sortTopItem addTarget:self action:@selector(sortClick)];
    self.sortItem = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    
    self.navigationItem.leftBarButtonItems = @[logoItem,self.categoryItem,self.districtItem,self.sortItem];
}

/**
 *设置导航栏右边
 */
- (void)setupNavRight
{
    // UIImageView也有高亮图片
    //search
    
    UIBarButtonItem * searchItem = [UIBarButtonItem itemWithImage:@"icon_search" highImage:@"icon_search_highlighted" target:self action:@selector(searchClick)];
    searchItem.customView.mj_width = 50;
    
    //map
    
    UIBarButtonItem * mapItem = [UIBarButtonItem itemWithImage:@"icon_map" highImage:@"icon_map_highlighted" target:self action:@selector(mapClick)];
    mapItem.customView.mj_width = 50;
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
}
#pragma mark - 通知处理
- (void)sortDidChange:(NSNotification *)note
{
    //更新导航栏顶部的排序 - 子标题
    YKHomeTopItem * topItem = (YKHomeTopItem *)self.sortItem.customView;
    self.currentSort = note.userInfo[YKCurrentSortKey];
    topItem.subTitle = self.currentSort.label;
    
    // 重新发送请求给服务
    [self loadNewDeals];

}

- (void)categoryDidChange:(NSNotification *)note
{
    //更新导航栏顶部的排序 - 子标题
    YKHomeTopItem * topItem = (YKHomeTopItem *)self.categoryItem.customView;
    
    //取出模型
    YKCategory * category = note.userInfo[YKCurrentCategoryKey];
    int subcategoryIndex = [note.userInfo[YKCurrentSubcategoryKeyIndex] intValue];
    NSString * subcategory = category.subcategories[subcategoryIndex];
    
    //设置数据
    topItem.title = category.name;
    topItem.subTitle = subcategory;
    [topItem setIcon:category.icon highIcon:category.highlighted_icon];
    
    // 记录发送给服务器的类别名字
    self.currentCategoryName = subcategory ? subcategory : category.name;
    if([self.currentCategoryName isEqualToString:@"全部"]){ // 点击了子类别中的全部
        self.currentCategoryName = category.name;
    }else if ([self.currentCategoryName isEqualToString:@"全部分类"]){
        self.currentCategoryName = nil;
    }
    
    // 重新发送请求给服务
    [self loadNewDeals];

}
- (void)cityDidChange:(NSNotification *)note
{
    // 更新导航栏顶部
    YKHomeTopItem * topItem = (YKHomeTopItem *)self.districtItem.customView;
    
    //取出模型
    self.currentCity = note.userInfo[YKCurrentCityKey];
    topItem.title = [NSString stringWithFormat:@"%@ - 全部",self.currentCity.name];
    topItem.subTitle = nil;
    
    // 重新发送请求给服务
    [self loadNewDeals];
}
- (void)districtDidChange:(NSNotification *)note
{
    // 更新导航栏顶部
    YKHomeTopItem * topItem = (YKHomeTopItem *)self.districtItem.customView;
    //取出模型
    YKDistrict * district = note.userInfo[YKCurrentDistrictKey];
    int subdistrictIndex = [note.userInfo[YKCurrentSubdistrictKeyIndex] intValue];
    NSString * subdistrict = district.subdistricts[subdistrictIndex];
    //设置数据
    topItem.title = [NSString stringWithFormat:@"%@ - %@",self.currentCity.name,district.name];;
    topItem.subTitle = subdistrict;
    
    //记录发给服务器的区域名称
    self.currentRegionName = subdistrict ? subdistrict : district.name;
    if([self.currentRegionName isEqualToString:@"全部"]){
        self.currentRegionName = subdistrict ? district.name : nil;
    }
    
    // 重新发送请求给服务
    [self loadNewDeals];
}
#pragma mark - 导航栏事件处理
/**
 * 点击了类别
 */
- (void)categoryClick
{
    YKCategoryViewController * categoryVC = [[YKCategoryViewController alloc] init];
    categoryVC.modalPresentationStyle = UIModalPresentationPopover;
    categoryVC.popoverPresentationController.barButtonItem = self.categoryItem;
    [self presentViewController:categoryVC animated:YES completion:nil];
}
/**
 * 点击了区域
 */
- (void)districtClick
{
    YKDistrictViewController * districtVC = [[YKDistrictViewController alloc] init];
    districtVC.modalPresentationStyle = UIModalPresentationPopover;
    districtVC.popoverPresentationController.barButtonItem = self.districtItem;
    districtVC.districts = self.currentCity.districts;
    [self presentViewController:districtVC animated:YES completion:nil];
}
/**
 * 点击了分类
 */
- (void)sortClick
{
    YKSortViewController * sortVC = [[YKSortViewController alloc] init];
    sortVC.modalPresentationStyle = UIModalPresentationPopover;
    sortVC.popoverPresentationController.barButtonItem = self.sortItem;
    [self presentViewController:sortVC animated:YES completion:nil];
}
/**
 * 点击搜索
 */
- (void)searchClick
{
    YKLog(@"searchClick");
}
/**
 * 点击地图
 */
- (void)mapClick
{
    YKLog(@"mapClick");
}

#pragma mark - 私有方法
- (void)loadNewDeals
{
    if(self.currentCity == nil) return;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"limit"] = @10;
    //城市
    params[@"city"] = self.currentCity.name;
    //区域
    if(self.currentRegionName)params[@"region"] = self.currentRegionName;
    
    //类别
    if(self.currentCategoryName)params[@"category"] = self.currentCategoryName;
    
    //排序
    if(self.currentSort) params[@"sort"] = @(self.currentSort.value);
    
    //发送请求给服务器
    NSLog(@"%@",params);
    [[DPAPI sharedInstance] request:@"v1/deal/find_deals" params:params success:^(id json) {
        
     //   YKLog(@"success  - %@",json);
        
       YKFindDealsResult * result = [YKFindDealsResult objectWithKeyValues:json];
        
      //  YKLog(@"%d %@",result.total_count,result.deals);
        //移除旧数据
        [self.deals removeAllObjects];
        
        //添加新数据
        [self.deals addObjectsFromArray:result.deals];
        
        //刷新表格
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        YKLog(@"failure  - %@",error);
    }];
}
#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YKDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
