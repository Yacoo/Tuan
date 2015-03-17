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
- (void)setPublish_date:(NSDate *)publish_date
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    //设置日期格式 HH:mm:ss  (大写H24小时制)
    fmt.dateFormat = @"yyyy-MM-dd";
    
    _publish_date = [fmt dateFromString:(NSString *)publish_date];
}
- (void)setPurchase_dealline:(NSDate *)purchase_dealline
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
   
    fmt.dateFormat = @"yyyy-MM-dd";
    
    _purchase_dealline = [fmt dateFromString:(NSString *)purchase_dealline];
}
//- (NSString *)list_price
//{
//    return _list_price.dealedPriceString;
//}
//- (NSString *)current_price
//{
//    return _current_price.dealedPriceString;
//}

@end
