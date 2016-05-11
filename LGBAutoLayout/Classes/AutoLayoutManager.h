//
//  AutoLayoutManager.h
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/15.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class AutoLayoutManager;

typedef AutoLayoutManager* (^MarginToView)(UIView *view, CGFloat value);
typedef AutoLayoutManager* (^CenterToView)(UIView *view);
typedef AutoLayoutManager* (^WidthHeight)(CGFloat value);
typedef AutoLayoutManager* (^SameWidthHeight)(CGFloat value);
typedef AutoLayoutManager* (^ContentHeight)(UIView *view, CGFloat value);
typedef AutoLayoutManager* (^MarginToViewArray)(NSArray *views, CGFloat value);
typedef AutoLayoutManager* (^WidthToView)(UIView *view, CGFloat space, CGFloat ratio);

@interface AutoLayoutItem : NSObject
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) UIView *refView;
@end

@interface AutoLayoutArrayItem : AutoLayoutItem
@property (nonatomic, strong) NSArray *refViews;
@end

@interface AutoLayoutSpaceItem : AutoLayoutItem
@property (nonatomic, assign) CGFloat space;
@end

@interface AutoLayoutManager : NSObject

/**
 *  此view为需要布局的view
 */
@property (nonatomic, weak) UIView *view;


/**
 *  设置view的左边等于参考view的左边 ＋ 偏移Space
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, copy, readonly) MarginToView leftSpaceToView;
/**
 *  存储leftSpaceToView的参数数据
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *left;


/**
 *  设置view的顶部等于参考view的顶部 ＋ 偏移Space
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, copy, readonly) MarginToView topSpaceToView;
/**
 *  存储topSpaceToView的参数数据
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *top;


/**
 *  设置view的右边等于参考view的右边 ＋ 偏移Space
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, copy, readonly) MarginToView rightSpaceToView;
/**
 *  存储rightSpaceToView的参数数据
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *right;


/**
 *  设置view的底部等于参考view的底部 ＋ 偏移Space
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, copy, readonly) MarginToView bottomSpaceToView;
/**
 *  存储bottomSpaceToView的参数数据
 *  (UIView *refView, CGFloat space)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *bottom;


/**
 *  设置view的宽度等于参考view的宽度 x 比例ratio
 *  (UIView *refView, CGFloat ratio)
 */
@property (nonatomic, copy, readonly) MarginToView widthEqualToViewWithRatio;

/**
 *  存储widthEqualToViewWithRatio的参数数据
 *  (UIView *refView, CGFloat ratio)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *width;


/**
 *  设置view的高度等于参考view的高度 x 比例ratio
 *  (UIView *refView, CGFloat ratio)
 */
@property (nonatomic, copy, readonly) MarginToView heightEqualToViewWithRatio;
/**
 *  存储heightEqualToViewWithRatio的参数数据
 *  (UIView *refView, CGFloat ratio)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *height;


/**
 *  设置view的顶部位置等于参考view的顶部位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView topEqualToViewWithOffset;
/**
 *  存储topEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *topOffset;


/**
 *  设置view的左边位置等于参考view左边位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView leftEqualToViewWithOffset;
/**
 *  存储leftEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *leftOffset;


/**
 *  设置view的底部位置等于参考view的底部位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView bottomEqualToViewWithOffset;
/**
 *  存储bottomEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *bottomOffset;


/**
 *  设置view的右边位置等于参考view的右边位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView rightEqualToViewWithOffset;

/**
 *  存储rightEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *rightOffset;


/**
 *  设置view的中心点x位置位置等于参考view中心点x位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView centerXEqualToViewWithOffset;
/**
 *  存储centerXEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *centerXOffset;


/**
 *  设置view的中心点y位置位置等于参考view中心点y位置 ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToView centerYEqualToViewWithOffset;
/**
 *  存储centerYEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *centerYOffset;


/**
 *  设置view宽度为绝对值value
 *  (value)
 */
@property (nonatomic, copy, readonly) WidthHeight widthIs;
/**
 *  存储widthIs的参数数据
 *  (value)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *widthValue;


/**
 *  设置view高度为绝对值value
 *  (value)
 */
@property (nonatomic, copy, readonly) WidthHeight heightIs;
/**
 *  存储heightIs的参数数据
 *  (value)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *heightValue;


/**
 *  view的宽等于view的高 x 高宽比例ratio
 *  (ratio)
 */
@property (nonatomic, copy, readonly) SameWidthHeight widthEqualToHeightWithRatio;
/**
 *  存储widthEqualToHeightWithRatio的参数数据
 *  (ratio)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *widthEqualHeight;


/**
 *  view的高等于view的宽 x 宽高比例ratio
 *  (ratio)
 */
@property (nonatomic, copy, readonly) SameWidthHeight heightEqualToWidthWithRatio;

/**
 *  存储heightEqualToWidthWithRatio的参数数据
 *  (ratio)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *heightEqualWidth;


/**
 *  设置view的content height等于参考view的bottom ＋ 偏移offset
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, copy, readonly) ContentHeight contentBottomEqualToViewWithOffset;
/**
 *  存储contentBottomEqualToViewWithOffset的参数数据
 *  (UIView *refView, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *contentHeight;


/**
 *  view的bottom等于数组里面的参考views中的最大bottom + 偏移offset
 *  (NSArray *refViews, CGFloat offset)
 */
@property (nonatomic, copy, readonly) MarginToViewArray bottomEqualToViewArrayWithOffset;
/**
 *  存储bottomEqualToViewArrayWithOffset的参数数据
 *  (NSArray *refViews, CGFloat offset)
 */
@property (nonatomic, strong, readonly) AutoLayoutArrayItem *bottomArrayOffset;


/**
 *  用于计算等宽的subviews的宽度，不直接使用
 *  使用-(void)lgb_equalWidthSubviews:(NSArray *)subviews方法替换
 *  (UIView *refView, CGFloat space, CGFloat ratio)
 */
@property (nonatomic, copy, readonly) WidthToView widthEqualToViewWithSpaceRatio;
/**
 *  存储widthEqualToViewWithSpaceRatio的参数数据
 *  (UIView *refView, CGFloat space, CGFloat ratio)
 */
@property (nonatomic, strong, readonly) AutoLayoutSpaceItem *widthSpaceRatio;


/**
 *  设置view高度的最大值，当view实际高度大于maxValue时，view的高度等于maxValue，否则等于view的实际高度，如果maxValue等于0时，
 *  view的高度等于实际高度
 *  (UIView *refView, CGFloat maxValue)
 */
@property (nonatomic, copy, readonly) WidthHeight maxHeightIs;
/**
 *  存储maxHeightIs的参数数据
 *  (UIView *refView, CGFloat maxValue)
 */
@property (nonatomic, strong, readonly) AutoLayoutItem *maxHeightValue;


/**
 *  更新布局
 */
-(void)updateLayout;

@end
