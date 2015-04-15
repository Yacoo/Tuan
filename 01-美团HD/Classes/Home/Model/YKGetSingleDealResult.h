//
//  YKGetSingleDealResult.h
//  01-美团HD
//
//  Created by yake on 15/4/15.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKGetSingleDealResult : NSObject
/** 所有团购总数*/
@property (nonatomic, assign) int total_count;
/** 本次团购数据（里面都是YKDeal模型）*/
@property (nonatomic, strong) NSArray * deals;
@end
