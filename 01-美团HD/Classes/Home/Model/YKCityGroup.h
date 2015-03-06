//
//  YKCityGroup.h
//  01-美团HD
//
//  Created by yake on 15-3-6.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKCityGroup : NSObject
/** 这组的名字*/
@property (nonatomic, copy)NSString * title;
/** 这组的城市名称*/
@property (nonatomic, strong)NSArray * cities;
@end
