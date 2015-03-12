//
//  YKDistrict.h
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDistrict : NSObject
/** 区域名称*/
@property (nonatomic, copy) NSString * name;
/** 这个区域的所有子区域*/
@property (nonatomic, strong) NSArray *subdistricts;
@end
