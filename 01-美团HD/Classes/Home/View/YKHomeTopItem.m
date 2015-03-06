//
//  YKHomeTopItem.m
//  01-美团HD
//
//  Created by yake on 15-3-2.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKHomeTopItem.h"

@interface YKHomeTopItem()
/**标题*/

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**子标题*/
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

/**图标按钮*/
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@end

@implementation YKHomeTopItem

+ (instancetype)item
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YKHomeTopItem" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //要不要将autoresizingmask里面的设置转为约束
    // self.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}
- (void)setSubTitle:(NSString *)subTitle
{
    self.subTitleLabel.text = subTitle;
}
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon
{
    [self.iconButton setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
}
- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
@end

