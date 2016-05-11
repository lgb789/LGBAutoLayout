//
//  Example07_Cell.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/26.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example07_Cell.h"
#import "Example07_Model.h"

@interface Example07_Cell ()
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation Example07_Cell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.image];
        
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0);

        
        self.photo.auto_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightEqualToWidthWithRatio(1);
        
        self.name.auto_layout
        .topEqualToViewWithOffset(self.photo, 0)
        .leftSpaceToView(self.photo, 10)
        .rightSpaceToView(self.contentView, 10)
        .maxHeightIs(0);
        
        self.text.auto_layout
        .topSpaceToView(self.name, 10)
        .leftEqualToViewWithOffset(self.name, 0)
        .rightSpaceToView(self.contentView, 10)
        .maxHeightIs(0);
        
        self.image.auto_layout
        .topSpaceToView(self.text, 10)
        .leftEqualToViewWithOffset(self.text, 0)
        .widthEqualToViewWithRatio(self.text, 0.7);
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    DLog(@"layous subviews------>%@", NSStringFromCGRect(self.image.frame));
    
}

#pragma mark - *********************** delegate ***********************
-(void)tableViewCellConfigWithData:(id)data
{
    Example07_Model *model = data;
    self.photo.image = [UIImage imageNamed:model.photo];
    self.name.text = model.name;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    self.text.attributedText = [[NSAttributedString alloc] initWithString:model.text attributes:@{
                                                                                                  NSParagraphStyleAttributeName:style
                                                                                                  }];
    
    
    if (model.image) {
        
        UIImage *img = [UIImage imageNamed:model.image];
        self.image.image = img;
        self.image.hidden = NO;
        self.image.auto_layout
        .heightEqualToWidthWithRatio(img.size.height / img.size.width);
        
        self.contentView.auto_layout
        .bottomEqualToViewWithOffset(self.image, 10);
        
    }else{
        self.image.image = nil;//没有图片要置空
        self.image.auto_layout
        .heightIs(0);
        self.image.hidden = YES;
        self.contentView.auto_layout
        .bottomEqualToViewWithOffset(self.text, 10);
    }

}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIImageView *)photo
{
    if (_photo == nil) {
        _photo = [UIImageView new];
    }
    return _photo;
}

-(UILabel *)name
{
    if (_name == nil) {
        _name = [UILabel new];
        _name.backgroundColor = [UIColor clearColor];
        _name.font = [UIFont systemFontOfSize:16.0];
        _name.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _name;
}

-(UILabel *)text
{
    if (_text == nil) {
        _text = [UILabel new];
        _text.backgroundColor = [UIColor clearColor];
        _text.font = [UIFont systemFontOfSize:16.0];
        _text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _text;
}

-(UIImageView *)image
{
    if (_image == nil) {
        _image = [UIImageView new];
    }
    return _image;
}

@end
