//
//  LogInViewController.h
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HandleComplete)() ;

@interface LogInViewController : UIViewController

@property (nonatomic, copy) void (^callDoSomeThing)(LogInViewController *,NSString *,NSString *);

- (void) methodLoginSucess;
- (void) methodLoginFaild;

@end
