//
//  Example03.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/19.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example03.h"

@interface Example03 ()
@property (nonatomic, strong) UIView *first;
@property (nonatomic, strong) UIView *second;
@property (nonatomic, strong) UIView *third;
@property (nonatomic, strong) UIView *four;
@end

@implementation Example03

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.first];
    [self.view addSubview:self.second];
    [self.view addSubview:self.third];
    [self.view addSubview:self.four];

    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* add notificatioin */
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* remove notificatioin */
}

#pragma mark - *********************** delegate ***********************

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    self.first.auto_layout
    .topSpaceToView(self.view, 80)
    .leftSpaceToView(self.view, 10)
    .heightEqualToWidthWithRatio(1);
    
    self.second.auto_layout
    .topEqualToViewWithOffset(self.first, 0)
    .leftSpaceToView(self.first, 10)
    .heightEqualToWidthWithRatio(1);
    
    self.third.auto_layout
    .topEqualToViewWithOffset(self.first, 0)
    .leftSpaceToView(self.second, 160)
    .rightSpaceToView(self.view, 10)
    .heightEqualToViewWithRatio(self.first, 1);
    
    self.four.auto_layout
    .widthIs(100)
    .heightIs(100)
    .centerXEqualToViewWithOffset(self.view, 0)
    .centerYEqualToViewWithOffset(self.view, 0);
    
    //数组里面的3个subview宽度相等
    [self.view lgb_equalWidthSubviews:@[self.first, self.second, self.third]];
}

#pragma mark - *********************** getters and setters ***********************
-(UIView *)first
{
    if (_first == nil) {
        _first = [UIView new];
        _first.backgroundColor = [UIColor redColor];
    }
    return _first;
}

-(UIView *)second
{
    if (_second == nil) {
        _second = [UIView new];
        _second.backgroundColor = [UIColor greenColor];
    }
    return _second;
}

-(UIView *)third
{
    if (_third == nil) {
        _third = [UIView new];
        _third.backgroundColor = [UIColor blueColor];
    }
    return _third;
}

-(UIView *)four
{
    if (_four == nil) {
        _four = [UIView new];
        _four.backgroundColor = [UIColor purpleColor];
    }
    return _four;
}

@end
