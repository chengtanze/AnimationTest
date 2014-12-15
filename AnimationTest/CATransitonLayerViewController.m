//
//  CATransitonLayerViewController.m
//  AnimationTest
//
//  Created by cheng on 14/12/15.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CATransitonLayerViewController.h"

@interface CATransitonLayerViewController ()
{
    NSArray * imageArray;
    NSInteger index;
}

@property(nonatomic, strong)UIImage *image1;
@property(nonatomic, strong)UIImage *image2;
@property(nonatomic, strong)UIImage *image3;

@end

@implementation CATransitonLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.image1 = [UIImage imageNamed:@"A1.jpg"];
    self.image2 = [UIImage imageNamed:@"A2.jpg"];
    self.image3 = [UIImage imageNamed:@"A3"];
    
    imageArray = @[self.image1, self.image2, self.image3];
    index = 0;
    self.MyImageView.image = self.image1;
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

- (IBAction)preButtonClick:(id)sender {
    index--;
    if (index < 0) {
        index = 2;
    }
    
    
    self.MyImageView.image = imageArray[index];
    //创建核心动画
    CATransition * tran = [CATransition animation];
    
    //告诉要执行什么动画
    //设置过度效果
    tran.type = @"cube";
    
    //设置动画的过度方向（向左）
    tran.subtype = kCATransitionFromLeft;
    
    //设置动画的时间
    tran.duration = 1.0;
    
    [self.MyImageView.layer addAnimation:tran forKey:@"pre"];
    
    
    
}

- (IBAction)nextButtonClick:(id)sender {
    index++;

    if (index > 2) {
        index = 0;
    }
    
    self.MyImageView.image = imageArray[index];
    
    //创建核心动画
    CATransition * tran = [CATransition animation];
    
    //告诉要执行什么动画
    //设置过度效果
    tran.type = @"cube";
    
    //设置动画的过度方向（向左）
    tran.subtype = kCATransitionFromRight;
    
    //设置动画的时间
    tran.duration = 1.0;
    //1.5设置动画的起点
    tran.startProgress=0.5;
    
    [self.MyImageView.layer addAnimation:tran forKey:@"next"];
}
@end
