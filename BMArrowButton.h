//
//  BMArrowView.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    BMArrowButtonStyleLeft,
    BMArrowButtonStyleRight
} BMArrowButtonStyle;

@interface BMArrowButton : UIButton

@property (nonatomic, readonly) BMArrowButtonStyle style;

+ (BMArrowButton*) arrowButtonWithFrame: (CGRect) frame style: (BMArrowButtonStyle) style;

@end
