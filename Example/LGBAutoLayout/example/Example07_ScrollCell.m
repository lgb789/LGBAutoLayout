//
//  Example07_ScrollCell.m
//  LGBAutoLayout
//
//  Created by lgb789 on 16/5/11.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "Example07_ScrollCell.h"

@interface Example07_ScrollCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation Example07_ScrollCell

#pragma mark - 公有方法 

#pragma mark - 重写父类方法

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

-(void)configCellWithData:(id)data
{
    self.imageView.image = [UIImage imageNamed:data];
}

#pragma mark - 代理

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end
