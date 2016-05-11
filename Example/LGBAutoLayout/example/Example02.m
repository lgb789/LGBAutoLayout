//
//  Example02.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/19.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example02.h"

@interface Example02 ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, assign) BOOL isAdd;
@end

@implementation Example02

#pragma mark - *********************** life cycle ***********************

-(void)dealloc
{
    DLog(@"dealloc");
}

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(changeText)];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.subLabel];
    [self.contentView addSubview:self.subView];

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

-(void)changeText
{
    self.isAdd = !self.isAdd;
    if (self.isAdd) {
        self.subLabel.text = [self.subLabel.text stringByAppendingString:self.subLabel.text];
    }else{
        self.subLabel.text = [self.subLabel.text substringToIndex:self.subLabel.text.length / 2];
    }
    

    [self.contentView.auto_layout updateLayout];

}

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    self.contentView.auto_layout
    .topSpaceToView(self.view, 80)
    .leftSpaceToView(self.view, 10)
    .rightSpaceToView(self.view, 10)
    .bottomEqualToViewWithOffset(self.subView, 10);
    
    self.subLabel.auto_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .maxHeightIs(0);
    
    self.subView.auto_layout
    .topSpaceToView(self.subLabel, 10)
    .leftEqualToViewWithOffset(self.subLabel, 0)
    .rightEqualToViewWithOffset(self.subLabel, 0)
    .heightIs(40);
    
}

#pragma mark - *********************** getters and setters ***********************
-(UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}

-(UILabel *)subLabel
{
    if (_subLabel == nil) {
        _subLabel = [UILabel new];
        _subLabel.backgroundColor = [UIColor yellowColor];
        _subLabel.text = @"电风扇等方法上独领风骚的快乐放假阿拉斯加分大煞风景是多福多寿份大煞风景方式德弗里斯";
        _subLabel.numberOfLines = 0;
    }
    return _subLabel;
}

-(UIView *)subView
{
    if (_subView == nil) {
        _subView = [UIView new];
        _subView.backgroundColor = [UIColor purpleColor];
    }
    return _subView;
}

@end
