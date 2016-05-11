//
//  Example08.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/26.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example08.h"

@interface Example08 ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *view0;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@end

@implementation Example08

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.view0];
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];

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
    self.scrollView.auto_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .widthEqualToViewWithRatio(self.view, 1)
    .heightEqualToViewWithRatio(self.view, 1)
    .contentBottomEqualToViewWithOffset(self.view3, 0); //设置content height
    
    self.view0.auto_layout
    .topSpaceToView(self.scrollView, 10)
    .widthEqualToViewWithRatio(self.scrollView, 0.7)
    .heightEqualToViewWithRatio(self.scrollView, 0.2)
    .centerXEqualToViewWithOffset(self.scrollView, 0);
    
    self.view1.auto_layout
    .topSpaceToView(self.view0, 10)
    .widthEqualToViewWithRatio(self.scrollView, 0.5)
    .heightEqualToViewWithRatio(self.scrollView, 0.4)
    .centerXEqualToViewWithOffset(self.scrollView, 0);
    
    self.view2.auto_layout
    .topSpaceToView(self.view1, 10)
    .widthEqualToViewWithRatio(self.scrollView, 0.5)
    .heightEqualToViewWithRatio(self.scrollView, 0.6)
    .centerXEqualToViewWithOffset(self.scrollView, 0);
    
    self.view3.auto_layout
    .topSpaceToView(self.view2, 10)
    .widthEqualToViewWithRatio(self.scrollView, 0.5)
    .heightEqualToViewWithRatio(self.scrollView, 0.6)
    .centerXEqualToViewWithOffset(self.scrollView, 0);
    
}

#pragma mark - *********************** getters and setters ***********************
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

-(UIView *)view0
{
    if (_view0 == nil) {
        _view0 = [UIView new];
        _view0.backgroundColor = [UIColor redColor];
    }
    return _view0;
}

-(UIView *)view1
{
    if (_view1 == nil) {
        _view1 = [UIView new];
        _view1.backgroundColor = [UIColor grayColor];
    }
    return _view1;
}

-(UIView *)view2
{
    if (_view2 == nil) {
        _view2 = [UIView new];
        _view2.backgroundColor = [UIColor purpleColor];
    }
    return _view2;
}

-(UIView *)view3
{
    if (_view3 == nil) {
        _view3 = [UIView new];
        _view3.backgroundColor = [UIColor greenColor];
    }
    return _view3;
}

@end
