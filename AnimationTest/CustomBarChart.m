
//
//  CustomBarChart.m
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/22.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CustomBarChart.h"


#define CUSTOMBAR_TEXT_HEIGTH 15
#define CUSTOMBAR_DATA_HEIGTH 15

@interface CustomBarChart()
{
    CGFloat ProgerssBarHeight;
    CGFloat BackGroupBarHeight;
}
@property(nonatomic, strong)CAShapeLayer * barLayer;
@property(nonatomic, strong)NSMutableArray * verticalArray;
@end

@implementation CustomBarChart


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectBackGroup = rect;
    rectBackGroup.origin.y += CUSTOMBAR_DATA_HEIGTH;
//    rectBackGroup.size.height -= CUSTOMBAR_DATA_HEIGTH;
//    rectBackGroup.size.height -= CUSTOMBAR_TEXT_HEIGTH;
//    BackGroupBarHeight = rectBackGroup.size.height;
    rectBackGroup.size.height = BackGroupBarHeight;
    //指定填充颜色
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    //填充矩形区域
    CGContextFillRect(context, rectBackGroup);
    
    CGContextAddRect(context, rectBackGroup);
    
    CGContextDrawPath(context, kCGPathEOFill);
}


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.barLayer = [CAShapeLayer layer];

        self.barLayer.lineCap = kCALineCapButt;
        self.barLayer.lineJoin = kCALineJoinBevel;
        self.barLayer.fillColor   = [[UIColor whiteColor] CGColor];
        self.barLayer.lineWidth   = frame.size.width;
        self.barLayer.strokeEnd   = 0.0;
        
        self.barLayer.strokeColor   = [UIColor greenColor].CGColor;
        [self.layer addSublayer:self.barLayer];
//        
        CGRect rectBackGroup = frame;
        rectBackGroup.origin.y += CUSTOMBAR_DATA_HEIGTH;
        rectBackGroup.size.height -= CUSTOMBAR_DATA_HEIGTH;
        rectBackGroup.size.height -= CUSTOMBAR_TEXT_HEIGTH;
        BackGroupBarHeight = rectBackGroup.size.height;
    }
    
    return self;
}

-(void)changeDataToCGPoint{
    NSArray* reversedArray = [self.verticalArray sortedArrayUsingSelector:@selector(compare:)];
    float min =[reversedArray[reversedArray.count - 1] floatValue];
    float max = [reversedArray[0] floatValue];
    
    float scal = min / max;
    
   
    ProgerssBarHeight = scal * BackGroupBarHeight;
}

-(void)setVerticalData:(NSArray *)array{
    if (array == nil) {
        
    }
    else{
        //NSArray* reversedArray = [array sortedArrayUsingSelector:@selector(compare:)];
        self.verticalArray = [NSMutableArray arrayWithArray:array];
    }
}

-(void)showBarChart{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    CGPoint pointStart = CGPointMake((self.frame.size.width) / 2.0, self.frame.size.height - CUSTOMBAR_TEXT_HEIGTH);
    CGPoint pointEnd = CGPointMake((self.frame.size.width ) / 2.0, CUSTOMBAR_DATA_HEIGTH + BackGroupBarHeight - ProgerssBarHeight);
    [path moveToPoint:pointStart];
    [path addLineToPoint:pointEnd];
    
    self.barLayer.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1];
    pathAnimation.autoreverses = NO;
    [self.barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    pathAnimation.delegate = self;
    
    self.barLayer.strokeStart = 0;
    self.barLayer.strokeEnd = 1;
}

@end
