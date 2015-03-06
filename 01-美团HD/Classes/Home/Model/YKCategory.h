//
//  YKCategory.h
//  01-美团HD
//
//  Created by yake on 15-3-5.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKCategory : NSObject
/** 类别名称（比如美食，旅游） */
@property (nonatomic, strong)NSString * name;
/** 子类别（比如粤菜，鲁菜，豫菜） */
@property (nonatomic, strong)NSArray * subcategories;

/** 显示在下单菜单的小图标 */
@property (nonatomic, strong)NSString * small_highlighted_icon;
@property (nonatomic, strong)NSString * small_icon;

/** 显示在导航栏顶部的大图标*/
@property (nonatomic, strong)NSString * highlighted_icon;
@property (nonatomic, strong)NSString * icon;
@end
