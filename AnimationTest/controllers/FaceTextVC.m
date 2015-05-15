//
//  FaceTextVC.m
//  AnimationTest
//
//  Created by lengbinbin on 15/3/5.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "FaceTextVC.h"
#import "CoreTextView.h"
#import "NSString+Weibo.h"

@interface FaceTextVC ()
@property (weak, nonatomic) IBOutlet CoreTextView *textview;

@end

@implementation FaceTextVC
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSString * str =  @"这就是为了@你 @aabbssccsdsdsadsadsadasdasddsad#sdhjasdjsaduieuiransdjshdaisudsajdaskdj# 试试混排解析😢😂效果 [挖鼻屎][doge][喵喵][囧]#klksdlskldksajdjhjhjdbvnu# #在这里输入你想要说的话题# ，。,.还有#tips#俄#otherTips#全半角符号 http://t.cn/ABECS7D www.baidu.com http://www.baidu.com ";
    

    self.textview.adjustWidth = 300;
    self.textview.attributedString = [str transformText];
    self.textview.callBack = ^(NSString * string, CustomGlyphAttributeType type){
        NSLog(@"receive %@ %d",string,type);
    };
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.textview.frame = CGRectMake(0,84, _textview.adjustSize.width, _textview.adjustSize.height);
}
@end
