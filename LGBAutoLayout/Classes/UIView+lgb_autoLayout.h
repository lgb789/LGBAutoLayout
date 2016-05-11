//
//  UIView+lgb_autoLayout.h
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/15.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoLayoutManager.h"
#import "UIView+lgb_layout.h"

@interface UIView (lgb_autoLayout)

/**
 *  返回view的高度
 *
 *  @param view
 *
 *  @return view的高度
 */
-(CGFloat)lgb_heightFromView:(UIView *)view;

/**
 *  返回自动布局管理类
 *
 *  @return
 */
-(AutoLayoutManager *)auto_layout;

/**
 *  根据参考view的底部坐标以及偏移offset 设置self的高度
 *
 *  @param view   参考view，self的底部与view底部坐标一样
 *  @param offset 偏移
 */
-(void)lgb_setHeightEqualToViewBottom:(UIView *)view
                           withOffset:(CGFloat)offset;

/**
 *  设置subviews的宽度相等
 *
 *  @param subviews subview数组
 */
-(void)lgb_equalWidthSubviews:(NSArray *)subviews;

@end
