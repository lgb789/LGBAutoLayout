//
//  Example09_Cell2.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/28.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example09_Cell2.h"
#import "Example09_Model.h"

@interface Example09_Cell2 ()
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@end

@implementation Example09_Cell2

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.image1];
        [self.contentView addSubview:self.image2];
        [self.contentView addSubview:self.image3];
        
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewArrayWithOffset(@[self.image1, self.image2, self.image3], 10);
        
        self.text.auto_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .rightSpaceToView(self.contentView, 10)
        .maxHeightIs(0);
        
        self.image1.auto_layout
        .topSpaceToView(self.text, 10)
        .leftSpaceToView(self.contentView, 10);
        
        self.image2.auto_layout
        .topSpaceToView(self.text, 10)
        .leftSpaceToView(self.image1, 10);
        
        self.image3.auto_layout
        .topSpaceToView(self.text, 10)
        .leftSpaceToView(self.image2, 10)
        .rightSpaceToView(self.contentView, 10);
        
        
        [self.contentView lgb_equalWidthSubviews:@[self.image1, self.image2, self.image3]];
        
    }
    return self;
}

#pragma mark - *********************** delegate ***********************
-(void)tableViewCellConfigWithData:(id)data
{
    Example09_Model *model = data;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:model.text attributes:@{
                                                                                                 NSParagraphStyleAttributeName:style
                                                                                                 }];
    self.text.attributedText = str;
    
    UIImage *img1 = [UIImage imageNamed:model.photos[0]];
    UIImage *img2 = [UIImage imageNamed:model.photos[1]];
    UIImage *img3 = [UIImage imageNamed:model.photos[2]];
    
    self.image1.image = img1;
    self.image2.image = img2;
    self.image3.image = img3;
    
    self.image1.auto_layout
    .heightEqualToWidthWithRatio(img1.size.height / img1.size.width);
    self.image2.auto_layout
    .heightEqualToWidthWithRatio(img2.size.height / img2.size.width);
    self.image3.auto_layout
    .heightEqualToWidthWithRatio(img3.size.height / img3.size.width);
    
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UILabel *)text
{
    if (_text == nil) {
        _text = [UILabel new];
        _text.backgroundColor = [UIColor clearColor];
    }
    return _text;
}

-(UIImageView *)image1
{
    if (_image1 == nil) {
        _image1 = [UIImageView new];
    }
    return _image1;
}

-(UIImageView *)image2
{
    if (_image2 == nil) {
        _image2 = [UIImageView new];
    }
    return _image2;
}

-(UIImageView *)image3
{
    if (_image3 == nil) {
        _image3 = [UIImageView new];
    }
    return _image3;
}

@end
