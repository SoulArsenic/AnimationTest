//
//  ImageScrollSpeedVC.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/26.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "ImageScrollSpeedVC.h"
#import <Foundation/Foundation.h>

@interface ImageScrollSpeedVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray * source;
@end

@implementation ImageScrollSpeedVC


- (void)viewDidLoad{
    [super viewDidLoad];


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.source.count;
}

@end
/*
 
 

 
 */