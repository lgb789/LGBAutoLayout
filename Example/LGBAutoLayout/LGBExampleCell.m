//
//  LGBExampleCell.m
//  LGBAutoLayout
//
//  Created by lgb789 on 16/5/10.
//  Copyright © 2016年 lgb789. All rights reserved.
//

#import "LGBExampleCell.h"

@interface LGBExampleCell ()
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation LGBExampleCell

#pragma mark - 公有方法 

#pragma mark - 重写父类方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.detailLabel];
        
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewWithOffset(self.detailLabel, 10);
        
        self.titleLable.auto_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .maxHeightIs(0);
        
        self.detailLabel.auto_layout
        .topSpaceToView(self.titleLable, 10)
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .maxHeightIs(0);
    }
    return self;
}

#pragma mark - 代理

-(void)tableViewCellConfigWithData:(id)data
{
    self.titleLable.text = data[0];
    //    self.detailLabel.text = data[1];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:data[1]
                                                              attributes:@{
                                                                           NSParagraphStyleAttributeName:style
                                                                           }];
    self.detailLabel.attributedText = str;
}

#pragma mark - 事件处理 

#pragma mark - 私有方法

#pragma mark - 成员变量初始化与设置
-(UILabel *)titleLable
{
    if (_titleLable == nil) {
        _titleLable = [UILabel new];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLable;
}

-(UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [UILabel new];
        _detailLabel.backgroundColor = [UIColor whiteColor];
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _detailLabel;
}

@end
