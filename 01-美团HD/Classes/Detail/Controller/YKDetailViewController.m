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
#import <UIImageView+WebCache.h>
#import "DPAPI.h"
#import "MBProgressHUD+MJ.h"
#import "YKGetSingleDealResult.h"
#import <MJExtension.h>
#import "YKRestrictions.h"

@interface YKDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) UIActivityIndicatorView * loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *soldNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeRefundButton;
@property (weak, nonatomic) IBOutlet UIButton *expiresRefundButton;
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
    
    //处理左边的内容
    [self setupLeftView];
    
   //处理右边的webview
    [self setupRightView];
}
/**
 * 处理右边的内容
 */
- (void)setupLeftView
{
    //图片
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder.deal"]];
    //标题
    self.titleLabel.text = self.deal.title;
    
    //描述
    self.descLabel.text = self.deal.desc;
    
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.deal.list_price];
    
    //现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.deal.current_price];
    
    //购买数
    [self.soldNumberButton setTitle:[NSString stringWithFormat:@"已售出%d",self.deal.purchase_count] forState:UIControlStateNormal];
    YKLog(@"deal = %@",self.deal.title);
    
    //2015-02-08
    
    
    //剩余时间
    //获得过期时间
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
  
    NSLog(@"deadline = %@",self.deal.purchase_deadline);
    NSDate * dead = [fmt dateFromString:self.deal.purchase_deadline];
    
    //增加一天 因为系统返回的时间自动补为：2015-02-08 00：00：00
    [dead dateByAddingTimeInterval:24*60*60];
    
    //比较过期时间和当前时间
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * cmps = [calendar components:unit fromDate:[NSDate date] toDate:dead options:kNilOptions];
    
    //设置剩余时间
    [self.leftTimeButton setTitle:[NSString stringWithFormat:@"剩余%d天%d小时%d分",cmps.day,cmps.hour,cmps.minute] forState:UIControlStateNormal];
    
    //发送请求给服务器获得更详细的团购信息
    NSDictionary * params = @{@"deal_id":self.deal.deal_id};
    [[DPAPI sharedInstance] request:@"v1/deal/get_single_deal" params:params success:^(id json) {
        YKGetSingleDealResult * result = [YKGetSingleDealResult objectWithKeyValues:json];
       self.deal = [result.deals lastObject];
        self.anyTimeRefundButton.selected = self.deal.restrictions.is_refundable;
        self.expiresRefundButton.selected = self.deal.restrictions.is_refundable;
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"找不到指定的团购信息"];
    }];
    
}
/**
 * 处理右边的webview
 */
- (void)setupRightView
{
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
        YKLog(@"开始加载详情 %@",url);
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
