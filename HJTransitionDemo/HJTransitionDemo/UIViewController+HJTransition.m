//
//  UIViewController+HJTransition.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/16.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "UIViewController+HJTransition.h"
#import <objc/message.h>
#import "UIView+HJSelected.h"

static char *HJTransitionTypeKey = "HJTransitionTypeKey";
static char *HJTransitionSubTypeKey = "HJTransitionSubTypeKey";
static char *HJTransitionIsPresentedKey = "HJTransitionIsPresentedKey";
static char *HJTransitionViewOriginalFrameKey = "HJTransitionViewOriginalFrameKey";
static char *HJTransitionAnimateImageKey = "HJTransitionAnimateImageKey";

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

//保存vc弹出、消失的状态
-(void)setIsPresented:(BOOL)isPresented
{
    objc_setAssociatedObject(self, HJTransitionIsPresentedKey, @(isPresented), OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)getIsPresented
{
    NSNumber *num = (NSNumber *)objc_getAssociatedObject(self, HJTransitionIsPresentedKey);
    return num.boolValue;
}

//保存View的初始frame
-(void) setViewOriginalFrame:(CGRect)rect
{
    objc_setAssociatedObject(self, HJTransitionViewOriginalFrameKey, @(rect), OBJC_ASSOCIATION_RETAIN);
}

-(CGRect) getViewOriginalFrame
{
    NSNumber *num = (NSNumber *)objc_getAssociatedObject(self, HJTransitionViewOriginalFrameKey);
    return num.CGRectValue;
}

//保存将要动画的image
-(void) setAniamteImage:(UIImage *)image
{
    objc_setAssociatedObject(self, HJTransitionAnimateImageKey, image, OBJC_ASSOCIATION_RETAIN);
}

-(UIImage *) getAnimateImage
{
    return objc_getAssociatedObject(self, HJTransitionAnimateImageKey);
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
        case HJTransitionTypeFadeOut:
        case HJTransitionTypePopup:
            [self customTransition:type viewControllerToPresent:viewControllerToPresent animated:flag completion:completion];
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
-(void) customTransition: (HJTransitionType)type
 viewControllerToPresent: (UIViewController *)viewControllerToPresent
                animated: (BOOL)flag
              completion: (void (^ __nullable)(void))completion
{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate = self;
    [self setTransitionType:type];
    [self HJPresentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [self setIsPresented:YES];
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [self setIsPresented:NO];
    return self;
}

#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    HJTransitionType type = [self transitionType];
    if ([self getIsPresented]) {
        [self presentTransition:transitionContext type:type];
    }else {
        [self dismissTransition:transitionContext type:type];
    }
}

- (void)presentTransition:(id <UIViewControllerContextTransitioning>)transitionContext type:(HJTransitionType)type
{
    switch (type) {
        case HJTransitionTypeFadeOut:
            [self presentTransitionFadeOut:transitionContext];
            break;
            
        case HJTransitionTypePopup:
            [self presentTransitionPopup:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext type:(HJTransitionType)type
{
    switch (type) {
        case HJTransitionTypeFadeOut:
            [self dismissTransitionFadeOut:transitionContext];
            break;
            
        case HJTransitionTypePopup:
            [self dismissTransitionPopup:transitionContext];
            break;
            
        default:
            break;
    }
}

#pragma mark 自定义转场动画
//淡出的方式弹出界面
-(void) presentTransitionFadeOut:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *tovc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [transitionContext.containerView addSubview:tovc.view];
    
    tovc.view.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        tovc.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

//淡出的方式消失界面
-(void) dismissTransitionFadeOut:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromvc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [transitionContext.containerView addSubview:fromvc.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        fromvc.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

//弹出的方式弹出界面
-(void) presentTransitionPopup:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIImageView *snapShot = [[UIImageView alloc] initWithImage:[self getImageFromSelectedView:fromVC.view]];
    snapShot.frame = fromVC.view.bounds;
    fromVC.view.hidden = YES;
    
    //获取将要动画的View的frame、截图
    UIView *selectedView = [self getSelectedView:fromVC.view];
    CGRect viewOriginalFrame = selectedView.frame;
    [self setViewOriginalFrame:viewOriginalFrame];
    
    CGRect viewAnimateFrame = CGRectMake(0, 0, viewOriginalFrame.size.width, viewOriginalFrame.size.height);
    UIImage *image = [self getImageFromSelectedView:selectedView];
    [self setAniamteImage:image];
    UIImageView *animateView = [[UIImageView alloc] initWithImage:image];
    animateView.frame = viewOriginalFrame;
    [snapShot addSubview:animateView];
    
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.alpha = 0;
    
    [transitionContext.containerView addSubview:snapShot];
    [transitionContext.containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        animateView.frame = viewAnimateFrame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

//弹出的方式消失界面
-(void) dismissTransitionPopup:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.hidden = YES;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.hidden = NO;
    
    //对tovc进行截图
    UIImage *image = [self getImageFromSelectedView:toVC.view];
    UIImageView *snapShot = [[UIImageView alloc] initWithImage:image];
    snapShot.frame = toVC.view.frame;
    
    //将要动画的图片
    UIImageView *animateView = [[UIImageView alloc] init];
    animateView.image = [self getAnimateImage];
    CGRect viewOriginalFrame = [self getViewOriginalFrame];
    animateView.frame = CGRectMake(0, 0, viewOriginalFrame.size.width, viewOriginalFrame.size.height);
    [snapShot addSubview:animateView];
    
    [transitionContext.containerView addSubview:snapShot];
//    [transitionContext.containerView addSubview:fromVC.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        animateView.frame = viewOriginalFrame;
    } completion:^(BOOL finished) {
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

//获取界面上被选中的View
-(UIView *)getSelectedView:(UIView *)view
{
    UIView *tempView = nil;
    
    for (UIView *subView in view.subviews) {
        
        //有tableView，直接返回选中的cell
        if ([subView isKindOfClass:[UITableView class]]) {
            UITableView *tableview = (UITableView *)subView;
            NSIndexPath *indexpath = tableview.indexPathForSelectedRow;
            UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexpath];
            
            tempView = cell;
            break;
        }
        
        if (subView.isSelected) {
            tempView = subView;
            break;
        }
        
        if (subView.subviews.count > 0) {
            [self getSelectedView:subView];
        }
    }
    
    return tempView;
}

//返回当前View的截图
-(UIImage *)getImageFromSelectedView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
