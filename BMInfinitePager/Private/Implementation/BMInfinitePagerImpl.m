//
//  BMInfinitePagerImpl.m
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMInfinitePagerImpl.h"

@implementation BMInfinitePagerImpl

@synthesize scrollView = _scrollView;
@synthesize pages = _pages;
@synthesize pageSize = _pageSize;
@synthesize currentPage = _currentPage;
@synthesize lookAhead = _lookAhead;
@synthesize preparationThreshold = _preparationThreshold;


static BOOL isSilent = NO;


- (void) setOffset:(BMIndexPath *)offset {
    _offset = offset;
    [self setupCenterPageWithOffset: offset];
    [self recenter];
    
}

- (id)initWithFrame:(CGRect)frame numberOfPages: (NSUInteger) lookAhead threshold: (NSUInteger) preparationThreshold delegate:(id<BMInfinitePagerImplDelegate>)delegate
{
    self = [super init];
    if (self) {
        _lookAhead = lookAhead;
        _preparationThreshold = preparationThreshold;
        _pageSize = frame.size;
        _delegate = delegate;
        _offset = [[BMIndexPath alloc] init];
    }
    return self;
}

#pragma mark - Silence methods

- (void) silent {
    isSilent = YES;
}

- (void) unsilent {
    isSilent = NO;
}

- (BOOL) isSilent {
    return isSilent;
}
#pragma mark - Setup

//setup involving parent class
- (void) setup {
    
    [self setupScrollView];
    [self setupSubviews];
    [self setupCenterPageWithOffset: _offset];
    [self recenter];

}

- (void) setupScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.pageSize.width, self.pageSize.height)];
    _scrollView.contentSize = CGSizeMake(self.pageSize.width * self.numOfPages, self.pageSize.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
}

- (void) setupSubviews {
    self.pages = [[NSArray alloc] init];
    for (NSUInteger i = 0 ; i < self.numOfPages; ++i) {
        UIView * page = [[UIView alloc] initWithFrame: [self rectForPageAtIndex: i]];
        [self.scrollView addSubview: page];
        self.pages = [self.pages arrayByAddingObject: page];
    }
}


#pragma mark - Psuedo Getters
- (NSUInteger) numOfPages {
    return self.lookAhead * 2 + 1;
}

- (NSUInteger) lastPageIndex {
    return self.lookAhead * 2;
}

- (NSUInteger) centerPageIndex {
    return self.lookAhead;
}

- (CGFloat) pageDistanceError {
    return .1;
}

#pragma mark - Page management

- (void) initializePageAtIndex:(NSUInteger)index withOffset:(BMIndexPath*)offset {
    
    [self destroyPageAtIndex: index];
    [self constructPageAtIndex: index withOffset: offset];
}

//private
- (void) destroyPageAtIndex: (NSUInteger) index {
    for (UIView* subview in [(UIView*) self.pages[index] subviews]) {
        [subview removeFromSuperview];
    }
    
}

- (void) constructPageAtIndex: (NSUInteger) index withOffset: (BMIndexPath*) offset {
    UIView* childView = [self.delegate impl: self needsPageForOffset: offset];
    childView.frame = CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);
    [self.pages[index] addSubview: childView];
    
}

- (void) setupCenterPageWithOffset: (BMIndexPath*) offset {
    [self setupCenterPageWithOffset: offset threshold: self.preparationThreshold];
}


#pragma mark - Methods to Override in Subclass

- (void) scrolledToPoint: (CGPoint) point {}

- (void) setupCenterPageWithOffset:(BMIndexPath *)offset threshold:(NSUInteger)threshold {}

- (CGRect) rectForPageAtIndex: (NSUInteger) index {
    return CGRectZero; // override in subclass
}

- (void) setOffset:(BMIndexPath *)offset animated:(BOOL)animated {
    if (animated) {
        //animation behavior must be implemented in subclasses
        _offset = offset;
        _currentPage = self.centerPageIndex;
    } else {
        self.offset = offset;
    }
    
    
    
}


#pragma mark - Page management

- (void) recenter {
    [self moveToPageAtIndex: self.centerPageIndex animated: NO];
    _currentPage = self.centerPageIndex;
}

- (void) incrementPageNumber {
    _currentPage = (_currentPage == self.numOfPages - 2) ? self.centerPageIndex : _currentPage + 1;
}

- (void) decrementPageNumber {
    _currentPage = (_currentPage == 1) ? self.centerPageIndex : _currentPage - 1;
}

- (void) moveToPageAtIndex:(NSUInteger)index animated: (BOOL) animated {
    [self.scrollView setContentOffset: [(UIView*) self.pages[index] frame].origin
                             animated: animated];
}

#pragma mark - UIScroll View Delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    //ignore the first call to this method since it is called when the page
    //is first set up
    
    static BOOL ignore = YES;
    if (ignore) {
        ignore = NO;
    } else {
        [self scrolledToPoint: scrollView.contentOffset];
    }
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (isSilent) {
        [self unsilent];
        [self.delegate impl: self didPageToOffset: [self.offset copy]];
    }
}


@end
