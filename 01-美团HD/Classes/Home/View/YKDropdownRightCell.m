//
//  YKDropdownRightCell.m
//  01-美团HD
//
//  Created by yake on 15-3-5.
//  Copyright (c) 2015年 yake. All rights reserved.
//

#import "YKDropdownRightCell.h"

@implementation YKDropdownRightCell
+ (instancetype)cellWithTableview:(UITableView *)tableView
{
    static NSString * rightid = @"right";
    YKDropdownRightCell * cell = [tableView dequeueReusableCellWithIdentifier:rightid];
    if(cell == nil){
        cell = [[YKDropdownRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightid];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
    }

    return cell;
}

@end
