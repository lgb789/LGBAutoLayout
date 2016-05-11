//
//  Example09.m
//  TTLayoutMethods
//
//  Created by lgb on 16/4/26.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example09.h"
#import "Example09_Model.h"
#import "Example09_Cell.h"
#import "Example09_Cell2.h"
#import "LGBRefresh.h"
#import "UITableView+lgb_autoCellHeight.h"

@interface Example09 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation Example09

#pragma mark - *********************** life cycle ***********************

- (void)dealloc
{
    DLog(@"dealloc");
}

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.tableView];

    [self layoutSubviews];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView lgb_addInfiniteRefreshView:[InfiniteRefreshView new] action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.data addObjectsFromArray:[weakSelf createDataCount:10]];
            [weakSelf.tableView reloadData];
            
            [weakSelf.tableView lgb_endInfiniteRefresh];
        });
    }];
    
    [self.data addObjectsFromArray:[self createDataCount:30]];
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
    return self.data.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView lgb_cellHeightWithCellClass:[self cellClassAtIndexPath:indexPath] data:self.data[indexPath.row] indexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    Class class = [self cellClassAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (cell == nil) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(class)];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<TableViewCellAutolayoutDelegate> *c = (UITableViewCell<TableViewCellAutolayoutDelegate> *)cell;
    [c tableViewCellConfigWithData:self.data[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - *********************** event response ***********************

#pragma mark - *********************** private methods ***********************

-(Class)cellClassAtIndexPath:(NSIndexPath *)indexPath
{
    Example09_Model *model = self.data[indexPath.row];
    Class class = nil;
    if (model.photos) {
        class = [Example09_Cell2 class];
    }else{
        class = [Example09_Cell class];
    }
    return class;
}

-(void)layoutSubviews
{
    self.tableView.auto_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

-(NSArray *)createDataCount:(NSInteger)count
{
    NSArray *icons = @[
                       @"icon0.jpg",
                       @"icon1.jpg",
                       @"icon2.jpg",
                       @"icon3.jpg",
                       @"icon4.jpg",
                       @"pic0.jpg",
                       @"pic2.jpg",
                       ];
    NSArray *texts = @[
                       
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
                       @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
                       
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
                       ];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        int iconIndex1 = arc4random_uniform((int)icons.count);
        int iconIndex2 = arc4random_uniform((int)icons.count);
        int iconIndex3 = arc4random_uniform((int)icons.count);
        int textIndex = arc4random_uniform((int)texts.count);
        Example09_Model *model = [Example09_Model new];
        model.text = texts[textIndex];
        model.photo = icons[iconIndex1];
        if (arc4random_uniform(100) < 30) {
            model.photos = @[icons[iconIndex1],icons[iconIndex2],icons[iconIndex3]];
        }
        [array addObject:model];
    }
    return array;
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

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
