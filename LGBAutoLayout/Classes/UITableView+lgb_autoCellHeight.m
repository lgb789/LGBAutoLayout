//
//  UITableView+lgb_autoCellHeight.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/29.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "UITableView+lgb_autoCellHeight.h"
#import <objc/runtime.h>
#import "UIView+lgb_autoLayout.h"

#define ContentWidth  @"ContentWidth"

@implementation UITableView (lgb_autoCellHeight)

-(void)lgb_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    if (![self isKindOfClass:[UITableView class]]) {
        return ;
    }
    UITableView *table = (UITableView *)self;
    NSMutableDictionary *dic = [self cellHeightDictionary];
    if (dic) {
        
        for (NSIndexPath *index in indexPaths) {
            NSString *heightKey = [NSString stringWithFormat:@"%ld%ld", (long)index.section, (long)index.row];
            [dic removeObjectForKey:heightKey];
        }
    }
    [table reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

-(CGFloat)lgb_cellHeightWithCellClass:(Class<TableViewCellAutolayoutDelegate>)cellClass
                                 data:(id)data
                            indexPath:(NSIndexPath *)indexPath
{
    UITableView *table = (UITableView *)self;
    NSString *heightKey = [NSString stringWithFormat:@"%ld%ld", (long)indexPath.section, (long)indexPath.row];
    NSString *identify = [@"lgb_" stringByAppendingString:NSStringFromClass(cellClass)];
    
    UITableViewCell<TableViewCellAutolayoutDelegate> *cell = [table dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        [table registerClass:cellClass forCellReuseIdentifier:identify];
        cell = [table dequeueReusableCellWithIdentifier:identify];
    }
    
    CGFloat contentWidth = table.width;
    
    NSMutableDictionary *dic = [self cellHeightDictionary];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
        [self setCellHeightDictionary:dic];
    }
    CGFloat width = 0;
    NSNumber *widthNumber = [dic objectForKey:ContentWidth];
    if (widthNumber) {
        width = [widthNumber floatValue];
    }
    
    if (width != contentWidth) {
        cell.width = contentWidth;
        [dic removeAllObjects];
        [dic setObject:@(contentWidth) forKey:ContentWidth];
        
    }else{
        if (cell.width != contentWidth) {
            cell.width = contentWidth;
        }
        
        NSNumber *number = [dic objectForKey:heightKey];
        if (number) {

            return [number floatValue];
            
        }
    }
    
    [cell tableViewCellConfigWithData:data];
    
    CGFloat cellHeight = [self lgb_heightFromView:cell.contentView];
    
    [dic setObject:@(cellHeight) forKey:heightKey];
    
    
    return cellHeight;
}

#pragma mark - *********************** getters and setters ***********************

-(NSMutableDictionary *)cellHeightDictionary
{
    NSMutableDictionary *dic = objc_getAssociatedObject(self, _cmd);
  
    return dic;
}

-(void)setCellHeightDictionary:(NSMutableDictionary *)dic
{
    objc_setAssociatedObject(self, @selector(cellHeightDictionary), dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
