//
//  SecretAnimationCell.h
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALDBlurImageProcessor.h"

typedef void(^StatusChange)(BOOL status);

@interface SecretAnimationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bg;
@property (nonatomic,copy) StatusChange change;

@property (weak, nonatomic) IBOutlet UIImageView *heart;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *fuzzyView;
@property (strong, nonatomic) ALDBlurImageProcessor *processor;

@property (assign) CGSize heartSize;
@property (assign) CGPoint touchStartPoint;
@property (assign) CGPoint actionTempCenter;
@property (assign) BOOL inUseactionView;

@property (assign) BOOL panInUseHeart;

- (void) touchGesture:(UIPanGestureRecognizer *) recognizer;

- (void) resetUI;
- (void) sendActionViewBack;
- (BOOL) actionCenter;
@end
