//
//  Example10_Model.h
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/28.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Example10_Model : NSObject
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) BOOL showMore;
@property (nonatomic, assign) BOOL isMore;
@end
