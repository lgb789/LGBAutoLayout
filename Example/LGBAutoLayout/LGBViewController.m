//
//  LGBViewController.m
//  LGBAutoLayout
//
//  Created by lgb789 on 05/10/2016.
//  Copyright (c) 2016 lgb789. All rights reserved.
//

#import "LGBViewController.h"
#import "LGBExampleCell.h"

#import "Example01.h"
#import "Example02.h"
#import "Example03.h"
#import "Example04.h"
#import "Example05.h"
#import "Example06.h"
#import "Example07.h"
#import "Example08.h"
#import "Example09.h"
#import "Example10.h"

@interface LGBViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LGBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    self.tableView.auto_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .widthEqualToViewWithRatio(self.view, 1)
    .heightEqualToViewWithRatio(self.view, 1);
    
    self.dataArray = @[
                       @[@"Example01", @"在timer中改变view的布局约束条件"],
                       @[@"Example02", @"根据label内容自动调节其高度，及其底部view的位置"],
                       @[@"Example03", @"3个宽度相等的subview"],
                       @[@"Example04", @"自动计算tableview cell的高度"],
                       @[@"Example05", @"延时tableview加载数据，其他与Example04一样"],
                       @[@"Example06", @"简单自动布局使用"],
                       @[@"Example07", @"1.计算tableHeaderView的高度。\n2.tableview cell的图文混排"],
                       @[@"Example08", @"自动计算scrollview的content height"],
                       @[@"Example09", @"注册2个cell的图片混排"],
                       @[@"Example10", @"仿微信朋友圈，未完成。。。"]
                       
                       ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理

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
    return [tableView lgb_cellHeightWithCellClass:[LGBExampleCell class] data:self.dataArray[indexPath.row] indexPath:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell == nil) {
        cell = [[LGBExampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGBExampleCell *c = (LGBExampleCell *)cell;
    [c tableViewCellConfigWithData:self.dataArray[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.dataArray[indexPath.row][0];
    Class example = NSClassFromString(name);
    UIViewController *controller = [example new];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
}

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
