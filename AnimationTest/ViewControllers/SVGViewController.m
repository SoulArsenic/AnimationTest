//
//  SVGViewController.m
//  AnimationTest
//
//  Created by lengbinbin on 15/6/26.
//  Copyright © 2015年 lengbinbin. All rights reserved.
//

#import "SVGViewController.h"
#import "QuickSVG.h"
#import "QuickSVGParser.h"
#import "SVGgh.h"

@interface SVGViewController ()<QuickSVGParserDelegate,QuickSVGDelegate,UIWebViewDelegate>
@property (nonatomic, strong) NSMutableArray * objs ;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic, strong) QuickSVG * quickSVG ;
@end

@implementation SVGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.objs = [NSMutableArray array];
    NSArray * paths =  [[NSBundle mainBundle] pathsForResourcesOfType:@"" inDirectory:@"SVGFile"];
    
    
    
    for(NSString *path in paths) {
        NSURL *url = [NSURL fileURLWithPath:path];
        [self.objs addObject:url];
    }
//    NSURL*  myArtwork = [GHControlFactory locateArtworkForObject:self atSubpath:@"SVGfile/alarm"];

       // Do any additional setup after loading the view.
}
-(void)viewDidLayoutSubviews{
    [super  viewDidLayoutSubviews];
    self.scroll.frame = self.view.bounds;
    SVGDocumentView * view = [[SVGDocumentView alloc] initWithFrame:CGRectMake(50, 0, 320, 320)];
    view.backgroundColor = [UIColor clearColor];
    view.fillColor = [UIColor redColor];
    view.artworkPath = @"SVGfile/4";
    [self.scroll addSubview:view];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


//    self.quickSVG = [[QuickSVG alloc] initWithDelegate:self];
//    self.quickSVG.parserDelegate = self;
//    [self.quickSVG parseSVGFileWithURL:[self.objs objectAtIndex:0]];
    
    
    
    
}
#pragma mark-
#pragma mark WebView Delegate
-(void)webView:(nonnull UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{

}
-(void)webViewDidFinishLoad:(nonnull UIWebView *)webView{

}




- (void) quickSVGDidParse:(QuickSVG *)quickSVG
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        quickSVG.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        
        CGRect  frame = CGRectMake(0, 0, CGRectGetWidth(quickSVG.view.bounds), CGRectGetHeight(quickSVG.view.bounds));
        self.scroll.contentSize = frame.size;
        self.scroll.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];

        /*
         Comment the line below to add all parsed views at once
         */

        [self.scroll addSubview:quickSVG.view];
        
    });
}
- (void) scale {
    
}
- (void)quickSVG:(QuickSVG *)quickSVG didParseElement:(QuickSVGElement *)element{

    dispatch_async(dispatch_get_main_queue(), ^{
//        element.frame = CGRectMake(element.frame.origin.x - CGRectGetMinX(_quickSVG.canvasFrame), element.frame.origin.y - CGRectGetMinY(_quickSVG.canvasFrame), element.frame.size.width, element.frame.size.height);
//        
        /*
         Uncomment the line below to asyncronously add all parsed views
         */
        //        [_holderView addSubview:element];
    });

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
