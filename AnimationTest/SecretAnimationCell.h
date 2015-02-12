//
//  SecretAnimationCell.h
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StatusChange)(BOOL status);

@interface SecretAnimationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (nonatomic,copy) StatusChange change;
@property (weak, nonatomic) IBOutlet UILabel *heart;
@property (weak, nonatomic) IBOutlet UIView *actionView;

@property  (assign) CGPoint heartStart;
@property (assign) CGPoint actionStart;


@property (assign) CGPoint touchStartPoint;

@end
