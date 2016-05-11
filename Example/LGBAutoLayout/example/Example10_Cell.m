//
//  Example10_Cell.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/28.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example10_Cell.h"
#import "Example10_Model.h"
#import "LGBPhotoView.h"

@interface Example10_Cell ()
@property (nonatomic, strong) UIImageView *photo;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) LGBPhotoView *photoView;
@end

@implementation Example10_Cell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.photo];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.moreButton];
//        [self.contentView addSubview:self.image];
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.actionButton];
        
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewArrayWithOffset(@[self.timeLabel, self.actionButton], 10);
//        .bottomEqualToViewWithOffset(self.photoView, 10);
        
        self.photo.auto_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .widthIs(40)
        .heightIs(40);
        
        self.name.auto_layout
        .topEqualToViewWithOffset(self.photo, 0)
        .leftSpaceToView(self.photo, 10)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(22);
        
        self.text.auto_layout
        .topSpaceToView(self.name, 5)
        .leftEqualToViewWithOffset(self.name, 0)
        .rightSpaceToView(self.contentView, 10);
        
        self.moreButton.auto_layout
        .topSpaceToView(self.text, 0)
        .leftEqualToViewWithOffset(self.text, -10)
        .widthIs(80);

        
//        self.image.auto_layout
//        .topSpaceToView(self.moreButton, 10)
//        .leftEqualToViewWithOffset(self.text, 0)
//        .widthEqualToViewWithRatio(self.text, 0.7);
        
        self.photoView.auto_layout
        .topSpaceToView(self.moreButton, 10)
        .leftSpaceToView(self.photo, 10);
        
        
        self.timeLabel.auto_layout
        .topSpaceToView(self.photoView, 10)
        .leftEqualToViewWithOffset(self.text, 0)
        .widthIs(150)
        .maxHeightIs(0);
        
        self.actionButton.auto_layout
        .rightSpaceToView(self.contentView, 10)
        .centerYEqualToViewWithOffset(self.timeLabel, 0)
        .widthIs(25)
        .heightIs(25);
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    DLog(@"layout.....");
}


#pragma mark - *********************** delegate ***********************
-(void)tableViewCellConfigWithData:(id)data
{
    Example10_Model *model = data;
    
    self.photo.image = [UIImage imageNamed:model.photo];
    self.name.text = model.name;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:model.text attributes:@{NSParagraphStyleAttributeName : style}];
    
    self.text.attributedText = str;
    
    CGSize size = [model.text sizeWithFont:self.text.font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, CGFLOAT_MAX)];
    
    CGFloat lineHeight = (self.text.font.lineHeight + style.lineSpacing) * 3 - style.lineSpacing;
    
    model.showMore = size.height > lineHeight ? YES : NO;
    
//    DLog(@"size line height -----> %@,%f,%d", NSStringFromCGSize(size), lineHeight, model.showMore);
    
    if (model.isMore) {
        [self.moreButton setTitle:@"收起" forState:UIControlStateNormal];
        self.text.auto_layout
        .maxHeightIs(0);
    }else{
        [self.moreButton setTitle:@"全文" forState:UIControlStateNormal];

        self.text.auto_layout
        .maxHeightIs(lineHeight);
    }

//    DLog(@"show more...:%d,%f,%f", model.showMore, size.height, lineHeight);
    if (model.showMore) {
        self.moreButton.auto_layout
        .heightIs(30);
        self.moreButton.hidden = NO;
    }else{
        self.moreButton.auto_layout
        .heightIs(0);
        self.moreButton.hidden = YES;
    }
    
    CGFloat photoViewHeight = [self.photoView setPhotos:model.images width:200];
//    DLog(@"photoview height-->%f,%ld", photoViewHeight, model.images.count);
    self.photoView.auto_layout
    .widthIs(200)
    .heightIs(photoViewHeight);
    
    self.timeLabel.text = model.time;

}

#pragma mark - *********************** event response ***********************
-(void)handleMore
{
    if (self.moreButtonHandler) {
        self.moreButtonHandler(self.indexPath);
    }
}

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
        _name.text = @"    ";
        _name.backgroundColor = [UIColor clearColor];
//        _name.font = [UIFont systemFontOfSize:14.0];
        _name.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    }
    return _name;
}

-(UILabel *)text
{
    if (_text == nil) {
        _text = [UILabel new];
        _text.numberOfLines = 0;
        _text.backgroundColor = [UIColor clearColor];

        _text.font = [UIFont systemFontOfSize:15.0];
    }
    return _text;
}

-(UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _moreButton.backgroundColor = [UIColor yellowColor];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_moreButton setTitleColor:[UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9] forState:UIControlStateNormal];
        _moreButton.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 20);
        [_moreButton addTarget:self action:@selector(handleMore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(UIImageView *)image
{
    if (_image == nil) {
        _image = [UIImageView new];
    }
    return _image;
}

-(UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
//        _timeLabel.backgroundColor = [UIColor yellowColor];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _timeLabel;
}

-(UIButton *)actionButton
{
    if (_actionButton == nil) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _actionButton.backgroundColor = [UIColor yellowColor];
//        [_actionButton setTitle:@"action" forState:UIControlStateNormal];
        [_actionButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_actionButton setTitleColor:[UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9] forState:UIControlStateNormal];
    }
    return _actionButton;
}

-(LGBPhotoView *)photoView
{
    if (_photoView == nil) {
        _photoView = [LGBPhotoView new];
    }
    return _photoView;
}

@end
