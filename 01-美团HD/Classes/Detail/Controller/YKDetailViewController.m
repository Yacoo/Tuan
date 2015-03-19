//
//  YKDetailViewController.m
//  01-美团HD
//
//  Created by yake on 15-3-19.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDetailViewController.h"
#import "YKDeal.h"
#import <UIView+AutoLayout.h>

@interface YKDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView * loadingView;
@end

@implementation YKDetailViewController

- (UIActivityIndicatorView *)loadingView
{
    if(!_loadingView){
        UIActivityIndicatorView * loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.webView addSubview:loadingView];
        
        //居中
        [loadingView autoCenterInSuperview];
        self.loadingView = loadingView;
    }
    return _loadingView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //此时scrollview的偏移量是-20
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    //开始转圈圈
    [self.loadingView startAnimating];
    //隐藏
    self.webView.scrollView.hidden = YES;
    
    //加载右边的页面
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
}
/**
 * 设置当前控制器支持哪些方向
 * 
 * @return  这里返回的枚举常量是带有mask单词的，（没有Mask单词的常量是用来判断控制器方向的 -- UIInterfaceOrientation）
 */
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UIWebViewDelegate>
/**
 * webview加载完毕时调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]){//加载详情
        //截取id
        NSString * ID = [self.deal.deal_id substringFromIndex:2];
        NSString * url = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@",ID];
        //加载右边的页面
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        YKLog(@"开始加载详情");
    }else{//加载详情完毕
        //执行js删掉不需要的节点
        NSString * js = @"document.getElementsByTagName('header')[0].remove();"
                        @"document.getElementsByClassName('cost-box')[0].remove();"
                        @"document.getElementsByClassName('buy-now')[0].remove();";
        [webView stringByEvaluatingJavaScriptFromString:js];
        
        //停止动画
        [self.loadingView stopAnimating];
        //显示webview
        self.webView.scrollView.hidden = NO;
    }
   
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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
