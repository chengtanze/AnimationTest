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



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150, 150)];
    [path addLineToPoint:CGPointMake(150, 200)];
    [path moveToPoint:CGPointMake(150, 200)];
    
    [path addLineToPoint:CGPointMake(250, 200)];
    [path moveToPoint:CGPointMake(250, 200)];
    [path addLineToPoint:CGPointMake(300, 300)];
    //        UIBezierPath * path = [UIBezierPath bezierPath];
    //        [path moveToPoint:CGPointMake(150, 150)];
    //
    //        [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(170, 0)];
    self.layer.path = path.CGPath;
    //
    
    
    /*
     strokeStart和strokeEnd 是一个0-1的取值范围。表示一段路径的开始和结尾。比如开始位置为0.5结束位置为1 那就只渲染出后半段的路径
     strokeStart 翻译过来就是清除开始位置
     strokeEnd   意思就是清除结束的位置
     
     
     这里有4个组合
     1 keyPath = strokeStart  动画的fromValue = 0，toValue = 1
     表示从路径的0位置画到1 怎么画是按照清除开始的位置也就是清除0 一直清除到1 效果就是一条路径慢慢的消失
     
     2 keyPath = strokeStart  动画的fromValue = 1，toValue = 0
     表示从路径的1位置画到0 怎么画是按照清除开始的位置也就是1 这样开始的路径是空的（即都被清除掉了）一直清除到0 效果就是一条路径被反方向画出来
     
     3 keyPath = strokeEnd  动画的fromValue = 0，toValue = 1
     表示 这里我们分3个点说明动画的顺序  strokeEnd从结尾开始清除 首先整条路径先清除后2/3，接着清除1/3 效果就是正方向画出路径
     
     3 keyPath = strokeEnd  动画的fromValue = 1，toValue = 0
     效果就是反方向路径慢慢消失
     */
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:.0f];
    pathAnimation.autoreverses = NO;
    [self.layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    

    //该路径最后显示的样子，从0-1全部显示。如果是 start = 1，end = 1表示画完动画后消失
    self.layer.strokeStart = 0;
    self.layer.strokeEnd = 1;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
    //创建一条路径
    //CGMutablePathRef path = CGPathCreateMutable();
    
    //设置一个圆的路径
    //CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    /*2  创建一个贝塞尔曲线路径  */
//    UIBezierPath * path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(150, 150)];
//    [path addLineToPoint:CGPointMake(150, 200)];
//    [path moveToPoint:CGPointMake(150, 200)];
//    
//    [path addLineToPoint:CGPointMake(250, 200)];
//    [path moveToPoint:CGPointMake(250, 200)];
//    [path addLineToPoint:CGPointMake(300, 300)];
////        UIBezierPath * path = [UIBezierPath bezierPath];
////        [path moveToPoint:CGPointMake(150, 150)];
////    
////        [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(170, 0)];
//    self.layer.path = path.CGPath;
//    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 1.0;
//    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAnimation.fromValue = [NSNumber numberWithFloat:.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
//    pathAnimation.autoreverses = NO;
//    [self.layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
//    
//    self.layer.strokeEnd = 1.0;

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
