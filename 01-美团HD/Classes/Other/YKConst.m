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