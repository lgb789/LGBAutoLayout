//
//  Example06.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/21.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example06.h"

@interface Example06 ()
@property (nonatomic, strong) UIView *view0;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;
@property (nonatomic, strong) UIView *view5;
@property (nonatomic, strong) UILabel *label;
@end

@implementation Example06

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.view0];
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];
    [self.view addSubview:self.view4];
    [self.view addSubview:self.view5];
    [self.view addSubview:self.label];

    [self layoutSubviews];
    
    NSString *text = @"使用attributedText方法，NSMutableAttributedString对象添加只添加NSParagraphStyleAttributeName时无效，添加NSUnderlineStyleAttributeName之后两端对齐才有效。在网上搜索出的说法是: 设置文字段落的字符串常量 （文字段落框要有宽度和高度才有效果），设置NSUnderlineStyleAttributeName常量是设置base attributes格式";
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:8];
    UIColor *color = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : color}];
    self.label.attributedText = attributeString;
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
    self.view0.auto_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view, 80)
    .widthIs(50)
    .heightIs(150);
    
    self.view1.auto_layout
    .topEqualToViewWithOffset(self.view0, 0)
    .leftSpaceToView(self.view0, 15)
    .rightSpaceToView(self.view, 15)
    .heightEqualToViewWithRatio(self.view0, 0.3);
    
    self.view2.auto_layout
    .topSpaceToView(self.view1, 15)
    .leftEqualToViewWithOffset(self.view1, 0)
    .widthEqualToViewWithRatio(self.view1, 0.4)
    .heightEqualToViewWithRatio(self.view0, 0.3);

    self.view3.auto_layout
    .topEqualToViewWithOffset(self.view2, 0)
    .leftSpaceToView(self.view2, 10)
    .rightEqualToViewWithOffset(self.view1, 0)
    .heightEqualToViewWithRatio(self.view2, 1);
    
    self.view4.auto_layout
    .topSpaceToView(self.view3, 15)
    .leftEqualToViewWithOffset(self.view2, 0)
    .widthEqualToViewWithRatio(self.view1, 0.7)
    .bottomEqualToViewWithOffset(self.view0, 0);
    
    self.view5.auto_layout
    .topEqualToViewWithOffset(self.view4, 0)
    .leftSpaceToView(self.view4, 10)
    .rightEqualToViewWithOffset(self.view1, 0)
    .bottomEqualToViewWithOffset(self.view4, 0);
    
    self.label.auto_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(self.view5, 10)
    .rightSpaceToView(self.view, 10)
    .maxHeightIs(0);
}

#pragma mark - *********************** getters and setters ***********************
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
        _view1.backgroundColor = [UIColor greenColor];
    }
    return _view1;
}

-(UIView *)view2
{
    if (_view2 == nil) {
        _view2 = [UIView new];
        _view2.backgroundColor = [UIColor brownColor];
    }
    return _view2;
}

-(UIView *)view3
{
    if (_view3 == nil) {
        _view3 = [UIView new];
        _view3.backgroundColor = [UIColor yellowColor];
    }
    return _view3;
}

-(UIView *)view4
{
    if (_view4 == nil) {
        _view4 = [UIView new];
        _view4.backgroundColor = [UIColor orangeColor];
    }
    return _view4;
}

-(UIView *)view5
{
    if (_view5 == nil) {
        _view5 = [UIView new];
        _view5.backgroundColor = [UIColor purpleColor];
    }
    return _view5;
}

-(UILabel *)label
{
    if (_label == nil) {
        _label = [UILabel new];
        _label.backgroundColor = [UIColor purpleColor];
        _label.lineBreakMode = NSLineBreakByClipping;
        _label.font = [UIFont systemFontOfSize:16];
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
