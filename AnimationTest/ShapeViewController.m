//
//  ShapeViewController.m
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/17.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "ShapeViewController.h"

@interface ShapeViewController ()

@property (nonatomic, strong)CAShapeLayer * layer;
@end

@implementation ShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.layer = [CAShapeLayer layer];
    //self.layer.frame = self.view.frame;
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    self.layer.lineCap = kCALineCapRound;
    self.layer.lineJoin = kCALineJoinBevel;
    self.layer.fillColor   = [[UIColor whiteColor] CGColor];
    self.layer.lineWidth   = 3.0;
    self.layer.strokeEnd   = 0.0;
    
     self.layer.strokeColor   = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.layer];
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //创建一条路径
    //CGMutablePathRef path = CGPathCreateMutable();
    
    //设置一个圆的路径
    //CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    /*2  创建一个贝塞尔曲线路径  */
//    UIBezierPath * path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(150, 150)];
//    [path addLineToPoint:CGPointMake(150, 200)];
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(150, 150)];
    
        [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(170, 0)];
    self.layer.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [self.layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    self.layer.strokeEnd = 1.0;
    //self.layer.strokeStart   = 0.0f;
    //self.layer.strokeEnd     = 0.0f;
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
