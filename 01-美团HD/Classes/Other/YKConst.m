#import <UIKit/UIKit.h>

//通知
/** 排序改变的通知*/
NSString * const YKSortDidChangeNotification = @"YKSortDidChnageNotification";

/** 通过这个key可以去取当前的排序模型*/
NSString * const YKCurrentSortKey = @"YKCurrentSortKey";

/** 类别改变的通知*/
NSString * const YKCategoryDidChangeNotification = @"YKCategoryDidChangeNotification";

/** 通过这个key可以取出当前的类别模型*/
NSString * const YKCurrentCategoryKey = @"YKCurrentCategoryKey";

/** 通过这个key可以取出当前的子类别的索引*/
NSString * const YKCurrentSubcategoryKeyIndex = @"YKCurrentSubcategoryKeyIndex";

/** 城市改变的通知*/
NSString * const YKCityDidChangeNotification = @"YKCityDidChangeNotification";

/** 改变这个key可以取出当前的城市模型*/
NSString * const YKCurrentCityKey = @"YKCurrentCityKey";

/** 类别区域的通知*/
NSString * const YKDistrictDidChangeNotification = @"YKDistrictDidChangeNotification";

/** 通过这个key可以取出当前的区域模型*/
NSString * const YKCurrentDistrictKey = @"YKCurrentDistrictKey";

/** 通过这个key可以取出当前的子类别的索引*/
NSString * const YKCurrentSubdistrictKeyIndex = @"YKCurrentSubdistrictKeyIndex";