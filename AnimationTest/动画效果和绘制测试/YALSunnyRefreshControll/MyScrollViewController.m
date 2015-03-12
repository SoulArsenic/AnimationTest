//
//  MyScrollViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/2/13.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "MyScrollViewController.h"
#import "MyCell.h"
@interface MyScrollViewController()<UITableViewDataSource,UITableViewDelegate>


@end




@implementation MyScrollViewController

-(void)viewDidAppear:(BOOL)animated{
    self.targetBackView = self.backGround;
    self.targetScrollView = self.tableView;
    
    [super viewDidAppear:animated];

}


#pragma -mark tableviewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
//    cell.contentView.subviews
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell isKindOfClass:[MyCell class]]) {
        MyCell * a =(MyCell *)cell;
        
        [a.contentView bringSubviewToFront:a.colorView];
    }
}



@end
