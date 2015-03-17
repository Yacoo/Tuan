//
//  YKDealCell.m
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDealCell.h"
#import "YKDeal.h"
#import "YKCenterLineLabel.h"
#import <UIImageView+WebCache.h>

@interface YKDealCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet YKCenterLineLabel *listPriceLabel;
/** 如果方法名以new，alloc，init开头，那么这些方法必须返回跟方法调用者同意类型的对象*/
@property (weak, nonatomic) IBOutlet UIImageView *dealNewMark;
@end
@implementation YKDealCell

- (void)setDeal:(YKDeal *)deal
{
    _deal = deal;
    
    NSLog(@"setDeal --");
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder.deal"]];
    //标题
    self.titleLabel.text = deal.title;
    
    //描述
    self.descLabel.text = deal.desc;
    
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@",deal.list_price];
    
    //现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",deal.current_price];
    
    //购买数
    self.titleLabel.text = [NSString stringWithFormat:@"已售：%d",deal.purchase_count];
    
    //新单
    
     NSComparisonResult result = [deal.publish_date compare:[NSDate date]];
    NSLog(@"date = %@",[NSDate date]);
    if(result == NSOrderedSame || result == NSOrderedDescending){
        self.dealNewMark.hidden = NO;
    }else
    {
        self.dealNewMark.hidden = YES;
    }
    
}
- (void)awakeFromNib {
   // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_dealcell"]];
    //或者直接设置背景，图片就会充满屏幕
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    //只要cell的尺寸发生了改变背景就重画一遍，防止因cell的尺寸改变引起的背景大小问题
//    [self setNeedsDisplay];
//}
////这个方法只在view第一次显示在屏幕的时候会掉，除非调用一次setNeddsDisplay
//- (void)drawRect:(CGRect)rect
//{
//    //想给一个控件搞北京图片，实现它的drawrect方法。
//    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
//}
@end
