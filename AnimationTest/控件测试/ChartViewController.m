//
//  ChartViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/24.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ChartViewController.h"
#import "CBChartView.h"
#import "LCalculationTool.h"

@implementation ChartViewController{
//    MyChartView * chartView;
    CBChartView *chartView;
}



- (void)viewDidLoad{

    [super viewDidLoad];
    
//    chartView = [[MyChartView alloc] initWithFrame:CGRectMake(0, 64, [LCalculationTool getWidthReferTo:320 useScale:1] , 200)];
//    [self.view addSubview:chartView];
//    chartView.backgroundColor = [UIColor cyanColor];
//    
//    __weak typeof(self) weakSelf = self;
//    chartView.chartInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    chartView.dataSource = ^(){
//        return [weakSelf getSource];
//    };
//    
//    chartView.broadSource = ^(){
//        return [NSArray arrayWithObjects:@"1号",@"2号",@"3号",@"4号",@"5号",@"6号",@"7号", nil];
//    };
//    
//    chartView.portraitSource = ^(){
//        return [NSArray arrayWithObjects:@"0",@"200", nil];
//    };
    

//    self.chartView = chartView;
    [self performSelector:@selector(afterMethod) withObject:nil afterDelay:2];
}


- (void) afterMethod{
    chartView = [[CBChartView alloc] initWithFrame:CGRectMake(30, 64, [UIScreen mainScreen].bounds.size.width - 60, ([UIScreen mainScreen].bounds.size.width - 60) * .4)];
    [self.view addSubview:chartView];
    chartView.chartColor = [UIColor greenColor];
    
    chartView.xValues = @[@"2",@"3", @"4", @"5", @"6", @"7"];
    chartView.yValues = [self getSource];
    chartView.other = @[@"3",@"4",@"6",@"1",@"7",@"101",];
}

- (NSArray *) getSource{
    
    return [NSArray arrayWithObjects:@"30",@"60",@"20",@"0",@"70",@"80", nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [chartView refreshData];
//    });
}

@end
