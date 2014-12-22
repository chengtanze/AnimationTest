//
//  CustomBarChart.h
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/22.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBarChart : UIView
-(void)showBarChart;
-(void)setVerticalData:(NSArray *)array;
-(void)changeDataToCGPoint;
@end
