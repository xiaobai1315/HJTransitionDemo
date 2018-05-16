//
//  UIViewController+HJTransition.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/16.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "UIViewController+HJTransition.h"
#import <objc/message.h>

static char *HJTransitionTypeKey = "HJTransitionTypeKey";

@implementation UIViewController (HJTransition)

//交换系统方法和自定义方法
+(void)load{
    Method method1 = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method method2 = class_getInstanceMethod([self class], @selector(HJPresentViewController:animated:completion:));
    
    method_exchangeImplementations(method1, method2);
}

-(void)setTransitionType:(HJTransitionType)transitionType
{
    objc_setAssociatedObject(self, HJTransitionTypeKey, @(transitionType), OBJC_ASSOCIATION_RETAIN);
}

-(HJTransitionType)transitionType
{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, HJTransitionTypeKey);
    return number.integerValue;
}

- (void)HJPresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion
{
    NSLog(@"%zd", self.transitionType);
    [self HJPresentViewController:viewControllerToPresent animated:flag completion:completion];
    
}
@end
