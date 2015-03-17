//
//  NSString+Extension.m
//  01-美团HD
//
//  Created by yake on 15-3-17.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(instancetype)dealedPriceString
{
    //处理过的字符串
    NSString * newString = self;
    //小数点位置
    NSUInteger dotLoc = [newString rangeOfString:@"."].location;
    if(dotLoc != NSNotFound){
        //小数位数
        NSUInteger xiaoshuCount = newString.length - dotLoc;
        NSLog(@"%@ %zd",newString,xiaoshuCount);
        
        //小数位数过多
        if(xiaoshuCount > 2){
            // ￥89.9000000001 --》￥89.9
            newString = [newString substringToIndex:dotLoc+3];
            if([newString hasSuffix:@"0"])
            {
                newString = [newString substringToIndex:newString.length-1];
            }
            
        }
    }
    return newString;
}
@end
