//
//  ImageLoadingTest.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/12.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ImageLoadingTest.h"

#import <UIImageView+Haneke.h>
#import "LAdaptiveImageView.h"
#import <UIImageView+UIImageView_FaceAwareFill.h>

@implementation ImageLoadingTest
- (IBAction)Loading {
    self.bigView.image = nil;
    self.smallView.image = nil;
    
    
    [self startLoading];
    
}
//http://cdn.duitang.com/uploads/item/201302/06/20130206155416_JCNJC.jpeg

- (void) startLoading{
    NSLog(@"time start %@",    NSHomeDirectory());

   __unused NSString * twtterImage = @"https://pbs.twimg.com/media/B_zCUMgWwAASVOr.jpg";
   __unused NSString * url1 = @"http://img2.duitang.com/uploads/item/201209/17/20120917202434_cjvNR.jpeg";
   __unused NSString * url2 = @"http://cdn.duitang.com/uploads/item/201302/06/20130206155416_JCNJC.jpeg";
   __unused NSString * qiniu = @"";
    
//    self.bigView.contentMode = UIViewContentModeScaleAspectFit ;
    
    [self.bigView hnk_setImageFromURL:[NSURL URLWithString:url1] placeholder:nil success:^(UIImage *image) {
        self.bigView.image = image;

//        [self.bigView faceAwareFill];

        
    } failure:^(NSError *error) {
        
    }];
//    LAdaptiveImageView * a = [[LAdaptiveImageView alloc] initWithImage:[UIImage imageNamed:@"level"]];
//    a.frame = CGRectMake(0, 100, 100, 100);
//    a.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:a];
}

@end
