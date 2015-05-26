//
//  RootViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/25.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "RootViewController.h"
#import "LogInViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (IBAction)click:(id)sender {
    
    LogInViewController <UINavigationControllerDelegate> * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];

    vc.callDoSomeThing  = ^void(LogInViewController * aLogin, NSString * name ,NSString *pwd) {
//        [self doLoginWithName:name andPwd:pwd];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  模拟登录  场景
 */
- (void) doLoginWithName:(NSString *)userName andPwd:(NSString *)pwd {

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
