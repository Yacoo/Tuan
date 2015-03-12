//
//  YKCity.m
//  01-美团HD
//
//  Created by yake on 15-3-8.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKCity.h"
#import "YKDistrict.h"

@implementation YKCity
+ (NSDictionary *)objectClassInArray
{
    return @{@"districts" : [YKDistrict class]};
}

@end