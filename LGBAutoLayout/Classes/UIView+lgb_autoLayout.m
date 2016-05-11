//
//  UIView+lgb_autoLayout.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/15.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "UIView+lgb_autoLayout.h"
#import <objc/runtime.h>

@implementation UIView (lgb_autoLayout)

-(AutoLayoutManager *)auto_layout
{
    AutoLayoutManager *manager = [self autoLayoutManager];
    if (manager == nil) {
        manager = [AutoLayoutManager new];
        manager.view = self;
        [self setAutoLayoutManager:manager];
        NSMutableArray *array = [self.superview autoLayoutArray];
        if (array == nil) {
            array = [NSMutableArray array];
            [self.superview setAutoLayoutArray:array];
        }
        [array addObject:manager];
    }
    return manager;
}

-(void)lgb_setHeightEqualToViewBottom:(UIView *)view
                           withOffset:(CGFloat)offset
{
    self.height = [self lgb_yFromView:view] + [self lgb_heightFromView:view] + offset;
}

-(void)lgb_equalWidthSubviews:(NSArray *)subviews
{
    if (subviews == nil || subviews.count == 0) {
        return;
    }
    CGFloat ratio = 1.0 / subviews.count;
    CGFloat space = 0;

    for (UIView *v in subviews) {
        AutoLayoutManager *m = [v autoLayoutManager];
        if (m) {
            if (m.left) {
                space += m.left.value;
            }
            if (m.right) {
                space += m.right.value;
            }
        }
        
    }
    
//    DLog(@"width sub----->%f,%f,%ld", space, ratio, subviews.count);
    
    for (UIView *v in subviews) {
        AutoLayoutManager *m = [v autoLayoutManager];
        if (m) {
            m.widthEqualToViewWithSpaceRatio(self, space, ratio);
        }
    }
}

#pragma mark - *********************** method swizzling ***********************

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(self, NSSelectorFromString(@"layoutSubviews"));
        Method newMethod = class_getInstanceMethod(self, NSSelectorFromString(@"lgb_layoutSubviews"));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

#pragma mark - *********************** private methods ***********************
-(UIView *)lgb_topSuperView:(UIView *)view
{
    UIView *superView = view.superview;
    if (superView == nil) {
        return view;
    }
    while (superView.superview) {
        superView = superView.superview;
    }
    return superView;
}

-(CGFloat)lgb_yFromView:(UIView *)view
{
    AutoLayoutManager *manager = [view autoLayoutManager];
    CGFloat y = view.y;
    if (manager) {
        y = [self lgb_yWithManager:manager];
    }
    return y;
}

-(CGFloat)lgb_xFromView:(UIView *)view
{
    AutoLayoutManager *manager = [view autoLayoutManager];
    CGFloat x = view.x;
    if (manager) {
        x = [self lgb_xWithManager:manager];
    }
    return x;
}

-(CGFloat)lgb_widthFromView:(UIView *)view
{
    AutoLayoutManager *manager = [view autoLayoutManager];
    CGFloat width = view.width;
    if (manager) {
        width = [self lgb_widthWithManager:manager];
    }
    return width;
}

-(CGFloat)lgb_heightFromView:(UIView *)view
{
    AutoLayoutManager *manager = [view autoLayoutManager];
    CGFloat height = view.height;
    if (manager) {
        height = [self lgb_heightWithManager:manager];
    }
    return height;
}

