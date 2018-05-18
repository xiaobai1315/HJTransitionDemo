//
//  UIView+HJSelected.m
//  HJTransitionDemo
//
//  Created by Jermy on 2018/5/18.
//  Copyright © 2018年 Jermy. All rights reserved.
//

const char *isSelectedKey = "isSelectedKey";

#import "UIView+HJSelected.h"
#import <objc/message.h>

@implementation UIView (HJSelected)

-(void)setIsSelected:(BOOL)isSelected
{
    objc_setAssociatedObject(self, isSelectedKey, @(isSelected), OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)isSelected
{
    NSNumber *num = objc_getAssociatedObject(self, isSelectedKey);
    return num.boolValue;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isSelected = YES;
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isSelected = NO;
    [super touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isSelected = NO;
    [super touchesCancelled:touches withEvent:event];
}

@end
