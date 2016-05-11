//
//  Example04_cell.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/20.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example04_cell.h"

@interface Example04_cell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *view0;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;
@end

@implementation Example04_cell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.view0];
        [self.contentView addSubview:self.view1];
        [self.contentView addSubview:self.view2];
        [self.contentView addSubview:self.view3];
        [self.contentView addSubview:self.view4];
#if 0
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewWithOffset(self.label, 10);
        
        self.label.auto_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .maxHeightIs(0);
#else
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewWithOffset(self.view3, 10);
        
//        self.label.auto_layout
//        .topSpaceToView(self.contentView, 0)
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .heightIs(0);
        
        self.view0.auto_layout
        .leftSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView, 10)
        .widthIs(50)
        .heightIs(50);
        
        self.view1.auto_layout
        .leftSpaceToView(self.view0, 10)
        .topSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightEqualToViewWithRatio(self.view0, 0.4);
        
        self.label.auto_layout
        .topSpaceToView(self.view1, 10)
        .leftSpaceToView(self.view0, 10)
        .rightSpaceToView(self.contentView, 60)
        .maxHeightIs(0);
        
        self.view2.auto_layout
        .topSpaceToView(self.view1, 10)
        .leftSpaceToView(self.label, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightEqualToViewWithRatio(self.label, 1);
        
        self.view3.auto_layout
        .leftSpaceToView(self.view0, 10)
        .topSpaceToView(self.label, 10)
        .widthEqualToViewWithRatio(self.label, 0.7)
        .heightEqualToViewWithRatio(self.label, 0.5);
#endif
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    DLog(@"layout subviews:%@", NSStringFromCGRect(self.contentView.bounds));
}

#pragma mark - *********************** delegate ***********************
-(void)tableViewCellConfigWithData:(id)data
{
    if (data == nil) {
        return;
    }
    self.label.text = data;
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UILabel *)label
{
    if (_label == nil) {
        _label = [UILabel new];
        _label.backgroundColor = [UIColor brownColor];
    }
    return _label;
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
        _view2.backgroundColor = [UIColor orangeColor];
    }
    return _view2;
}

-(UIView *)view3
{
    if (_view3 == nil) {
        _view3 = [UIView new];
        _view3.backgroundColor = [UIColor purpleColor];
    }
    return _view3;
}

-(UIView *)view4
{
    if (_view4 == nil) {
        _view4 = [UIView new];
        _view4.backgroundColor = [UIColor yellowColor];
    }
    return _view4;
}

//-(void)setText:(NSString *)text
//{
//    if (_text == text) {
//        return;
//    }
//    _text = text;
//    self.label.text = _text;
//}

@end
