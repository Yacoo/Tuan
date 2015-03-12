//
//  YKDealCell.m
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDealCell.h"
@interface YKDealCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@end
@implementation YKDealCell

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
