//
//  CustomLineChart.m
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/19.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CustomLineChart.h"

@interface CustomLineChart()
{
    CGRect lineChartRect;
}
@property(nonatomic, strong)NSMutableArray * horizontalArray;
@property(nonatomic, strong)NSMutableArray * verticalArray;
@property(nonatomic, strong)NSMutableArray * LineArray;

@property(nonatomic, strong)CALayer * lineLayer;
@property(nonatomic, strong)CAShapeLayer * Animationlayer;



@end

@implementation CustomLineChart


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        lineChartRect = CGRectMake(30, 0, self.frame.size.width - 50, self.frame.size.height - 150);
        self.lineLayer = [self createLineLayer:lineChartRect];
        [self.layer addSublayer:self.lineLayer];
        
        self.Animationlayer = [CAShapeLayer layer];
        self.Animationlayer.lineCap = kCALineCapRound;
        self.Animationlayer.lineJoin = kCALineJoinBevel;
        self.Animationlayer.fillColor   = [[UIColor whiteColor] CGColor];
        self.Animationlayer.lineWidth   = 5.0;
        self.Animationlayer.strokeEnd   = 0.0;
        
        self.Animationlayer.strokeColor   = [UIColor greenColor].CGColor;
        [self.lineLayer addSublayer:self.Animationlayer];
        
        //self.lineLayer.transform = CATransform3DMakeRotation(-M_PI, 0.5, 0, 0);
        
        self.LineArray = [NSMutableArray array];

    }
    
    

    return self;
}

-(void)changeDataToCGPoint{
    
    
    float scalX = lineChartRect.size.width / (self.horizontalArray.count - 1) * 1.0;
    //float scalY = lineChartRect.size.height / self.verticalArray.count * 1.0;
    
    NSArray* reversedArray = [self.verticalArray sortedArrayUsingSelector:@selector(compare:)];
    float max =[reversedArray[reversedArray.count - 1] floatValue];
    float min = [reversedArray[0] floatValue];
    
    for (NSInteger index = 0; index < self.horizontalArray.count; index++) {
        CGPoint point;
        point.x = index * scalX;
        point.y = (([self.verticalArray[index] floatValue] - min) / (max - min)) * lineChartRect.size.height;
        
        NSValue * value = [NSValue valueWithCGPoint:point];
        NSLog(@"value :%@", value);
        [self.LineArray addObject:value];
    }
    
}

-(void)showLineChart{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    CGPoint value  = [self.LineArray[0] CGPointValue];
    [path moveToPoint:value];
    NSInteger count = self.LineArray.count;
    for (NSInteger index = 1; index < count; index++) {
        CGPoint value  = [self.LineArray[index] CGPointValue];
        [path addLineToPoint:value];
        
        [path moveToPoint:value];
        
        [path stroke];
    }

    self.Animationlayer.path = path.CGPath;

    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1];
    pathAnimation.autoreverses = NO;
    [self.Animationlayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    pathAnimation.delegate = self;

    self.Animationlayer.strokeStart = 0;
    self.Animationlayer.strokeEnd = 1;
    
    NSLog(@"animation count %ld", [self.Animationlayer animationKeys].count);

}

-(void)showHorizontalLabel{

    for (NSInteger index = 0; index < self.LineArray.count; index++) {
        CGPoint point = [self.LineArray[index] CGPointValue];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, self.lineLayer.bounds.size.height + 10, 30, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.text = self.horizontalArray[index];
        label.textAlignment = NSTextAlignmentRight;
        //label.transform =  CGAffineTransformMakeRotation(-M_PI_4);
        [self addSubview:label];
    }
}

-(void)showVerticalLabel{
    for (NSInteger index = 0; index < self.LineArray.count; index++) {
        CGPoint point = [self.LineArray[index] CGPointValue];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(-5, point.y - 10, 30, 15)];
        label.backgroundColor = [UIColor clearColor];
        label.text = self.verticalArray[index];
        label.textAlignment = NSTextAlignmentRight;
        //label.transform =  CGAffineTransformMakeRotation(-M_PI_4);
        [self addSubview:label];
    }
}

-(void)setHorizontalData:(NSArray *)array{
    if (array == nil) {
        
    }
    else{
        //NSArray* reversedArray = [array sortedArrayUsingSelector:@selector(compare:)];
        self.horizontalArray = [NSMutableArray arrayWithArray:array];
    }

}

-(void)setVerticalData:(NSArray *)array{
    //NSArray* reversedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    self.verticalArray = [NSMutableArray arrayWithArray:array];
}

-(CALayer *)createLineLayer:(CGRect)rect{
    CALayer * lineLayer = [CALayer layer];
    lineLayer.frame = rect;
    lineLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    
    return lineLayer;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

}

-(void)dealloc{
    NSLog(@"123");
}

@end
