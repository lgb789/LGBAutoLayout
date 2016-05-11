//
//  LGBPhotoCell.m
//  LGBPhotoBrowser
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "LGBPhotoCell.h"

@interface LGBPhotoCell ()

@end

@implementation LGBPhotoCell

#pragma mark - *********************** public methods ***********************

#pragma mark - *********************** overwrite methods ***********************
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
    self.imageView.frame = self.contentView.bounds;
}

#pragma mark - *********************** delegate ***********************
-(void)photoCellConfigWithData:(id)data
{
//    DLog(@"data--->%@", data);
//    if (data == nil) {
//        return;
//    }
//    
    self.imageView.image = [UIImage imageNamed:data];
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _imageView;
}

@end
