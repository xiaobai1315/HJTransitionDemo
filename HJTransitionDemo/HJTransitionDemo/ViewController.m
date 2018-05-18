//
//  ViewController.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/15.
//  Copyright © 2018年 Jermy. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "UIViewController+HJTransition.h"
#import "UIView+HJSelected.h"

#define screenW ([UIScreen mainScreen].bounds.size.width)
#define screenH ([UIScreen mainScreen].bounds.size.height)

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
    _customArray = @[@"fadeout", @"popup"];
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

    if (type == HJTransitionTypePopup) {
        ViewController3 *vc3 = [ViewController3 new];
        [self presentViewController:vc3 animated:YES completion:nil];
        return;
    }
    
    vc2 = [ViewController2 new];
    vc2.transitionType = type;
    [self presentViewController:vc2 animated:YES completion:nil];
}


@end
