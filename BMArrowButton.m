//
//  BMArrowView.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMArrowButton.h"

@implementation BMArrowButton

@synthesize style = _style;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame style: (BMArrowButtonStyle) style {
    self = [super initWithFrame: frame];
    if (self) {
        _style = style;
    }
    return self;
}

+ (BMArrowButton*) arrowButtonWithFrame: (CGRect) frame style:(BMArrowButtonStyle)style {
    return [[BMArrowButton alloc] initWithFrame: frame style: style];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint top;
    CGPoint bottom;
    CGPoint arrowPoint;
    
    if (self.style == BMArrowButtonStyleLeft) {
        top = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
        bottom = CGPointMake(rect.origin.x + rect.size.width,  rect.origin.y + rect.size.height);
        arrowPoint = CGPointMake(rect.origin.x, rect.origin.y + (rect.size.height / 2.f));
        
    } else if (self.style == BMArrowButtonStyleRight) {
        top = CGPointMake(rect.origin.x, rect.origin.y);
        bottom = CGPointMake(rect.origin.x,  rect.origin.y + rect.size.height);
        arrowPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + (rect.size.height / 2.f));
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, top.x, top.y);
    CGContextAddLineToPoint(context, bottom.x, bottom.y);
    CGContextAddLineToPoint(context, arrowPoint.x, arrowPoint.y);
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor darkGrayColor].CGColor);
    
    CGContextFillPath(context);
    
}


@end
