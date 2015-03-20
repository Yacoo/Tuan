//
//  YKCenterLineLabel.m
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKCenterLineLabel.h"

@implementation YKCenterLineLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIColor redColor] set];
    
    YKLog(@"---%@",NSStringFromCGRect(rect));
    YKLog(@"---%@",NSStringFromCGRect(self.bounds));
    //1.画线
    CGFloat x = 0 + rect.origin.x;
    CGFloat y = rect.size.height * 0.5 +rect.origin.y;
    CGFloat w = rect.size.width;
    CGFloat h = 1;
    
    UIRectFill(CGRectMake(x,y,w,h));
    
    //    CGContextAddRect(ctx, CGRectMake(x, y, w, h));
    //    CGContextFillPath(ctx);
}
- (void)drawLine:(CGRect)rect
{
    //同一个绘图环境下获得上下文是一样的
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.起点
    CGFloat startX = 0;
    CGFloat startY = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, startX, startY);
    
    //2.终点
    CGFloat endX = rect.size.width;
    CGFloat endY = startY;
    CGContextAddLineToPoint(ctx, endX, endY);
    
    //3.绘图渲染
    CGContextStrokePath(ctx);
}
@end
