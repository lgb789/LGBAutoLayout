//
//  TTView.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/1.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "TTView.h"
#import "UIView+lgb_layout.h"
#import "UIView+lgb_autoLayout.h"

@interface TTView()
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *thirdView;
@end

@implementation TTView

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** life cycle ***********************

-(void)dealloc
{
    DLog(@"dealloc");
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.firstView];
        [self addSubview:self.secondView];
        [self addSubview:self.thirdView];
        
        self.backgroundColor = [UIColor blackColor];
        
        self.firstView.auto_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .widthEqualToViewWithRatio(self, 0.7)
        .bottomEqualToViewWithOffset(self, 0);
        
        self.secondView.auto_layout
        .topSpaceToView(self.thirdView, 0)
        .leftSpaceToView(self.firstView, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewWithOffset(self.firstView, 0);
        
        self.thirdView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self.firstView, 0)
        .rightSpaceToView(self, 0)
        .heightEqualToViewWithRatio(self, 0.3);
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************

-(UIView *)firstView
{
    if (_firstView == nil) {
        _firstView = [[UIView alloc] init];
        _firstView.backgroundColor = [UIColor redColor];
    }
    return _firstView;
}

-(UIView *)secondView
{
    if (_secondView == nil) {
        _secondView = [[UIView alloc] init];
        _secondView.backgroundColor = [UIColor yellowColor];
    }
    return _secondView;
}

-(UIView *)thirdView
{
    if (_thirdView == nil) {
        _thirdView = [[UIView alloc] init];
        _thirdView.backgroundColor = [UIColor blueColor];
    }
    return _thirdView;
}

@end
