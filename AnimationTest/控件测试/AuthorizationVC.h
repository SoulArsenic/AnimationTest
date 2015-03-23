//
//  AuthorizationVC.h
//  AnimationTest
//
//  Created by lengbinbin on 15/3/20.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthorizationVC : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@end
