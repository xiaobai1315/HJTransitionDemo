//
//  ViewController.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "UIViewController+HJTransition.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController
{
    NSArray *_headerArray;
    NSArray *_systemArray1;
    NSArray *_systemArray2;
    NSArray *_customArray;
    BOOL _isPresented;
    ViewController2 *vc2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerArray = @[@"系统1",@"系统2", @"自定义"];
    _systemArray1 = @[@"CoverVertical", @"FlipHorizontal", @"CrossDissolve", @"PartialCurl"];
    _systemArray2 = @[@"kCATransitionMoveIn", @"kCATransitionFade", @"kCATransitionPush", @"kCATransitionReveal", @"pageCurl", @"pageUnCurl", @"rippleEffect", @"suckEffect", @"cube", @"oglFlip"];
    _customArray = @[@"fff"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _headerArray[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _systemArray1.count;
    }else if (section == 1) {
        return _systemArray2.count;
    }

    return _customArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _systemArray1[indexPath.row];
    }else if (indexPath.section == 1){
        cell.textLabel.text = _systemArray2[indexPath.row];
    }else {
        cell.textLabel.text = _customArray[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HJTransitionType type = 0;
//
//    if (indexPath.section == 0) {
//
//        type = indexPath.row;
//    }else if (indexPath.section == 1) {
//
//        type = indexPath.row + _systemArray1.count;
//    }else {
//
//        type = indexPath.row + _systemArray1.count + _systemArray2.count;
//    }
    
    vc2 = [ViewController2 new];
//    vc2.transitionType = type;
    vc2.modalPresentationStyle = UIModalPresentationCustom;
    vc2.transitioningDelegate = self;
    [self presentViewController:vc2 animated:YES completion:nil];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _isPresented = YES;
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _isPresented = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_isPresented) {
        [self presentTransition:transitionContext];
    }else {
        [self dismissTransition:transitionContext];
    }
}

- (void)presentTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.hidden = YES;

//    [transitionContext.containerView addSubview:fromVC.view];
    [transitionContext.containerView addSubview:toVC.view];

    [UIView animateWithDuration:0.5 animations:^{

        toVC.view.hidden = NO;
    } completion:^(BOOL finished) {

    }];

//    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
//
//        toVC.view.hidden = NO;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
}

- (void)dismissTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    fromVC.view.alpha = 1;
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toVC.view.hidden = YES;
    
    [transitionContext.containerView addSubview:fromVC.view];
//    [transitionContext.containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:0.5 animations:^{

        fromVC.view.hidden = YES;
    } completion:^(BOOL finished) {
    }];
    
//    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
//
//        toVC.view.hidden = NO;
//    } completion:^(BOOL finished) {
//
//        [transitionContext completeTransition:YES];
//    }];

}

@end
