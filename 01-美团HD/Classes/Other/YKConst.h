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