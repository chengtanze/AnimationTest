//
//  CATransitonLayerViewController.h
//  AnimationTest
//
//  Created by cheng on 14/12/15.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CATransitonLayerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *MyImageView;
- (IBAction)preButtonClick:(id)sender;
- (IBAction)nextButtonClick:(id)sender;

@end
