//
//  UIView+lgb_layout.m
//  
//
//  Created by lgb789 on 16/4/14.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "UIView+lgb_layout.h"

@implementation UIView (lgb_layout)

-(CGFloat)height
{
    return CGRectGetHeight(self.bounds);
}

-(CGFloat)width
{
    return CGRectGetWidth(self.bounds);
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)heightEqualToView:(UIView *)view
{
    self.height = view.height;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)widthEqualToView:(UIView *)view
{
    self.width = view.width;
}

-(CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

-(CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)left
{
    return CGRectGetMinX(self.frame);
}

-(CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)top
{
    return CGRectGetMinY(self.frame);
}

-(CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

-(void)setLeft:(CGFloat)left
{
    self.x = left;
}

-(void)setTop:(CGFloat)top
{
    self.y = top;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

-(void)sizeEqualToView:(UIView *)view
{
    self.size = view.size;
}

-(CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterX:(CGFloat)x
{
    self.center = CGPointMake(x, self.center.y);
}

-(void)setCenterY:(CGFloat)y
{
    self.center = CGPointMake(self.center.x, y);
}

-(void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenter = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenter toView:self.superview];
    self.centerX = centerPoint.x;
}

-(void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenter = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenter toView:self.superview];
    self.centerY = centerPoint.y;
}

-(void)centerEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenter = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenter toView:self.superview];
    self.center = centerPoint;
}

-(void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:view.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.top = newOrigin.y;
}

-(void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.left = newOrigin.x;
}

-(void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.height = newOrigin.y + view.height - self.y;
}

-(void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    self.width = newOrigin.x + view.width - self.x;
}

-(void)topSpace:(CGFloat)top
         toView:(UIView *)view
{
    if (self.superview == view) {
        self.y = top;
    }else{
        UIView *superView = view.superview ? view.superview : view;
        CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
        CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
        self.y = newOrigin.y + view.height + top;
    }
    
}

-(void)leftSpace:(CGFloat)left
          toView:(UIView *)view
{
    if (self.superview == view) {
        self.x = left;
    }else{
        UIView *superView = view.superview ? view.superview : view;
        CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
        CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
        self.x = newOrigin.x + view.width + left;
    }
    
}

-(void)bottomSpace:(CGFloat)bottom
            toView:(UIView *)view
{
    if (self.superview == view) {
        self.height = view.height - bottom - self.y;
    }else{
        UIView *superView = view.superview ? view.superview : view;
        CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
        CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
        self.height = newOrigin.y - self.y - bottom;
    }
    
}

-(void)rightSpace:(CGFloat)right
           toView:(UIView *)view
{
    if (self.superview == view) {
        self.width = view.width - right - self.x;
    }else{
        UIView *superView = view.superview ? view.superview : view;
        CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.topSuperView];
        CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
        self.width = newOrigin.x - self.x - right;
    }
    
}

-(UIView *)topSuperView
{
    UIView *superView = self.superview;
    if (superView == nil) {
        return self;
    }
    while (superView.superview) {
        superView = superView.superview;
    }
    return superView;
}

@end
