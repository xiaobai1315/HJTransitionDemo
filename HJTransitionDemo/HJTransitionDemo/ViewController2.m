//
//  ViewController2.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageview = [UIImageView new];
    imageview.frame = self.view.bounds;
    imageview.image = [UIImage imageNamed:@"1.jpeg"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
