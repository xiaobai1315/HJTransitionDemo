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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController
{
    NSArray *_headerArray;
    NSArray *_systemArray1;
    NSArray *_systemArray2;
    NSArray *_customArray;
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
    HJTransitionType type = 0;
    
    if (indexPath.section == 0) {

        type = indexPath.row;
    }else if (indexPath.section == 1) {

        type = indexPath.row + _systemArray1.count;
    }else {

        type = indexPath.row + _systemArray1.count + _systemArray2.count;
    }
    
    ViewController2 *vc2 = [ViewController2 new];
    vc2.transitionType = type;
    [self presentViewController:vc2 animated:YES completion:nil];
}

- (void) HJTransition:(HJTransitionType)type
{
    NSString *transitionType = @"";
    
    switch (type) {
        case HJTransitionTypeCoverVertical:
        case HJTransitionTypeFlipHorizontal:
        case HJTransitionTypeCrossDissolve:
        case HJTransitionTypePartialCurl:
            [self system1Transition:type];
            break;
        
        case HJTransitionTypeMoveIn:
            transitionType = kCATransitionMoveIn;
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeFade:
            transitionType = kCATransitionFade;
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypePush:
            transitionType = kCATransitionPush;
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeReveal:
            transitionType = kCATransitionReveal;
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypepageCurl:
            transitionType = @"pageCurl";
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypepageUnCurl:
            transitionType = @"pageUnCurl";
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeRippleEffect:
            transitionType = @"rippleEffect";
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeSuckEffect:
            transitionType = @"suckEffect";
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeCube:
            transitionType = @"cube";
            [self system2Transition:transitionType];
            break;
        case HJTransitionTypeOglFlip:
            transitionType = @"oglFlip";
            [self system2Transition:transitionType];
            break;
            
        default:
            break;
    }
}

-(void) system1Transition:(HJTransitionType)type {
    
    ViewController2 *vc2 = [ViewController2 new];
    vc2.modalTransitionStyle = (UIModalTransitionStyle)type;
    
    [self presentViewController:vc2 animated:YES completion:nil];
}

-(void) system2Transition:(NSString *)type{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.type = type;
//    animation.subtype =
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    ViewController2 *vc2 = [ViewController2 new];
    [self presentViewController:vc2 animated:YES completion:nil];
}

-(void)mapTransitionType:(HJTransitionType)type
{
    
}

@end
