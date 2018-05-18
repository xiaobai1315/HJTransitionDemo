//
//  ViewController3.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/18.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController4.h"
#import "UIViewController+HJTransition.h"

@interface ViewController3 ()

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    imageView.frame = CGRectMake(0, screenH * 0.5, screenW, 400);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ViewController4 *vc4 = [ViewController4 new];
    vc4.transitionType = HJTransitionTypePopup;
    [self presentViewController:vc4 animated:YES completion:nil];
}

@end
