//
//  BMInfinitePager.h
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInfinitePagerDelegate.h"
#import "BMInfinitePagerImplDelegate.h"
#import "BMindexPath.h"

//this macro must at least be 2
#define kBMInfinitePagerPreparationThreshold 3

//this macro must be at least double the
//macro for preparation threshol
#define kBMInfinitePagerLookAhead 8



typedef enum {
    BMInfinitePagerStyleVertical,
    BMInfinitePagerStyleHorizontal,
    BMInfinitePagerStyleMatrix
} BMInfinitePagerStyle;

@protocol BMInfinitePagerImplDelegate;


@interface BMInfinitePager : UIView <BMInfinitePagerImplDelegate>

@property (nonatomic, weak) id<BMInfinitePagerDelegate> delegate;

@property (nonatomic) BMIndexPath* offset;

@property (nonatomic) BOOL leftPagingEnabled;
@property (nonatomic) BOOL rightPagingEnabled;
@property (nonatomic) BOOL upPagingEnabled;
@property (nonatomic) BOOL downPagingEnabled;

@property (nonatomic, readonly) CGSize pageSize;

+ (BMInfinitePager*) pagerWithFrame:(CGRect)frame
               style: (BMInfinitePagerStyle) style;



- (void) setOffset:(BMIndexPath*) offset animated: (BOOL) animated;
- (void) pageLeftAnimated: (BOOL) animated;
- (void) pageRightAnimated: (BOOL) animated;
- (void) pageUpAnimated: (BOOL) animated;
- (void) pageDownAnimated: (BOOL) animated;


@end
