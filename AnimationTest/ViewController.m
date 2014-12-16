//
//  ViewController.m
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/13.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer * myLayer;
    CALayer * scalLayer;
    CALayer * rotatLayer;
    CALayer * keyValueLayer;
    CALayer * pathLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    myLayer = [CALayer layer];
//    myLayer.bounds = CGRectMake(0, 0, 200, 100);
//    myLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    myLayer.anchorPoint = CGPointMake(0, 0);
//    myLayer.position = CGPointMake(100, 100);
//    myLayer.cornerRadius = 20;
//    
//    [self.view.layer addSublayer:myLayer];
//    
//    
//    scalLayer = [CALayer layer];
//    scalLayer.bounds = CGRectMake(0, 0, 20, 10);
//    scalLayer.anchorPoint = CGPointMake(0, 0);
//    scalLayer.backgroundColor = [UIColor blueColor].CGColor;
//    scalLayer.position = CGPointMake(10, 10);
//    
//    [self.view.layer addSublayer:scalLayer];
//    
//    rotatLayer = [CALayer layer];
//    rotatLayer.bounds = CGRectMake(0, 0, 100, 50);
//    //rotatLayer.anchorPoint = CGPointMake(0, 0);
//    rotatLayer.backgroundColor = [UIColor blueColor].CGColor;
//    rotatLayer.position = CGPointMake(100, 300);
//    
//    [self.view.layer addSublayer:rotatLayer];
    
    
    keyValueLayer = [CALayer layer];
    keyValueLayer.bounds = CGRectMake(0, 0, 50, 50);
    keyValueLayer.anchorPoint = CGPointMake(0, 0);
    keyValueLayer.backgroundColor = [UIColor blueColor].CGColor;
    keyValueLayer.position = CGPointMake(0, 0);
    
    [self.view.layer addSublayer:keyValueLayer];
    
    pathLayer = [CALayer layer];
    pathLayer.bounds = CGRectMake(0, 0, 20, 20);
    pathLayer.anchorPoint = CGPointMake(0, 0);
    pathLayer.backgroundColor = [UIColor yellowColor].CGColor;
    pathLayer.position = CGPointMake(300, 200);
    
    [self.view.layer addSublayer: pathLayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //CABasicAnimation * animationTrans = [self createTransAnimation];
    
    //[myLayer addAnimation:animationTrans forKey:@"move"];
    
    
    //CABasicAnimation * animationScal = [self createScalAnimation];
    
    //[scalLayer addAnimation:animationScal forKey:@"scal"];
    
    //CABasicAnimation * animationRotat = [self createRotateAnimation];
    
    //[rotatLayer addAnimation:animationRotat forKey:@"rotat"];
    
    CAKeyframeAnimation * animationKeyValue = [self createKeyframeAnimation];
    
    [keyValueLayer addAnimation:animationKeyValue forKey:@"keyValue"];
    
    CAKeyframeAnimation * animationPath = [self createKeyPathAnimation];
    
    [pathLayer addAnimation:animationPath forKey:@"path"];

}

-(CABasicAnimation *)createTransAnimation{
    // 创建核心动画
    CABasicAnimation * animation = [CABasicAnimation animation];
    
    // 告诉系统要执行什么动作，这里position是位置移动
    animation.keyPath = @"position";
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
    
    //设置动画执行完毕之后不删除动画
    animation.removedOnCompletion = NO;
    
    /** fillMode
     *
     *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
     *  预置为:
     *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
     *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
     *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
     */
    //设置保存动画的最新状态 kCAFillModeForwards 保持在最后一个动作 ；kCAFillModeBackwards还原状态
    animation.fillMode = kCAFillModeForwards;
    
    // 设置代理通知动画状态
    animation.delegate = self;
    
    /*
     在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
     比如，CALayer的position初始值为(100,100)，CABasicAnimation的fromValue为(100,100)，toValue为(400,100)，虽然动画执行完毕后图层保持在(400,100)这个位置，实质上图层的position还是为(100,100)
     */
    
    return animation;
}

-(CABasicAnimation *)createScalAnimation{
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 100)];
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    return animation;
}

-(CABasicAnimation *)createRotateAnimation{
    
    // 创建动画
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    // 设置动画时间
    animation.duration = 1.0;
    
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation( M_PI, 0, 0, 1)];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    return animation;
}

//values：就是上述的NSArray对象。里面的元素称为”关键帧”(keyframe)。
//动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧
-(CAKeyframeAnimation *)createKeyframeAnimation{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue * value2 = [NSValue valueWithCGPoint:CGPointMake(50, 0)];
    NSValue * value3 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    NSValue * value4 = [NSValue valueWithCGPoint:CGPointMake(100, 50)];
    NSValue * value5 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    animation.values = @[value1, value2, value3, value4, value5];
    // 设置动画时间
    animation.duration = 1.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    /** timingFunction
     *
     *  用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是
     *  先快后慢,先慢后快还是先慢再快再慢.
     *
     *  动画的开始与结束的快慢,有五个预置分别为(下同):
     *  kCAMediaTimingFunctionLinear            线性,即匀速
     *  kCAMediaTimingFunctionEaseIn            先慢后快
     *  kCAMediaTimingFunctionEaseOut           先快后慢
     *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
     *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
     */
    // 设置动画的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.delegate = self;
    
    return animation;
    
}

//可以设置一个CGPathRef\CGMutablePathRef,让层跟着路径移动。
//path只对CALayer的anchorPoint和position起作用。如果你设置了path，那么values将被忽略
-(CAKeyframeAnimation *)createKeyPathAnimation{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置一个圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
    
    animation.path = path;
    
    CGPathRelease(path);
    // 设置动画时间
    animation.duration = 4.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    // 设置动画的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.delegate = self;
    return animation;
}

// 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animationDidStart Name:%@", anim);
}

// 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animationDidStop Position %f-%f", myLayer.position.x, myLayer.position.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StopClick:(id)sender {
    [pathLayer removeAnimationForKey:@"path"];
}
@end
