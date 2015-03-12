#import <UIKit/UIKit.h>

//通知
/** 排序改变的通知*/
UIKIT_EXTERN NSString * const YKSortDidChangeNotification;

/** 通过这个key可以取出当前的排序模型*/
UIKIT_EXTERN NSString * const YKCurrentSortKey;

/** 类别改变的通知*/
UIKIT_EXTERN NSString * const YKCategoryDidChangeNotification;

/** 通过这个key可以取出当前的类别模型*/
UIKIT_EXTERN NSString * const YKCurrentCategoryKey;

/** 通过这个key可以取出当前的子类别的索引*/
UIKIT_EXTERN NSString * const YKCurrentSubcategoryKeyIndex;

/** 城市改变的通知*/
UIKIT_EXTERN NSString * const YKCityDidChangeNotification;

/** 改变这个key可以取出当前的城市模型*/
UIKIT_EXTERN NSString * const YKCurrentCityKey;

/** 类别区域的通知*/
UIKIT_EXTERN NSString * const YKDistrictDidChangeNotification;

/** 通过这个key可以取出当前的区域模型*/
UIKIT_EXTERN NSString * const YKCurrentDistrictKey;

/** 通过这个key可以取出当前的子类别的索引*/
UIKIT_EXTERN NSString * const YKCurrentSubdistrictKeyIndex;