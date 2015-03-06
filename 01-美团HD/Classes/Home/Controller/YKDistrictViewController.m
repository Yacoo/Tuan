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

@interface YKDistrictViewController ()
@property (weak, nonatomic) IBOutlet UITableView *leftTableview;
@property (weak, nonatomic) IBOutlet UITableView *rightTableview;

@end

@implementation YKDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = CGSizeMake(400, 600);
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
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
