//
//  YKDeal.h
//  01-美团HD
//
//  Created by yake on 15-3-9.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKDeal : UILabel
/** 团购单ID*/
@property (copy, nonatomic) NSString * deal_id;
/** 团购标题*/
@property (copy, nonatomic) NSString * title;
/** 团购描述*/
@property (copy, nonatomic) NSString * desc;
/** 如果想完整地保留服务器返回数字的小数位数（没有小数/1位小数/2位小数等），那么就应该用NSNumber*/
/** 团购包含商品原价值*/
@property (copy, nonatomic) NSString * list_price;
/** 团购价格*/
@property (copy, nonatomic) NSString * current_price;
/** 团购当前已购买数*/
@property (assign, nonatomic) int purchase_count;
/** 团购图片链接，最大图片尺寸450*280*/
@property (copy, nonatomic) NSString * image_url;
/** 小尺寸团购图片链接，最大图片尺寸160*100*/
@property (copy, nonatomic) NSString * s_image_url;
/** 团购发布上线日期*/
@property (copy, nonatomic) NSString * publish_date;
/** 团购单的截止购买日期*/
@property (copy, nonatomic) NSString * purchase_dealline;
@end
