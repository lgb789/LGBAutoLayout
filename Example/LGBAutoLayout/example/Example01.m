//
//  ViewController.m
//  TTLayoutMethods
//
//  Created by lgb789 on 16/4/1.
//  Copyright © 2016年 com.lgb. All rights reserved.
//

#import "Example01.h"
#import "TTView.h"


@interface Example01 ()
@property (nonatomic, strong) TTView *ttView;
@property (nonatomic, assign) CGFloat heightRatio;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation Example01

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.ttView];
    [self layoutSubviewssss];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(viewAnimation) userInfo:nil repeats:YES];
        [self.timer fire];
    });
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(self.timer){
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    DLog(@"dealloc");
}

#pragma mark - *********************** private method ***********************
-(void)layoutSubviewssss
{
    self.heightRatio = 0.4;
    self.ttView.auto_layout
    .widthEqualToViewWithRatio(self.view, 0.4)
    .heightEqualToViewWithRatio(self.view, self.heightRatio)
    .topEqualToViewWithOffset(self.view, 80)
    .leftEqualToViewWithOffset(self.view, 10);

//    NSLog(@"tt view:%@", NSStringFromCGRect(self.ttView.frame));
}

-(void)viewAnimation
{
    if (self.heightRatio == 0.4) {
        self.heightRatio = 0.0;
    }else{
        self.heightRatio = 0.4;
    }
    
    self.ttView.auto_layout
    .heightEqualToViewWithRatio(self.view, self.heightRatio);
    
    [UIView animateWithDuration:1 animations:^{
        [self.ttView.auto_layout updateLayout];
    }];
}

#pragma mark - *********************** getters ***********************
-(TTView *)ttView
{
    if (_ttView == nil) {
        _ttView = [TTView new];
    }
    return _ttView;
}

@end