-(CGFloat)lgb_xFromView:(UIView *)fromView
              leftSpace:(CGFloat)space
                 toView:(UIView *)toView
{
    if (fromView.superview == toView) {
        return space;
    }
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    
    CGFloat toWidth = [self lgb_widthFromView:toView];
    CGFloat toX = [self lgb_xFromView:toView];
   
    CGPoint origin = [superView convertPoint:CGPointMake(toX, 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x + toWidth + space;
}

-(CGFloat)lgb_xFromView:(UIView *)fromView
             rightSpace:(CGFloat)space
                 toView:(UIView *)toView
{
    if (fromView.superview == toView) {
        return [self lgb_widthFromView:toView] - space - [self lgb_widthFromView:fromView];
    }
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake([self lgb_xFromView:toView], 0) toView:toView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x - [self lgb_widthFromView:fromView] - space;
}

-(CGFloat)lgb_xFromView:(UIView *)fromView
        leftEqualToView:(UIView *)toView
             withOffset:(CGFloat)offset
{
    if (fromView.superview == toView) {
        return [self lgb_xFromView:fromView leftSpace:offset toView:toView];
    }
    
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    
    CGFloat toX = [self lgb_xFromView:toView];
    
    CGPoint origin = [superView convertPoint:CGPointMake(toX, 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x + offset;
}

-(CGFloat)lgb_xFromView:(UIView *)fromView
       rightEqualToView:(UIView *)toView
             withOffset:(CGFloat)offset
{
    if (fromView.superview == toView) {
        return [self lgb_xFromView:fromView rightSpace:offset toView:toView];
    }
    
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake([self lgb_xFromView:toView], 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x + [self lgb_widthFromView:toView] - [self lgb_widthFromView:fromView];
    
}

-(CGFloat)lgb_xFromView:(UIView *)fromView
     centerXEqualToView:(UIView *)toView
             withOffset:(CGFloat)offset
{
    CGFloat toX = [self lgb_xFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(toX, 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x + [self lgb_widthFromView:toView] / 2 - [self lgb_widthFromView:fromView] / 2 + offset;
}

-(CGFloat)lgb_yFromView:(UIView *)fromView
               topSpace:(CGFloat)space
                 toView:(UIView *)toView
{
    if (fromView.superview == toView) {
        return space;
    }
    CGFloat toY = [self lgb_yFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(0, toY) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.y + [self lgb_heightFromView:toView] + space;
}

-(CGFloat)lgb_yFromView:(UIView *)fromView
         topEqualToView:(UIView *)toView
             withOffset:(CGFloat)offset
{
    if (fromView.superview == toView) {
        return [self lgb_yFromView:fromView topSpace:offset toView:toView];
    }
    CGFloat toY = [self lgb_yFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(0, toY) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.y + offset;
}

-(CGFloat)lgb_yFromView:(UIView *)fromView
     centerYEqualToView:(UIView *)toView
             withOffset:(CGFloat)offset
{
    CGFloat toY = [self lgb_yFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(0, toY) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.y + [self lgb_heightFromView:toView] / 2 - [self lgb_heightFromView:fromView] / 2 + offset;
}

-(CGFloat)lgb_widthFromView:(UIView *)fromView
                 rightSpace:(CGFloat)space
                     toView:(UIView *)toView
{
    if (fromView.superview == toView) {
        return [self lgb_widthFromView:toView] - [self lgb_xFromView:fromView] - space;
    }
    CGFloat toX = [self lgb_xFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(toX, 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x - [self lgb_xFromView:fromView] - space;
}

-(CGFloat)lgb_widthFromView:(UIView *)fromView
           rightEqualToView:(UIView *)toView
                 withOffset:(CGFloat)offset
{
    CGFloat toX = [self lgb_xFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(toX, 0) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.x + [self lgb_widthFromView:toView] - [self lgb_xFromView:fromView] + offset;
}

-(CGFloat)lgb_heightFromView:(UIView *)fromView
                 bottomSpace:(CGFloat)space
                      toView:(UIView *)toView
{
    if (fromView.superview == toView) {
        return [self lgb_heightFromView:toView] - [self lgb_yFromView:fromView] - space;
    }
    
    CGFloat toY = [self lgb_yFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(0, toY) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];
    
    return newOrigin.y - [self lgb_yFromView:fromView] - space;
}

-(CGFloat)lgb_HeightFromView:(UIView *)fromView
           bottomEqualToView:(UIView *)toView
                  withOffset:(CGFloat)offset
{
    CGFloat toY = [self lgb_yFromView:toView];
    UIView *topView = [self lgb_topSuperView:fromView];
    
    UIView *superView = toView.superview ? toView.superview : toView;
    CGPoint origin = [superView convertPoint:CGPointMake(0, toY) toView:topView];
    CGPoint newOrigin = [topView convertPoint:origin toView:fromView.superview];

    return newOrigin.y + [self lgb_heightFromView:toView] - [self lgb_yFromView:fromView] + offset;
}

-(CGFloat)lgb_xWithManager:(AutoLayoutManager *)manager
{
    if (manager.left) {
        return [self lgb_xFromView:manager.view leftSpace:manager.left.value toView:manager.left.refView];
    }else if (manager.leftOffset) {

        return [self lgb_xFromView:manager.view leftEqualToView:manager.leftOffset.refView withOffset:manager.leftOffset.value];
    }else if (manager.centerXOffset) {
        CGFloat x = [self lgb_xFromView:manager.view centerXEqualToView:manager.centerXOffset.refView withOffset:manager.centerXOffset.value];
        return x;
    }else if (manager.right){
        return [self lgb_xFromView:manager.view rightSpace:manager.right.value toView:manager.right.refView];
    }else if (manager.rightOffset){
        return [self lgb_xFromView:manager.view rightEqualToView:manager.rightOffset.refView withOffset:manager.rightOffset.value];
    }
    
    return self.x;
}

-(CGFloat)lgb_yWithManager:(AutoLayoutManager *)manager
{
    if (manager.top) {
        return [self lgb_yFromView:manager.view topSpace:manager.top.value toView:manager.top.refView];
    }else if (manager.topOffset) {
        return [self lgb_yFromView:manager.view topEqualToView:manager.topOffset.refView withOffset:manager.topOffset.value];
    }else if (manager.centerYOffset) {
        CGFloat y = [self lgb_yFromView:manager.view centerYEqualToView:manager.centerYOffset.refView withOffset:manager.centerYOffset.value];
        return y;
    }
    return self.y;
}

-(CGFloat)lgb_widthWithManager:(AutoLayoutManager *)manager
{
    if (manager.widthEqualHeight) {
        return [self lgb_heightFromView:manager.view] * manager.widthEqualHeight.value;
    }else if (manager.widthValue) {
        return manager.widthValue.value;
    }else if (manager.width) {
        return [self lgb_widthFromView:manager.width.refView] * manager.width.value;
    }else if (manager.widthSpaceRatio){
        return ([self lgb_widthFromView:manager.widthSpaceRatio.refView] - manager.widthSpaceRatio.space) * manager.widthSpaceRatio.value;
    }else if (manager.right) {
        return [self lgb_widthFromView:manager.view rightSpace:manager.right.value toView:manager.right.refView];
    }else if (manager.rightOffset) {
        return [self lgb_widthFromView:manager.view rightEqualToView:manager.rightOffset.refView withOffset:manager.rightOffset.value];
    }
    return self.width;
}

-(CGFloat)lgb_heightWithManager:(AutoLayoutManager *)manager
{
    if ([manager.view isKindOfClass:[UILabel class]] && manager.maxHeightValue) {
        UILabel *label = (UILabel *)manager.view;
        label.numberOfLines = 0;
        CGFloat width = [self lgb_widthFromView:manager.view];
        CGSize size = [label sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];

        if (manager.maxHeightValue.value == 0) {
            return size.height;
        }else{
            return size.height > manager.maxHeightValue.value ? manager.maxHeightValue.value : size.height;
        }
        
    }
    
    if (manager.heightEqualWidth) {
        return manager.heightEqualWidth.value * [self lgb_widthFromView:manager.view];
        
    }else if (manager.heightValue) {

        return manager.heightValue.value;
        
    }else if (manager.height) {
        return [self lgb_heightFromView:manager.height.refView] * manager.height.value;
        
    }else if (manager.bottom) {
        return [self lgb_heightFromView:manager.view bottomSpace:manager.bottom.value toView:manager.bottom.refView];
        
    }else if (manager.bottomOffset) {
        CGFloat height = [self lgb_HeightFromView:manager.view bottomEqualToView:manager.bottomOffset.refView withOffset:manager.bottomOffset.value];
        return height;
        
    }else if (manager.bottomArrayOffset){
        CGFloat height = 0;
        for (UIView *v in manager.bottomArrayOffset.refViews) {
            height = MAX(height, [self lgb_HeightFromView:manager.view bottomEqualToView:v withOffset:manager.bottomArrayOffset.value]);
        }

        return height;
    }

    return self.height;
}

-(void)lgb_layoutSubviews
{
    [self lgb_layoutSubviews];
    NSMutableArray *array = [self autoLayoutArray];
    if (array.count > 0){
        [array enumerateObjectsUsingBlock:^(AutoLayoutManager *manager, NSUInteger idx, BOOL * _Nonnull stop) {
            
            manager.view.x = [self lgb_xWithManager:manager];
            manager.view.y = [self lgb_yWithManager:manager];
            manager.view.width = [self lgb_widthWithManager:manager];
            manager.view.height = [self lgb_heightWithManager:manager];
            
            if (manager.contentHeight) {
                if ([manager.view isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scroll = (UIScrollView *)manager.view;
                    CGFloat height = [self lgb_heightFromView:manager.contentHeight.refView] + [self lgb_yFromView:manager.contentHeight.refView];
                    scroll.contentSize = CGSizeMake(manager.view.width, manager.contentHeight.value + height);
                    
                }
            }
            
        }];
        
    }
    
}

#pragma mark - *********************** getters and setters ***********************
-(AutoLayoutManager *)autoLayoutManager
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setAutoLayoutManager:(AutoLayoutManager *)manager
{
    objc_setAssociatedObject(self, @selector(autoLayoutManager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)autoLayoutArray
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setAutoLayoutArray:(NSMutableArray *)array
{
    objc_setAssociatedObject(self, @selector(autoLayoutArray), array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
