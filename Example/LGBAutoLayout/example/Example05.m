//
//  Example05.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/21.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example05.h"
#import "TableView.h"

@interface Example05 ()
@property (nonatomic, strong) TableView *tableView;
@end

@implementation Example05

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.tableView];

    [self layoutSubviews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchData];
    });
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

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(void)layoutSubviews
{
    self.tableView.auto_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

-(void)fetchData
{
    NSArray *array = @[
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
                       @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
                       
                       ];
    
    [self.tableView configData:array];
}

#pragma mark - *********************** getters and setters ***********************
-(TableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [TableView new];
    }
    return _tableView;
}

@end
