//
//  YKDropdownLeftCell.m
//  01-美团HD
//
//  Created by yake on 15-3-5.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDropdownLeftCell.h"

@implementation YKDropdownLeftCell

+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString * leftid = @"left";
    YKDropdownLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:leftid];
    if(cell == nil){
        cell = [[YKDropdownLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftid];
        //backgroundview比backgroundvolor优先级高
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
    }
    return cell;
}

@end
