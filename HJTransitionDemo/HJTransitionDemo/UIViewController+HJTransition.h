//
//  UIViewController+HJTransition.h
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/16.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HJTransitionType){
    HJTransitionTypeCoverVertical = 0,
    HJTransitionTypeFlipHorizontal,
    HJTransitionTypeCrossDissolve,
    HJTransitionTypePartialCurl,
    HJTransitionTypeMoveIn,
    HJTransitionTypeFade,
    HJTransitionTypePush,
    HJTransitionTypeReveal,
    HJTransitionTypepageCurl,
    HJTransitionTypepageUnCurl,
    HJTransitionTypeRippleEffect,
    HJTransitionTypeSuckEffect,
    HJTransitionTypeCube,
    HJTransitionTypeOglFlip,
    //自定义效果
    HJTransitionTypeFadeOut,    //淡出效果，修改View的alpha值
    HJTransitionTypePopup,      //弹出效果，被选中的View变大至全屏，dismiss时变小恢复到之前
};

typedef NS_ENUM(NSInteger, HJTransitionSubType){
    HJTransitionSubTypeFromLeft,
    HJTransitionSubTypeFromRight,
    HJTransitionSubTypeFromTop,
    HJTransitionSubTypeFromBottom,
};

@interface UIViewController (HJTransition)<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) HJTransitionType transitionType;       //转场动画类型
@property(nonatomic, assign) HJTransitionSubType transitionSubType; //转场动画子类型
@end
