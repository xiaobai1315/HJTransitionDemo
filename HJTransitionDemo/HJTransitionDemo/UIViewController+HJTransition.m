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
static char *HJTransitionSubTypeKey = "HJTransitionSubTypeKey";

@implementation UIViewController (HJTransition)

//交换系统方法和自定义方法
+(void)load{
    Method method1 = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method method2 = class_getInstanceMethod([self class], @selector(HJPresentViewController:animated:completion:));
    
    method_exchangeImplementations(method1, method2);
}

//transitionType是设置给要弹出界面，这个函数里面的self指的是viewControllerToPresent
-(void)setTransitionType:(HJTransitionType)transitionType
{
    objc_setAssociatedObject(self, HJTransitionTypeKey, @(transitionType), OBJC_ASSOCIATION_RETAIN);
}

-(HJTransitionType)transitionType
{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, HJTransitionTypeKey);
    return number.integerValue;
}

//设置动画子类型
-(void)setTransitionSubType:(HJTransitionSubType)transitionSubType
{
    objc_setAssociatedObject(self, HJTransitionSubTypeKey, @(transitionSubType), OBJC_ASSOCIATION_RETAIN);
}

-(HJTransitionSubType)transitionSubType
{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, HJTransitionSubTypeKey);
    return number.integerValue;
}

//HJPresentViewController的self指的是PresentingviewController
- (void)HJPresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion
{
    //获取vc弹出类型
    HJTransitionType type = viewControllerToPresent.transitionType;
    HJTransitionSubType subType = viewControllerToPresent.transitionSubType;
    
    NSString *transitionType = @"";
    NSString *transitionSubType = @"";
    
    switch (subType) {
        case HJTransitionSubTypeFromLeft:
            transitionSubType = kCATransitionFromLeft;
            break;
        case HJTransitionSubTypeFromRight:
            transitionSubType = kCATransitionFromRight;
            break;
        case HJTransitionSubTypeFromTop:
            transitionSubType = kCATransitionFromTop;
            break;
        case HJTransitionSubTypeFromBottom:
            transitionSubType = kCATransitionFromBottom;
            break;
            
        default:
            transitionSubType = kCATransitionFromLeft;
            break;
    }
    
    switch (type) {
            
        //系统效果，设置presentedVC的modalTransitionStyle属性
        case HJTransitionTypeCoverVertical:
        case HJTransitionTypeFlipHorizontal:
        case HJTransitionTypeCrossDissolve:
        case HJTransitionTypePartialCurl:
            
            [self system1Transition:type viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        //系统效果，presentingVC的layer添加动画
        case HJTransitionTypeMoveIn:
            transitionType = kCATransitionMoveIn;
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeFade:
            transitionType = kCATransitionFade;
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypePush:
            transitionType = kCATransitionPush;
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeReveal:
            transitionType = kCATransitionReveal;
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypepageCurl:
            transitionType = @"pageCurl";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypepageUnCurl:
            transitionType = @"pageUnCurl";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeRippleEffect:
            transitionType = @"rippleEffect";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeSuckEffect:
            transitionType = @"suckEffect";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeCube:
            transitionType = @"cube";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        case HJTransitionTypeOglFlip:
            transitionType = @"oglFlip";
            [self system2Transition:transitionType subType:transitionSubType viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
            break;
            
        //自定义效果
        case HJTransitionTypePopup:
            
            break;
            
        default:
            break;
    }
}

//动画类型1，设置viewControllerToPresent的modalTransitionStyle
-(void) system1Transition: (HJTransitionType)type
  viewControllerToPresent: (UIViewController *)viewControllerToPresent
                 animated: (BOOL)flag
               completion: (void (^ __nullable)(void))completion{
    
    viewControllerToPresent.modalTransitionStyle = (UIModalTransitionStyle)type;
    
    [self HJPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

//动画类型2，presentingViewController添加动画
-(void) system2Transition: (NSString *)type
                  subType: (NSString *)subType
  viewControllerToPresent: (UIViewController *)viewControllerToPresent
                 animated: (BOOL)flag
               completion: (void (^ __nullable)(void))completion{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = type;
    animation.subtype =subType;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self HJPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

//自定义类型
-(void) customTransition
{
    
}

@end
