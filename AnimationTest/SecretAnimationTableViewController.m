//
//  SecretAnimationTableViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SecretAnimationTableViewController.h"
#import "SecretAnimationCell.h"




@interface SecretAnimationTableView : UITableView

@end
@implementation SecretAnimationTableView



@end


@interface SecretAnimationTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *myPanGesture;
@property (assign) CGPoint saveOld;
@property (assign) BOOL holdPan;
@property (assign) BOOL passToSubView;

@property (assign) CGPoint actionStart;

@end



@implementation SecretAnimationTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
}


- (IBAction)myPanAction:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.holdPan = NO;
        self.saveOld = CGPointZero;

    }else{
        
    }
    
    if (self.passToSubView) {
        CGPoint temp = [sender locationInView:self.tableView];
        
        if (sender.state == UIGestureRecognizerStateBegan) {
            if (!CGPointEqualToPoint(_actionStart, temp)) {
                
                SecretAnimationCell * cell =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:_actionStart]];
                SecretAnimationCell * cellT =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:temp]];
                if (![cell isEqual:cellT]) {
                    [cell sendActionViewBack];
                }

            }
            _actionStart = temp;
        }

        if (CGPointEqualToPoint(_actionStart, CGPointZero)) {
            _actionStart  = temp;
        }

        SecretAnimationCell * cell =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:_actionStart]];
        [cell touchGesture:sender];
    
    }
 
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (self.holdPan) {
        self.passToSubView = YES;
        return NO;
    }
    
    if (!CGPointEqualToPoint(self.saveOld, CGPointZero)) {

        CGPoint other = [otherGestureRecognizer locationInView:self.tableView];
        CGFloat a =ABS(self.saveOld.x - other.x);
        CGFloat b = ABS(self.saveOld.y - other.y) /2;
        
        if (a>b) {
         
            self.saveOld = CGPointZero;
            self.holdPan = YES;
            self.passToSubView = YES;

            return NO;
            
        }else {
        
            
        }
    }
    
    
    self.saveOld = [otherGestureRecognizer locationInView:self.tableView];
    
    self.passToSubView = NO;

    return YES;
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
        [temp resetUI];
    }
}

@end
