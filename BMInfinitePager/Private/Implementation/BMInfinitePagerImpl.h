//
//  BMInfinitePagerImpl.h
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInfinitePagerImplDelegate.h"
#import "BMInfinitePagerDelegate.h"
#import "BMIndexPath.h"

@interface BMInfinitePagerImpl : NSObject <UIScrollViewDelegate>

@property (nonatomic, weak) id<BMInfinitePagerImplDelegate> delegate;

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) NSArray* pages;

@property (nonatomic, strong) BMIndexPath* offset;

@property (nonatomic, readonly) NSUInteger currentPage;
@property (nonatomic, readonly) NSUInteger numOfPages;
@property (nonatomic, readonly) NSUInteger lastPageIndex;
@property (nonatomic, readonly) NSUInteger centerPageIndex;
@property (nonatomic, readonly) CGSize pageSize;

@property (nonatomic, readonly) CGFloat pageDistanceError;
@property (nonatomic, readonly) NSUInteger lookAhead;
@property (nonatomic, readonly) NSUInteger preparationThreshold;

- (id)initWithFrame:(CGRect)frame
      numberOfPages: (NSUInteger) lookAhead
          threshold: (NSUInteger) preparationThreshold
           delegate: (id<BMInfinitePagerImplDelegate>) delegate;

- (void) initializePageAtIndex: (NSUInteger) index withOffset: (BMIndexPath*) offset;

- (void) recenter;
- (void) incrementPageNumber;
- (void) decrementPageNumber;


- (void) setOffset:(BMIndexPath *)offset animated:(BOOL)animated;
- (void) setupCenterPageWithOffset: (BMIndexPath*) offset;
- (void) moveToPageAtIndex: (NSUInteger) index animated: (BOOL) animated;

//for allowing or dissallowing the delegate methods
//to be called
- (void) silent;
- (void) unsilent;
- (BOOL) isSilent;


//should be defined in subclasses.  These methods are automatically called
- (void) setup;
- (void) scrolledToPoint: (CGPoint) point;
- (void) setupCenterPageWithOffset:(BMIndexPath *)offset threshold: (NSUInteger) threshold;
- (CGRect) rectForPageAtIndex: (NSUInteger) index;

@end
