//
//  HomePageView.h
//  AnimationTest
//
//  Created by lengbinbin on 15/2/3.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageView : UIView

@property (assign) CGFloat percentred;
@property (assign) CGFloat percentgreen;
@property (assign) CGFloat percentblue;
@property (assign) CGFloat percentpurple;

@property (assign) CGFloat oldpercentred;
@property (assign) CGFloat oldpercentgreen;
@property (assign) CGFloat oldpercentblue;
@property (assign) CGFloat oldpercentpurple;

- (void) updateRed:(CGFloat)numberRed andGren:(CGFloat)numbergreen andBlue:(CGFloat)numberblue andPurple:(CGFloat)numberPurple;

- (void) drawAction;

@end
