//
//  GraphicsView.h
//  AnimationTest
//
//  Created by admin on 15-1-23.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphicsView : UIView
@property (nonatomic) float radious ;

@property (nonatomic) CGPoint start ;
@property (nonatomic) CGPoint end;
@property (nonatomic) BOOL outOfBounds;
 @end
