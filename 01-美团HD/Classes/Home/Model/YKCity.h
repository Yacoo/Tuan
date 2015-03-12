//
//  YKCity.h
//  01-美团HD
//
//  Created by yake on 15-3-8.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKCity : NSObject
/** 城市名称*/
@property (nonatomic, copy)NSString * name;
/** 城市名称拼音*/
@property (nonatomic, strong)NSString * pinYin;
/** 城市名称的拼音声母*/
@property (nonatomic, strong)NSString * pinYinHead;
/** 这个区域的所有区域（区域模型）*/
@property (nonatomic, strong) NSArray *districts;
@end
