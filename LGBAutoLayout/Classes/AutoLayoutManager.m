//
//  AutoLayoutManager.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/15.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "AutoLayoutManager.h"
#import <objc/runtime.h>


@implementation AutoLayoutItem

@end

@implementation AutoLayoutArrayItem

@end

@implementation AutoLayoutSpaceItem

@end

@interface AutoLayoutManager ()

@end

@implementation AutoLayoutManager

@synthesize leftSpaceToView                    = _leftSpaceToView;
@synthesize topSpaceToView                     = _topSpaceToView;
@synthesize rightSpaceToView                   = _rightSpaceToView;
@synthesize bottomSpaceToView                  = _bottomSpaceToView;
@synthesize widthEqualToViewWithRatio          = _widthEqualToViewWithRatio;
@synthesize heightEqualToViewWithRatio         = _heightEqualToViewWithRatio;
@synthesize leftEqualToViewWithOffset          = _leftEqualToViewWithOffset;
@synthesize topEqualToViewWithOffset           = _topEqualToViewWithOffset;
@synthesize rightEqualToViewWithOffset         = _rightEqualToViewWithOffset;
@synthesize bottomEqualToViewWithOffset        = _bottomEqualToViewWithOffset;
@synthesize centerXEqualToViewWithOffset       = _centerXEqualToViewWithOffset;
@synthesize centerYEqualToViewWithOffset       = _centerYEqualToViewWithOffset;
@synthesize widthIs                            = _widthIs;
@synthesize heightIs                           = _heightIs;
@synthesize widthEqualToHeightWithRatio        = _widthEqualToHeightWithRatio;
@synthesize heightEqualToWidthWithRatio        = _heightEqualToWidthWithRatio;
@synthesize contentBottomEqualToViewWithOffset = _contentBottomEqualToViewWithOffset;
@synthesize bottomEqualToViewArrayWithOffset   = _bottomEqualToViewArrayWithOffset;
@synthesize widthEqualToViewWithSpaceRatio     = _widthEqualToViewWithSpaceRatio;
@synthesize maxHeightIs                        = _maxHeightIs;
@synthesize contentRightEqualToViewWithOffset  = _contentRightEqualToViewWithOffset;

#pragma mark - *********************** public methods ***********************

-(void)updateLayout
{
    [self.view.superview setNeedsLayout];
    [self.view.superview layoutIfNeeded];
}

#pragma mark - *********************** overwrite methods ***********************

- (void)dealloc
{
//    DLog(@"dealloc");
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(MarginToView)marginToViewWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *view, CGFloat value){
        AutoLayoutItem *item = [AutoLayoutItem new];
        item.refView = view;
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(WidthHeight)widthHeightWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value){
        AutoLayoutItem *item = [AutoLayoutItem new];
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(SameWidthHeight)sameWidthHeightWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat value){
        AutoLayoutItem *item = [AutoLayoutItem new];
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(ContentHeight)contentHeightWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *view, CGFloat value){
        AutoLayoutItem *item = [AutoLayoutItem new];
        item.value = value;
        item.refView = view;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(MarginToViewArray)marginToViewArrayWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(NSArray *views, CGFloat value){
        AutoLayoutArrayItem *item = [AutoLayoutArrayItem new];
        item.value = value;
        item.refViews = views;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(WidthToView)widthToViewWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *view, CGFloat space, CGFloat ratio){
        AutoLayoutSpaceItem *item = [AutoLayoutSpaceItem new];
        item.refView = view;
        item.value = ratio;
        item.space = space;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

-(ContentWidth)contentWidthWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(UIView *view, CGFloat value){
        AutoLayoutItem *item = [AutoLayoutItem new];
        item.value = value;
        item.refView = view;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

#pragma mark - *********************** getters and setters ***********************

-(MarginToView)leftSpaceToView
{
    if (_leftSpaceToView == nil) {
        _leftSpaceToView = [self marginToViewWithKey:NSStringFromSelector(@selector(left))];
    }
    return _leftSpaceToView;
}

-(MarginToView)topSpaceToView
{
    if (_topSpaceToView == nil) {
        _topSpaceToView = [self marginToViewWithKey:NSStringFromSelector(@selector(top))];
    }
    return _topSpaceToView;
}

-(MarginToView)rightSpaceToView
{
    if (_rightSpaceToView == nil) {
        _rightSpaceToView = [self marginToViewWithKey:NSStringFromSelector(@selector(right))];
    }
    return _rightSpaceToView;
}

-(MarginToView)bottomSpaceToView
{
    if (_bottomSpaceToView == nil) {
        _bottomSpaceToView = [self marginToViewWithKey:NSStringFromSelector(@selector(bottom))];
    }
    return _bottomSpaceToView;
}

-(MarginToView)widthEqualToViewWithRatio
{
    if (_widthEqualToViewWithRatio == nil) {
        _widthEqualToViewWithRatio = [self marginToViewWithKey:NSStringFromSelector(@selector(width))];
    }
    return _widthEqualToViewWithRatio;
}

-(MarginToView)heightEqualToViewWithRatio
{
    if (_heightEqualToViewWithRatio == nil) {
        _heightEqualToViewWithRatio = [self marginToViewWithKey:NSStringFromSelector(@selector(height))];
    }
    return _heightEqualToViewWithRatio;
}

-(MarginToView)leftEqualToViewWithOffset
{
    if (_leftEqualToViewWithOffset == nil) {
        _leftEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(leftOffset))];
    }
    return _leftEqualToViewWithOffset;
}

-(MarginToView)topEqualToViewWithOffset
{
    if (_topEqualToViewWithOffset == nil) {
        _topEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(topOffset))];
    }
    return _topEqualToViewWithOffset;
}

