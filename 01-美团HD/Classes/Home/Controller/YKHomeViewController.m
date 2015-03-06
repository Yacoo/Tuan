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

@interface YKHomeViewController ()
/** 类别item */
@property (nonatomic, strong)UIBarButtonItem * categoryItem;
/** 区域item */
@property (nonatomic, strong)UIBarButtonItem * districtItem;
/** 分类item */
@property (nonatomic, strong)UIBarButtonItem * sortItem;
@end

@implementation YKHomeViewController

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //使用storyboard创建已经有布局了，collection view flow layout,没有布局会直接崩溃的
    // self.view是self.collectionview的父视图
    self.collectionView.backgroundColor = YKColor(230, 230, 230);
    
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
    YKSort * sort = note.userInfo[YKCurrentSortKey];
    topItem.subTitle = sort.label;
#warning TODO 重新发送请求给服务器

}

- (void)categoryDidChange:(NSNotification *)note
{
    //更新导航栏顶部的排序 - 子标题
    YKHomeTopItem * topItem = (YKHomeTopItem *)self.categoryItem.customView;
    //取出模型
    YKCategory * category = note.userInfo[YKCurrentCategoryKey];
    int subcategoryIndex = [note.userInfo[YKCurrentSubcategoryKeyIndex] intValue];
    NSString * subcategory = category.subcategories[subcategoryIndex];
    topItem.title = category.name;
    topItem.subTitle = subcategory;
    [topItem setIcon:category.icon highIcon:category.highlighted_icon];

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
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
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
