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
@end
@implementation YKDealCell

- (void)setDeal:(YKDeal *)deal
{
    _deal = deal;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder.deal"]];
    //标题
    self.titleLabel.text = deal.title;
    
    //描述
    self.descLabel.text = deal.desc;
    
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",deal.list_price];
    self.listPriceLabel.backgroundColor = [UIColor greenColor];
    
    //现价
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",deal.current_price];
    
    //购买数
    self.titleLabel.text = [NSString stringWithFormat:@"已售：%d",deal.purchase_count];
}
- (void)awakeFromNib {
   // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_dealcell"]];
   // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
}

- (void)drawRect:(CGRect)rect
{
    //想给一个控件搞北京图片，实现它的drawrect方法。
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
@end