-(MarginToView)rightEqualToViewWithOffset
{
    if (_rightEqualToViewWithOffset == nil) {
        _rightEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(rightOffset))];
    }
    return _rightEqualToViewWithOffset;
}

-(MarginToView)bottomEqualToViewWithOffset
{
    if (_bottomEqualToViewWithOffset == nil) {
        _bottomEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(bottomOffset))];
    }
    return _bottomEqualToViewWithOffset;
}

-(MarginToView)centerXEqualToViewWithOffset
{
    if (_centerXEqualToViewWithOffset == nil) {
        _centerXEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(centerXOffset))];
    }
    return _centerXEqualToViewWithOffset;
}

-(MarginToView)centerYEqualToViewWithOffset
{
    if (_centerYEqualToViewWithOffset == nil) {
        _centerYEqualToViewWithOffset = [self marginToViewWithKey:NSStringFromSelector(@selector(centerYOffset))];
    }
    return _centerYEqualToViewWithOffset;
}

-(WidthHeight)widthIs
{
    if (_widthIs == nil) {
        _widthIs = [self widthHeightWithKey:NSStringFromSelector(@selector(widthValue))];
    }
    return _widthIs;
}

-(WidthHeight)heightIs
{
    if (_heightIs == nil) {
        _heightIs = [self widthHeightWithKey:NSStringFromSelector(@selector(heightValue))];
    }
    return _heightIs;
}

-(SameWidthHeight)widthEqualToHeightWithRatio
{
    if (_widthEqualToHeightWithRatio == nil) {
        _widthEqualToHeightWithRatio = [self sameWidthHeightWithKey:NSStringFromSelector(@selector(widthEqualHeight))];
    }
    return _widthEqualToHeightWithRatio;
}

-(SameWidthHeight)heightEqualToWidthWithRatio
{
    if (_heightEqualToWidthWithRatio == nil) {
        _heightEqualToWidthWithRatio = [self sameWidthHeightWithKey:NSStringFromSelector(@selector(heightEqualWidth))];
    }
    return _heightEqualToWidthWithRatio;
}

-(ContentHeight)contentBottomEqualToViewWithOffset
{
    if (_contentBottomEqualToViewWithOffset == nil) {
        _contentBottomEqualToViewWithOffset = [self contentHeightWithKey:NSStringFromSelector(@selector(contentHeight))];
    }
    return _contentBottomEqualToViewWithOffset;
}

-(MarginToViewArray)bottomEqualToViewArrayWithOffset
{
    if (_bottomEqualToViewArrayWithOffset == nil) {
        _bottomEqualToViewArrayWithOffset = [self marginToViewArrayWithKey:NSStringFromSelector(@selector(bottomArrayOffset))];
    }
    return _bottomEqualToViewArrayWithOffset;
}

-(WidthToView)widthEqualToViewWithSpaceRatio
{
    if (_widthEqualToViewWithSpaceRatio == nil) {
        _widthEqualToViewWithSpaceRatio = [self widthToViewWithKey:NSStringFromSelector(@selector(widthSpaceRatio))];
    }
    return _widthEqualToViewWithSpaceRatio;
}

-(WidthHeight)maxHeightIs
{
    if (_maxHeightIs == nil) {
        _maxHeightIs = [self widthHeightWithKey:NSStringFromSelector(@selector(maxHeightValue))];
    }
    return _maxHeightIs;
}

-(ContentWidth)contentRightEqualToViewWithOffset
{
    if (_contentRightEqualToViewWithOffset == nil) {
        _contentRightEqualToViewWithOffset = [self contentWidthWithKey:NSStringFromSelector(@selector(contentWidth))];
    }
    return _contentRightEqualToViewWithOffset;
}

@end
