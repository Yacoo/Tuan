//
//  YKGetSingleDealResult.m
//  01-美团HD
//
//  Created by yake on 15/4/15.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKGetSingleDealResult.h"
#import "YKDeal.h"

@implementation YKGetSingleDealResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"deals" : [YKDeal class]};
}
@end
