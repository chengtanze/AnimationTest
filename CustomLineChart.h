//
//  CustomLineChart.h
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/19.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLineChart : UIView



-(void)setVerticalData:(NSArray *)array;
-(void)setHorizontalData:(NSArray *)array;
-(void)changeDataToCGPoint;
-(void)showHorizontalLabel;
-(void)showVerticalLabel;
-(void)showLineChart;
@end
