//
//  Example10.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/28.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example10.h"
#import "Example10_Cell.h"
#import "Example10_Model.h"
#import "UITableView+lgb_autoCellHeight.h"
#import "LGBRefresh.h"

@interface Example10 () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation Example10

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

    [self layoutSubviews];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView lgb_addInfiniteRefreshView:[InfiniteRefreshView new] action:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.data addObjectsFromArray:[weakSelf createDateCount:100]];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView lgb_endInfiniteRefresh];
        });
    }];
    
    [self.data addObjectsFromArray:[self createDateCount:10]];
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
    return [tableView lgb_cellHeightWithCellClass:[Example10_Cell class] data:self.data[indexPath.row] indexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Example10_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Example10_Cell class])];
    if (cell == nil) {
        cell = [[Example10_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([Example10_Cell class])];
    }
    cell.indexPath = indexPath;
    
    __weak typeof(self) weakSelf = self;
    if (cell.moreButtonHandler == nil) {
        cell.moreButtonHandler = ^(NSIndexPath *indexPath){
//            DLog(@"more.....:%ld", indexPath.row);
            Example10_Model *model = weakSelf.data[indexPath.row];
            model.isMore = !model.isMore;
            
            [tableView lgb_reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Example10_Cell *c = (Example10_Cell *)cell;
    [c tableViewCellConfigWithData:self.data[indexPath.row]];
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
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

-(NSArray *)createDateCount:(NSInteger)count
{
    NSArray *icons = @[
                       @"icon0.jpg",
                       @"icon1.jpg",
                       @"icon2.jpg",
                       @"icon3.jpg",
                       @"icon4.jpg",
                       ];
    
    NSArray *names = @[
                       @"name1",
                       @"name2",
                       @"name3",
                       @"name4",
                       @"name5",
                       ];
    
    NSArray *texts = @[
                       
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。",
                       @"在iOS设备中使用BLE时，无论是将其作为central端还是peripheral端，其在通信时都会使用设备自身的无线电来发送信号。Core",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。",
                       @"考虑到其它形式的无线通信也需要使用无线电，因此开发程序时应该尽量少使用无线电。另外，这对于设备电池的寿命及程序的性能也有所帮助。以此为出发点，我们将介绍一些使用BLE时的最佳实践，希望有所帮助。",
                       
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。下面我们将介绍一些Central端的最佳实践。",
                       @"Core Bluetooth框架让程序的大部分Central端交互变得透明。即程序能够控制且有责任实现大部分Central端的操作，如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。如设备搜索及连接，解析并与远程peripheral数据交互。",
                       ];
    
    NSArray *imgs = @[
                      @"pic0.jpg",
                      @"pic1.jpg",
                      @"pic2.jpg",
                      @"pic3.jpg",
                      @"pic4.jpg",
                      ];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        int iconIndex = arc4random_uniform((int)icons.count);
        int nameIndex = arc4random_uniform((int)names.count);
        int textIndex = arc4random_uniform((int)texts.count);
        

        Example10_Model *model = [Example10_Model new];
        model.photo = icons[iconIndex];
        model.name = names[nameIndex];
        model.text = texts[textIndex];
//        model.image = imgs[imgIndex];
        int count = arc4random_uniform(10);
        if (i % 2 == 0) {
//            count = 1;
        }else{
//            count = 1;
        }
//        count = 5;
        NSMutableArray *imgArray = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            int imgIndex = arc4random_uniform((int)imgs.count);
            [imgArray addObject:imgs[imgIndex]];
        }
//        DLog(@"count --> %d", count);
        model.images = imgArray;// @[@"pic1.jpg",@"pic2.jpg",@"pic3.jpg"];
        
        model.time = @"1分钟前";
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
