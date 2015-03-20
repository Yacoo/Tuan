//
//  _1___HDTests.m
//  01-美团HDTests
//
//  Created by yake on 15-2-25.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface _1___HDTests : XCTestCase

@end

@implementation _1___HDTests

//初始化
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}
//销毁
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//单元测试：测试某个但愿（某个业务功能，不能测UI）
//红灯：测试不通过
//绿灯：测试通过
- (void)testCanlendar
{
    //日历对象（能完成很多的日期处理）
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    //创建日期
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * date1 = [fmt dateFromString:@"2013-08-06 22:35:20"];
    NSDate * date2 = [fmt dateFromString:@"2015-04-09 23:40:40"];
    
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * cmps = [calendar components:unit  fromDate:date1 toDate:date2 options:kNilOptions];
    NSLog(@"---------华丽的分割线-----------");
    NSLog(@"相差%d年 %d月 %d日 %d时 %d分 %d秒",cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second);
    NSLog(@"---------忧伤的分割线-----------");
    
    NSAssert(cmps.year == 1, @"NSCalendar计算有问题");
//    //获得date的某个元素（年月日时分秒）
//    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
//    NSLog(@"%d",year);
//    
//   NSDateComponents * cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
//    NSLog(@"%d %d %d",cmps.year,cmps.month,cmps.day);
}
- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
