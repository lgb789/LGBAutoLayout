//
//  TableView.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/21.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "TableView.h"
#import "Example04_cell.h"
#import "LGBRefresh.h"
#import "UITableView+lgb_autoCellHeight.h"

@interface TableView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger rows;
@end

@implementation TableView

#pragma mark - *********************** public methods ***********************
-(void)configData:(NSArray *)data
{
    self.dataArray = data;
    self.rows = self.dataArray.count;
    [self.table reloadData];
}

#pragma mark - *********************** overwrite methods ***********************

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        [self addSubview:self.table];
        
        self.table.auto_layout
        .topSpaceToView(self, 0)
        .leftSpaceToView(self, 0)
        .widthEqualToViewWithRatio(self, 1)
        .heightEqualToViewWithRatio(self, 1);
        
        __weak typeof(self) weakSelf = self;
        [self.table lgb_addHeaderRefreshView:[HeaderRefreshView new] action:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.rows += 10;
                [weakSelf.table reloadData];
                [weakSelf.table lgb_endHeaderRefresh];
            });
        }];
        
        [self.table lgb_addFooterRefreshView:[FooterRefreshView new] action:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.rows += 10;
                [weakSelf.table reloadData];
                [weakSelf.table lgb_endFooterRefresh];
            });
        }];
        
//        self.dataArray = @[
//                           @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
//                           @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
//                           @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
//                           @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
//                           @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
//                           
//                           ];
//        
//        self.rows = 5;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    DLog(@"table frame:%@,%@", NSStringFromCGRect(self.frame), NSStringFromCGRect(self.table.frame));
}

#pragma mark - *********************** delegate ***********************

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *str = [self.dataArray objectAtIndex:indexPath.row % self.dataArray.count];
    return [tableView lgb_cellHeightWithCellClass:[Example04_cell class] data:[self.dataArray objectAtIndex:indexPath.row % self.dataArray.count] indexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    Example04_cell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[Example04_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str = [self.dataArray objectAtIndex:indexPath.row % self.dataArray.count];
    
    [cell tableViewCellConfigWithData:str];
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

#pragma mark - *********************** getters and setters ***********************
-(UITableView *)table
{
    if (_table == nil) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end
