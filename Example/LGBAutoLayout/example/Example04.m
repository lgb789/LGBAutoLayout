//
//  Example04.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/20.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example04.h"
#import "Example04_cell.h"
#import "LGBRefresh.h"
#import "UITableView+lgb_autoCellHeight.h"

#define Identifier    @"identify"

@interface Example04 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger rows;
@end

@implementation Example04

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
#if 1
    self.dataArray = @[
                       
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
                       @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
                       
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
                       ];
#else
    self.dataArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                       @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                       @"当你的 app 没有提供 3x 的 LaunchImage 时",
                       @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                       @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下，"
                       ];
#endif
    self.rows = 6;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.tableView];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    __weak typeof(self) weakSelf = self;
//    [self.tableView lgb_addFooterRefreshViewClass:[FooterRefreshView class] action:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            weakSelf.rows += 1;
//            [weakSelf.tableView reloadData];
//            [weakSelf.tableView lgb_endFooterRefresh];
//        });
//        
//    }];
    
    [self.tableView lgb_addInfiniteRefreshView:[InfiniteRefreshView new] action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rows += 100;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView lgb_endInfiniteRefresh];
        });
    }];
    
    [self.tableView lgb_addHeaderRefreshView:[HeaderRefreshView new] action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.rows += 100;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView lgb_endHeaderRefresh];
        });
    }];

    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /* add notificatioin */
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    /* remove notificatioin */
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
//    DLog(@"index---->%ld,%f,%@", indexPath.row,[self tableViewContentWidth],[tableView visibleCells]);

    return [tableView lgb_cellHeightWithCellClass:[Example04_cell class] data:self.dataArray[indexPath.row % self.dataArray.count] indexPath:indexPath];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Example04_cell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
//        DLog(@"create cell");
        cell = [[Example04_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *text = self.dataArray[indexPath.row % self.dataArray.count];
    [cell tableViewCellConfigWithData:text];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    self.tableView.auto_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .widthEqualToViewWithRatio(self.view, 1)
    .heightEqualToViewWithRatio(self.view, 1);
}

-(CGFloat)tableViewContentWidth
{
    return CGRectGetWidth(self.view.bounds);
}

#pragma mark - *********************** getters and setters ***********************
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
