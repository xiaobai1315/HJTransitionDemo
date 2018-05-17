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
    HJTransitionTypePopup,     //自定义效果
};

typedef NS_ENUM(NSInteger, HJTransitionSubType){
    HJTransitionSubTypeFromLeft,
    HJTransitionSubTypeFromRight,
    HJTransitionSubTypeFromTop,
    HJTransitionSubTypeFromBottom,
};

@interface UIViewController (HJTransition)
@property(nonatomic, assign) HJTransitionType transitionType;
@property(nonatomic, assign) HJTransitionSubType transitionSubType;
@end
