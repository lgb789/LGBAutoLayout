//
//  Example11.m
//  LGBAutoLayout
//
//  Created by lgb789 on 16/5/17.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "Example11.h"

@interface Example11 ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation Example11

#pragma mark - 生命周期 

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.scrollView];

    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* add notificatioin */
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *view = self.scrollView;
    for (int i = 0; i < 10; i++) {
        UIView *v = [UIView new];
        CGFloat value = 198 - i;
        CGFloat color = value / 255.0;
        v.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
        [self.scrollView addSubview:v];
        
        v.auto_layout
        .leftSpaceToView(view, 10)
        .topSpaceToView(self.scrollView, 0)
        .bottomSpaceToView(self.scrollView, 0)
        .widthIs(60);
        
        view = v;
    }
    
    self.scrollView.auto_layout
    .contentRightEqualToViewWithOffset(view, 10);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* remove notificatioin */
}

#pragma mark - 代理

#pragma mark - 事件处理 

#pragma mark - 私有方法

-(void)layoutSubviews
{
    self.scrollView.auto_layout
    .leftSpaceToView(self.view, 0)
    .centerYEqualToViewWithOffset(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(60);
}

#pragma mark - 成员变量初始化与设置

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollView;
}

@end
