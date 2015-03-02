//
//  SecretAnimationTableViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/4.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "SecretAnimationTableViewController.h"
#import "SecretAnimationCell.h"
#import "Fresh.h"



@interface SecretAnimationTableView : UITableView
@property (nonatomic,strong) Fresh * myFreshView;

- (void) startAnimation;
- (void) endAnimation;
@end


@implementation SecretAnimationTableView
-(void)startAnimation{
    [self endAnimation];
    if (!_myFreshView) {
        
        self.myFreshView = [[Fresh alloc] initWithFrame:CGRectMake(0, -120, self.frame.size.width, 120)];
        _myFreshView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_myFreshView];

    }
    
    [_myFreshView start];
}
-(void)endAnimation{
    
    [_myFreshView end];

}

@end


@interface SecretAnimationTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *myPanGesture;
@property (assign) CGPoint saveOld;
@property (assign) BOOL holdPan;
@property (assign) BOOL passToSubView;
@property (assign) BOOL shouldLoading;
@property (assign) CGPoint actionStart;



@end



@implementation SecretAnimationTableViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    CGFloat yPox = scrollView.contentOffset.y;
    if (_shouldLoading) {
        return;
    }
    if (yPox < -120) {
        _shouldLoading = YES;
        
        scrollView.contentInset =  UIEdgeInsetsMake(120 + 64, 0, 0, 0);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            scrollView.contentOffset = CGPointMake(0, -( 120 + 64));
            
            
        });
        if ([self.tableView isKindOfClass:[SecretAnimationTableView class]]) {
            SecretAnimationTableView * ce = (SecretAnimationTableView *) self.tableView;
            [ce startAnimation];
        }
        
        [self performSelector:@selector(callBack) withObject:nil afterDelay:4];
    }
}

- (void) callBack{
    if ([self.tableView isKindOfClass:[SecretAnimationTableView class]]) {
        
        SecretAnimationTableView * ce = (SecretAnimationTableView *) self.tableView;
        [ce endAnimation];
    }
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [UIView animateWithDuration:.5 animations:^{
        [self.tableView scrollsToTop];        
    }];

    _shouldLoading = NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (IBAction)myPanAction:(UIPanGestureRecognizer *)sender {
    
    CGPoint temp = [sender locationInView:self.tableView];
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.holdPan = NO;
        self.saveOld = CGPointZero;

    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        SecretAnimationCell * cell =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:_actionStart]];
        SecretAnimationCell * cellT =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:temp]];
        
        if (![cell isEqual:cellT]) {
            [cell sendActionViewBack];
            _actionStart = temp;
        }
        
        
        

    }
    
    if (self.passToSubView) {

        
        if (!_holdPan && !CGPointEqualToPoint(_actionStart, temp)) {
            
            SecretAnimationCell * cell =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:_actionStart]];
            SecretAnimationCell * cellT =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:temp]];
            
            if (![cell isEqual:cellT]) {
                [cell sendActionViewBack];
            }
            else{
                [cell touchGesture:sender];
            }
            
            _actionStart = temp;
            
            
        }else
        {
            SecretAnimationCell * cell =(SecretAnimationCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:_actionStart]];
            [cell touchGesture:sender];
        }

    }
 
}
- (IBAction)tap:(id)sender {
    self.saveOld =[sender locationInView:self.tableView];

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
