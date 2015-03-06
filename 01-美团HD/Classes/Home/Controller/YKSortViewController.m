//
//  YKSortViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-4.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKSortViewController.h"
#import "YKSort.h"
#import "UIView+MJExtension.h"
#import "YKDataTool.h"
#import "YKConst.h"

@interface YKSortViewController ()

@end

@implementation YKSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray * sorts = [YKDataTool sorts];

    NSUInteger count = sorts.count;
    CGFloat margin = 10;
    UIButton * lastButton;
    for(NSUInteger i = 0; i < count; ++i){
        UIButton * button = [[UIButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        lastButton = button;
        
        [self.view addSubview:button];
        //取出模型
        YKSort * sort = sorts[i];
        //设置按钮文字
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        button.mj_width = 80;
        button.mj_height = 30;
        button.mj_x = 15;
        
        button.mj_y = margin + i * (button.mj_height + margin);
        
    }
    //设置控制器view在popover中的尺寸
    CGFloat w = CGRectGetMaxX(lastButton.frame) +lastButton.mj_x;
    CGFloat h = CGRectGetMaxY(lastButton.frame) +margin;
    self.preferredContentSize = CGSizeMake(w, h);
}

- (void)buttonClick:(UIButton*)button
{
    //1.让popover消失
    [self dismissViewControllerAnimated:YES completion:nil];
    
   // 2.更新导航栏
    NSDictionary * userInfo = @{YKCurrentSortKey:[YKDataTool sorts][button.tag]};
    YKSort * sort = [YKDataTool sorts][button.tag];
    YKLog(@"sort = %@",sort.label);
    [YKNoteCenter postNotificationName:YKSortDidChangeNotification object:userInfo];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
