//
//  Tool.h
//  AnimationTest
//
//  Created by lengbinbin on 15/1/28.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//处于哪个象限
typedef enum {

    QuadrantLocation_None,//特殊点 不在象限内
    QuadrantLocation_1,//第一象限
    QuadrantLocation_2,//第二象限
    QuadrantLocation_3,//第三象限
    QuadrantLocation_4 //第四象限
    
}QuadrantLocation;


@interface Tool : NSObject

+ (QuadrantLocation) point:(CGPoint)point1 RelativeToCenterPoint:(CGPoint)point2;

@end
