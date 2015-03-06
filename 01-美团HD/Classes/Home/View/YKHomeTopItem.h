//
//  YKHomeTopItem.h
//  01-美团HD
//
//  Created by yake on 15-3-2.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKHomeTopItem : UIView
+ (instancetype)item;

- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString *)subTitle;
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;
- (void)addTarget:(id)target action:(SEL)action;
@end
