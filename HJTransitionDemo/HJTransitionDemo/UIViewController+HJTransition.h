//
//  UIViewController+HJTransition.h
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/16.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HJTransitionType){
    HJTransitionTypeCoverVertical,
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
};

@interface UIViewController (HJTransition)
@property(nonatomic, assign) HJTransitionType transitionType;
@end
