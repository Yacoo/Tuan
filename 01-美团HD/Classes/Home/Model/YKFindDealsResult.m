//
//  YKFindDealsResult.m
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKFindDealsResult.h"
#import "YKDeal.h"

@implementation YKFindDealsResult
+ (NSDictionary *)objectClassInArray
{
    return @{@"deals" : [YKDeal class]};
}
@end
