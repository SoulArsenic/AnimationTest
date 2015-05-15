//
//  Tool.m
//  AnimationTest
//
//  Created by lengbinbin on 15/1/28.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "Tool.h"

@implementation Tool


+ (QuadrantLocation) point:(CGPoint)point1 RelativeToCenterPoint:(CGPoint)point2{

    
    if ((point1.x == point2.x) || (point1.y == point2.y)) {
        NSLog(@"%@%@",NSStringFromCGPoint(point1),NSStringFromCGPoint(point2));
        NSLog(@"不在三界之内");
        return QuadrantLocation_None;
    }else if (point1.x>point2.x){
    //2、3
        if (point1.y > point2.y) {
            return QuadrantLocation_3;
        }else{
            return QuadrantLocation_2;
        }
    }
    else{
    //1、4
        if (point1.y > point2.y) {
            return QuadrantLocation_4;
        }else{
            return QuadrantLocation_1;
        }
    
    }
    return QuadrantLocation_None;
}

@end
