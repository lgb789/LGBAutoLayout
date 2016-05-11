//
//  UITableView+lgb_autoCellHeight.h
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewCellAutolayoutDelegate <NSObject>

-(void)tableViewCellConfigWithData:(id)data;

@end

@interface UITableView (lgb_autoCellHeight)

-(CGFloat)lgb_cellHeightWithCellClass:(Class<TableViewCellAutolayoutDelegate>)cellClass
                                 data:(id)data
                            indexPath:(NSIndexPath *)indexPath;

-(void)lgb_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end
