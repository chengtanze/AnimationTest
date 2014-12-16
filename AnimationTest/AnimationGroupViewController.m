//
//  AnimationGroupViewController.m
//  AnimationTest
//
//  Created by wangsl-iMac on 14/12/16.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "AnimationGroupViewController.h"

@interface AnimationGroupViewController ()
{
    CALayer * myLayer;
}
@end

@implementation AnimationGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    myLayer = [CALayer layer];
    myLayer.bounds = CGRectMake(0, 0, 80, 80);
    myLayer.backgroundColor = [UIColor yellowColor].CGColor;
    myLayer.anchorPoint = CGPointMake(0.5, 0.5);
    myLayer.position = CGPointMake(100, 200);
    myLayer.cornerRadius = 20;
    

    [self.view.layer addSublayer:myLayer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)eventz{
    CAAnimationGroup *ani = [self createGroupAnimation];
    
    [myLayer addAnimation:ani forKey:@"group"];
}

-(CAAnimationGroup *)createGroupAnimation{
    
    CABasicAnimation * animationMove = [CABasicAnimation animation];
    animationMove.keyPath = @"transform.translation.y";
    animationMove.toValue = @(200);
    
    CABasicAnimation * animationScal = [CABasicAnimation animation];
    animationScal.keyPath = @"transform.scale";
    animationScal.toValue = @(0.1);
    
    CABasicAnimation * animationRotat = [CABasicAnimation animation];
    animationRotat.keyPath = @"transform.rotation";
    animationRotat.toValue = @(M_PI);
    
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    //设置组动画的时间
    animationGroup.duration = 2;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.animations = @[animationMove, animationRotat,animationScal];
    
    return animationGroup;
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
