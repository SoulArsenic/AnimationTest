//
//  HomePageViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/3.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageView.h"
@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet HomePageView *drawView;

@end

@implementation HomePageViewController




- (IBAction)redChange:(UISlider *)sender {
    [self.drawView updateRed:sender.value andGren:0 andBlue:0 andPurple:0];
}

- (IBAction)greenChange:(UISlider *)sender {
    [self.drawView updateRed:0 andGren:sender.value andBlue:0 andPurple:0];
}

- (IBAction)blueChange:(UISlider *)sender {
    
    [self.drawView updateRed:0 andGren:0 andBlue:sender.value andPurple:0];
}

- (IBAction)purpleChange:(UISlider *)sender {

    [self.drawView updateRed:0 andGren:0 andBlue:0 andPurple:sender.value];
}

- (IBAction)action:(id)sender {
    [self.drawView drawAction];
}



@end
