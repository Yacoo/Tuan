//
//  YKDataTool.h
//  01-美团HD
//
//  Created by yake on 15-3-5.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKCity.h"

@interface YKDataTool : NSObject
/**
 * 返回所有的排序数据（里面都是YKSort模型）
 */
+(NSArray *)sorts;
/**
 * 返回所有的排序数据（里面都是YKCategory模型）
 */
+(NSArray *)categories;
/**
 * 返回所有的城市组数据（里面都是YKCityGroup模型）
 */
+(NSArray *)cityGroups;
/**
 * 返回所有的城市组名字（里面都是YKCityGroup模型）
 */
+(NSArray *)cityNames;
/**
 * 返回所有的城市（里面都是YKCityGroup模型）
 */
+(NSArray *)cities;
/**
 * 根据城市名字获得城市模型
 * @param name 城市名字
 * return 城市模型
 */
+(YKCity *)cityWithName:(NSString *)name;
@end
