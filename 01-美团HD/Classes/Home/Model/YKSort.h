//
//  YKSort.h
//  01-美团HD
//
//  Created by yake on 15-3-4.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKSort : NSObject
/** 文字描述 */
@property (nonatomic,copy) NSString * label;
/** 这个排序具体的值（将来发给服务器）*/
@property (nonatomic, assign)int value;
@end
