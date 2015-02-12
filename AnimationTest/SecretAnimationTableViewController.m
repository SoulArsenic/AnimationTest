//
//  SecretAnimationTableViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SecretAnimationTableViewController.h"
#import "SecretAnimationCell.h"
@interface SecretAnimationTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end



@implementation SecretAnimationTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}


- (void) statusChange:(BOOL) status{
    self.tableView.scrollEnabled = status;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdtify = @"SecretAnimationTableViewControllerCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdtify forIndexPath:indexPath];
    if ([cell isKindOfClass:[SecretAnimationCell class]]) {
        SecretAnimationCell * temp = (SecretAnimationCell *)cell;

        __block SecretAnimationTableViewController * weakSelf = self;
        
        temp.change = ^(BOOL status){
            
            [weakSelf statusChange:status];
        };
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[SecretAnimationCell class]]) {
        SecretAnimationCell * temp = (SecretAnimationCell *)cell;
        CGFloat a =  arc4random()%10;
        temp.bg.backgroundColor = [UIColor colorWithRed:a*.1 green:arc4random()%10*.1 blue:arc4random()%10*.1 alpha:.5];
    }
}

@end
