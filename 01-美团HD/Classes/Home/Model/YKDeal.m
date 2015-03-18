//
//  YKDeal.m
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDeal.h"
#import <MJExtension.h>
#import "NSString+Extension.h"

@implementation YKDeal

+(NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"desc" : @"description"};
}
- (void)setList_price:(NSString *)list_price
{
    _list_price = list_price.dealedPriceString;
}
- (void)setCurrent_price:(NSString *)current_price
{
    _current_price = current_price.dealedPriceString;
}

@end
