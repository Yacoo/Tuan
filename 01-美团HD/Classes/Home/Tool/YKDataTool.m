//
//  YKDataTool.m
//  01-美团HD
//
//  Created by yake on 15-3-5.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDataTool.h"
#import "YKSort.h"
#import "YKCategory.h"
#import "YKCityGroup.h"
#import <MJExtension.h>
@implementation YKDataTool

//+ (void)initialize
//{
//    //第一次调用一个类时调用
//    
//    _sorts = [YKSort objectArrayWithFilename:@"sorts.plist"];
//}
static NSArray * _sorts;
+(NSArray *)sorts
{
    if(!_sorts){
        //第一次调用这个方法创建_sorts，第二次调用直接返回_sorts
        _sorts = [YKSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

static NSArray * _categories;
+(NSArray *)categories
{
    if(!_categories){
        //第一次调用这个方法创建_sorts，第二次调用直接返回_sorts
        _categories = [YKCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}
/**
 * 返回所有的城市组数据（里面都是YKCityGroup模型）
 */
static NSArray * _cityGroups;
+(NSArray *)cityGroups
{
    if(!_cityGroups){
        //第一次调用这个方法创建_sorts，第二次调用直接返回_sorts
        _cityGroups = [YKCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}
@end
