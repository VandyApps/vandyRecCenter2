//
//  BMAddRemoveButton.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMAddRemoveButton.h"

@implementation BMAddRemoveButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

static CGFloat circleToLinePadding = .25;

- (void)drawRect:(CGRect)rect
{
    if (self.selected) {
        //show a remove button
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGPoint center = CGPointMake(rect.size.width / 2.f + rect.origin.x, rect.size.height / 2.f + rect.origin.y);
        CGFloat radius = MIN(rect.size.width/ 2.f, rect.size.height / 2.f) - 5;
        CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI, 0);
        
        CGContextMoveToPoint(context, center.x - radius * (1-circleToLinePadding), center.y);
        CGContextAddLineToPoint(context, center.x + radius * (1-circleToLinePadding), center.y);
        
        CGContextStrokePath(context);
        
    } else {
        //show an add button
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGPoint center = CGPointMake(rect.size.width / 2.f + rect.origin.x, rect.size.height / 2.f + rect.origin.y);
        CGFloat radius = MIN(rect.size.width/ 2.f, rect.size.height / 2.f) - 5;
        CGContextAddArc(context, center.x, center.y, radius, 0, 2 * M_PI, 0);
        CGContextMoveToPoint(context, center.x, center.y + radius * (1 - circleToLinePadding));
        CGContextAddLineToPoint(context, center.x, center.y - radius * (1- circleToLinePadding));
        
        CGContextMoveToPoint(context, center.x - radius * (1-circleToLinePadding), center.y);
        CGContextAddLineToPoint(context, center.x + radius * (1-circleToLinePadding), center.y);
        
        
        CGContextStrokePath(context);
    }
}


@end
