//
//  AuthorizationVC.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/20.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "AuthorizationVC.h"
#import "LToolClass.h"


@implementation AuthorizationVC{
    CAShapeLayer *shape;
    CALayer * layer;
    LToolClass * lTool;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    shape = [CAShapeLayer layer];
    shape.fillColor = [UIColor cyanColor].CGColor;
    shape.transform = CATransform3DMakeScale(0.0001, 0.0001, 0.0001);
    [self.view.layer insertSublayer:shape atIndex:0];
    
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.cornerRadius = self.view.frame.size.height / 2;

    lTool =  [[LToolClass alloc] init] ;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}
- (IBAction)authorization {
    
    [lTool showInView:self.view WithLoop:YES];

    
    [CATransaction begin];

    
    // Reset
    [shape removeAnimationForKey:@"scaleDown"];
    [shape removeAnimationForKey:@"borderDown"];
    layer.borderWidth = 0;
    
    CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
                                                  fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
                                                    toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                                                     timing:kCAMediaTimingFunctionEaseIn];
    [shape addAnimation:scaleAnimation forKey:@"scaleUp"];
    
    CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@0 toValue:@1 timing:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:borderAnimation forKey:@"borderUp"];
    
    //        [self animateElementsFrom:self.animationElementsOn];
    [CATransaction commit];

//    
//    layer.borderWidth = 0;
//    
//    CABasicAnimation *scaleAnimation = [self animateKeyPath:@"transform.scale"
//                                                  fromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0001, 0.0001, 0.0001)]
//                                                    toValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
//                                                     timing:kCAMediaTimingFunctionEaseIn];
//    [shape addAnimation:scaleAnimation forKey:@"scaleUp"];
//    
//    CABasicAnimation *borderAnimation = [self animateKeyPath:@"borderWidth" fromValue:@0 toValue:@1 timing:kCAMediaTimingFunctionEaseIn];
//    [layer addAnimation:borderAnimation forKey:@"borderUp"];
    
    
//    UIImageView * avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 50, 50)];
//    UIImage *downloadedImage = [UIImage imageNamed:@""];
//    
//    [avatarImageView performSelector:@selector(setImage:)
//                          withObject:downloadedImage
//                          afterDelay:0
//                             inModes:@[NSDefaultRunLoopMode]];
    
    
    
//    NSURLRequest * req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?keyid=4&redirect_uri=http%3A%2F%2Fsapiv2.www.social-touch.com%2Foauth2%2Freturn_code%2F%3Fkeyid%3D4%26redirect_uri%3D3igzzx&response_type=code&forcelogin=true&client_id=3771231347&scope=email%2Cdirect_messages_write%2Cdirect_messages_read%2Cinvitation_write%2Cfriendships_groups_read%2Cfriendships_groups_write%2Cstatuses_to_me_read%2Cfollow_app_official_microblog"]];
//    [_myWebView loadRequest:req];
}
- (CABasicAnimation *)animateKeyPath:(NSString *)keyPath fromValue:(id)from toValue:(id)to timing:(NSString *)timing
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = from;
    animation.toValue = to;
    animation.repeatCount = 1;
    animation.timingFunction =  [CAMediaTimingFunction functionWithControlPoints:.5 :.5 :.5 :.5 ];// [CAMediaTimingFunction functionWithName:timing];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.35f;
    return animation;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   // NSURL
    
    /*
     
     @property (readonly, copy) NSString *absoluteString;
     @property (readonly, copy) NSString *relativeString; // The relative portion of a URL.  If baseURL is nil, or if the receiver is itself absolute, this is the same as absoluteString
     @property (readonly, copy) NSURL *baseURL; // may be nil.
     @property (readonly, copy) NSURL *absoluteURL; // if the receiver is itself absolute, this will return self.
     

    @property (readonly, copy) NSString *scheme;
    @property (readonly, copy) NSString *resourceSpecifier;
    
    @property (readonly, copy) NSString *host;
    @property (readonly, copy) NSNumber *port;
    @property (readonly, copy) NSString *user;
    @property (readonly, copy) NSString *password;
    @property (readonly, copy) NSString *path;
    @property (readonly, copy) NSString *fragment;
    @property (readonly, copy) NSString *parameterString;
    @property (readonly, copy) NSString *query;
    @property (readonly, copy) NSString *relativePath;
    
     */
    NSString *absoluteString = request.URL.absoluteString;
    NSString *relativeString = request.URL.relativeString;
    NSString *scheme = request.URL.scheme;
    NSString *resourceSpecifier = request.URL.resourceSpecifier;
    NSString *host = request.URL.host;
    NSString *parameterString = request.URL.parameterString;
    NSString *relativePath = request.URL.relativePath;
   
    NSLog(@"absoluteString %@ \n relativeString %@ \n scheme %@\n resourceSpecifier %@ \n host %@ \n parameterString %@ \n relativePath %@\n\n\n\n\n\n\n",absoluteString,relativeString,scheme,resourceSpecifier,host,parameterString,relativePath);
    
    if ([relativeString rangeOfString:@"http://sapiv2.www.social-touch.com/oauth2/return_code"].location != NSNotFound) {
        
        
        NSString * code = [relativeString substringFromIndex:[relativeString rangeOfString:@"&code="].length + [relativeString rangeOfString:@"&code="].location];
        NSLog(@"got code  %@",code);
        return NO;
    }
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

//    NSLog(@"loading error %@",error);
}

@end
