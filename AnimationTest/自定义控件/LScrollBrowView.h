//
//  LScrollBrowView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/27.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LScrollBrowCell.h"

@protocol LScrollBrowViewDelegate <NSObject>

@required

//默认显示几个
- (NSInteger ) LScrollBrowViewDefaultShowCount;
// 共显示 几项
- (NSInteger) LScrollBrowViewDataSourceCount;

//每页的内容
- (LScrollBrowCell *) LScrollBrowViewCellView:(NSInteger) index;

@optional

//即将显示
- (void) LScrollBrowViewWillShowSubView:(LScrollBrowCell *) currentShowView;

//当前选中的页面
- (void) LScrollBrowViewOnclickedSubView:(LScrollBrowCell *)currentSelect;

@end



@interface LScrollBrowView : UIView
@property (nonatomic, strong,readonly) LScrollBrowCell * foraroundView;
@property (nonatomic, strong) NSArray * allScrollContents;

@property (nonatomic, weak) id <LScrollBrowViewDelegate> delegate;
@end

@interface UIView (MyRectTool)
- (CGFloat) centerY;
- (CGFloat) centerX;
- (CGFloat) boundsHeightHelf;
- (CGFloat) boundsWidthHelf;
@end