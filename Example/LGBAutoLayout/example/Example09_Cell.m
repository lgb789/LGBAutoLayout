//
//  Example09_Cell.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/27.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example09_Cell.h"
#import "Example09_Model.h"

@interface Example09_Cell ()
@property (nonatomic, strong) UILabel *text;
@property (nonatomic, strong) UIImageView *photo;

@end

@implementation Example09_Cell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************

- (void)dealloc
{
//    DLog(@"dealloc");
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.text];
        [self.contentView addSubview:self.photo];
        
        self.contentView.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .bottomEqualToViewArrayWithOffset(@[self.text, self.photo], 10);
        
        self.text.auto_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 10)
        .widthEqualToViewWithRatio(self.contentView, 0.7)
        .maxHeightIs(0);
        
        self.photo.auto_layout
        .topEqualToViewWithOffset(self.text, 0)
        .leftSpaceToView(self.text, 10)
        .rightSpaceToView(self.contentView, 10);
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
    
    UIImage *img = [UIImage imageNamed:model.photo];
    self.photo.image = img;
    
    self.photo.auto_layout
    .heightEqualToWidthWithRatio(img.size.height / img.size.width);
    
//    self.contentView.auto_layout
//    .bottomEqualToViewWithOffset(self.photo, 10);
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

-(UIImageView *)photo
{
    if (_photo == nil) {
        _photo = [UIImageView new];
    }
    return _photo;
}

@end
