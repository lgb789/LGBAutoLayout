//
//  Example10_Cell.h
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/28.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+lgb_autoCellHeight.h"

typedef void(^MorebuttonHandler)(NSIndexPath *indexPath);

@interface Example10_Cell : UITableViewCell <TableViewCellAutolayoutDelegate>

@property (nonatomic, copy) MorebuttonHandler moreButtonHandler;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
