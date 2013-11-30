//
//  BMHorizontalPager.m
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMHorizontalPager.h"
#import "BMHorizontalPagerImpl.h"


@interface BMHorizontalPager()

@property (nonatomic, strong) BMHorizontalPagerImpl* impl;
@end


@implementation BMHorizontalPager

#pragma mark - Override Getters
- (BOOL) rightPagingEnabled {
    return self.impl.rightPagingEnabled;
}

- (BOOL) leftPagingEnabled {
    return self.impl.leftPagingEnabled;
}

- (CGSize) pageSize {
    return self.impl.pageSize;
}

#pragma mark - Override Setters
- (void) setOffset:(BMIndexPath *)offset animated:(BOOL)animated {
    [self.impl setOffset: offset animated:animated];
}

- (void) setOffset:(BMIndexPath *)offset {
    self.impl.offset = offset;
}

#pragma mark - Initializer

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        
        _impl = [[BMHorizontalPagerImpl alloc] initWithFrame: frame
                                               numberOfPages: kBMInfinitePagerLookAhead
                                                   threshold: kBMInfinitePagerPreparationThreshold
                                                    delegate: self];
    }
    return self;
}

#pragma mark - Setup
- (void) setup {
    
    [_impl setup];
    [self addSubview: _impl.scrollView];
}

#pragma mark - Delegate override
- (void) impl:(BMInfinitePagerImpl *)impl didPageToOffset:(BMIndexPath *)offset {
    if (![self.impl isSilent]) {
        [super impl: impl didPageToOffset: offset];
    }
}


- (void) implDidPageLeft:(BMInfinitePagerImpl *)impl {
    if (![self.impl isSilent]) {
        [super implDidPageLeft: impl];
    }
}

- (void) implDidPageRight:(BMInfinitePagerImpl *)impl {
    if (![self.impl isSilent]) {
        [super implDidPageRight: impl];
    }
}

#pragma mark - Paging

- (void) pageLeftAnimated:(BOOL)animated {
    [_impl.scrollView setContentOffset: CGPointMake((_impl.currentPage - 1) * self.pageSize.width, _impl.scrollView.contentOffset.y)
                              animated: animated];
}

- (void) pageRightAnimated:(BOOL)animated {
    [_impl.scrollView setContentOffset: CGPointMake((_impl.currentPage + 1) * self.pageSize.width, _impl.scrollView.contentOffset.y)
                              animated: animated];
}

@end
