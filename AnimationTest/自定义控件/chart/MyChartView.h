//
//  MyChartView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/3/24.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSArray * (^ChartDataSource)();
typedef NSArray * (^ChartBroadwiseArgs)();
typedef NSArray * (^ChartPortraitArgs)();

@interface MyChartView : UIView

@property (assign) BOOL useAnimated;

@property (assign) UIEdgeInsets chartInsets;

@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) NSArray * broadArray;
@property (nonatomic, strong) NSArray * portraitArray;

@property (nonatomic, copy) ChartDataSource     dataSource;//数据源
@property (nonatomic, copy) ChartBroadwiseArgs  broadSource;//水平方向 
@property (nonatomic, copy) ChartPortraitArgs   portraitSource;//竖直方向 最大最小两个值



- (void) refreshData;//刷新， 更新UI

@end
