//
//  Example07.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/25.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example07.h"
#import "LGBCycleScrollView.h"
#import "Example07_Model.h"
#import "Example07_Cell.h"
#import "LGBRefresh.h"
#import "UITableView+lgb_autoCellHeight.h"
#import "Example07_ScrollCell.h"

@interface Example07 () <UITableViewDelegate, UITableViewDataSource, LGBCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LGBCycleScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation Example07

#pragma mark - *********************** life cycle ***********************

-(void)loadView
{
    [super loadView];
    /* set navigation bar, self.view */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /* add subviews */
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView lgb_addFooterRefreshView:[FooterRefreshView new] action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:[weakSelf createDataCount:100]];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView lgb_endFooterRefresh];
        });
        
    }];
    
    [self setupHeaderView];
    
    [self layoutSubviews];
    
    [self.scrollView configItemsWithData:@[
                                           @"pic1.jpg",
                                           @"pic2.jpg",
                                           @"pic3.jpg",
                                           @"pic4.jpg",
                                           ]];
    
    [self.dataArray addObjectsFromArray:[self createDataCount:5]];
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
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView lgb_cellHeightWithCellClass:[Example07_Cell class] data:self.dataArray[indexPath.row] indexPath:indexPath];
//    return [tableView auto_cellHeightAtIndexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"identify";
    Example07_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[Example07_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
//    [cell configCellWithData:self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Example07_Cell *c = (Example07_Cell *)cell;
    [c tableViewCellConfigWithData:self.dataArray[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - LGBCycleScrollViewDelegate
-(void)cycleScrollView:(LGBCycleScrollView *)scrollView didSelectItem:(NSInteger)item
{
    DLog(@"tap item---->%ld", item);
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

-(void)setupHeaderView
{
    UIView *header = [UIView new];
    
    header.backgroundColor = [UIColor whiteColor];
    
    [header addSubview:self.scrollView];
    
    UILabel *updateLabel = [UILabel new];
    updateLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    updateLabel.backgroundColor = [UIColor clearColor];
    updateLabel.text = @"更新时间: 2016.04.26";
    updateLabel.font = [UIFont systemFontOfSize:13.0];
    [header addSubview:updateLabel];
    
    UIView *line = [UIView new];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [header addSubview:line];
    
    
    self.scrollView.auto_layout
    .topSpaceToView(header, 0)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(150);
    
    updateLabel.auto_layout
    .topSpaceToView(self.scrollView, 10)
    .leftSpaceToView(header, 10)
    .rightSpaceToView(header, 0)
    .maxHeightIs(0);
    
    line.auto_layout
    .topSpaceToView(updateLabel, 10)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(1);
    
    //设置header的高度
    [header lgb_setHeightEqualToViewBottom:line withOffset:0];
    
    self.tableView.tableHeaderView = header;
}

-(NSArray *)createDataCount:(NSInteger)count
{
    NSArray *names = @[
                       @"name_01",
                       @"name_02",
                       @"name_03",
                       @"name_04",
                       ];
    NSArray *texts = @[
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
                       @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
                       
                       ];
    NSArray *icons = @[
                       @"icon0.jpg",
                       @"icon1.jpg",
                       @"icon2.jpg",
                       @"icon3.jpg",
                       @"icon4.jpg",
                       ];
    
    NSArray *images = @[
                        @"pic0.jpg",
                        @"pic1.jpg",
                        @"pic2.jpg",
                        @"pic3.jpg",
                        @"pic4.jpg",
                        ];
    
    NSMutableArray *data = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        int nameIndex = arc4random_uniform((int)names.count);
        int iconIndex = arc4random_uniform((int)icons.count);
        int textIndex = arc4random_uniform((int)texts.count);
        int imageIndex = arc4random_uniform((int)images.count);
        Example07_Model *model = [Example07_Model new];
        model.name = names[nameIndex];
        model.photo = icons[iconIndex];
        model.text = texts[textIndex];
        if (arc4random_uniform(100) < 80) {
            model.image = images[imageIndex];
        }
        
        [data addObject:model];
    }
    return data;
}

-(CGFloat)contentWidth
{
    return CGRectGetWidth(self.tableView.bounds);
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

-(LGBCycleScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [LGBCycleScrollView new];
        [_scrollView registerCellClass:[Example07_ScrollCell class]];
        [_scrollView setCycleScrollPageControl:[LGBCycleScrollViewPageControl new]];
        _scrollView.cycleScrollDelegate = self;
    }
    return _scrollView;
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
