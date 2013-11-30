//
//  BMInfinitePager.m
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMInfinitePager.h"


//subclasses
#import "BMHorizontalPager.h"
#import "BMInfinitePagerImpl.h"

@implementation BMInfinitePager

- (void) setDelegate:(id<BMInfinitePagerDelegate>)delegate {
    
    _delegate = delegate;
    [self setup];
}

+ (BMInfinitePager*) pagerWithFrame:(CGRect)frame style:(BMInfinitePagerStyle)style {
    
    switch (style) {
        case BMInfinitePagerStyleHorizontal:
            return [[BMHorizontalPager alloc] initWithFrame: frame];
        default:
            return nil;
    }
}

- (void) setOffset:(BMIndexPath *)offset animated:(BOOL)animated {}
- (void) setup {};
- (void) pageLeftAnimated:(BOOL)animated {}
- (void) pageRightAnimated:(BOOL)animated {}
- (void) pageUpAnimated:(BOOL)animated {}
- (void) pageDownAnimated:(BOOL)animated {}


#pragma mark - Implementation Delegate

- (UIView*) impl:(BMInfinitePagerImpl *)impl needsPageForOffset:(BMIndexPath *)offset {
    
    return [self.delegate pager: self viewForOffset:offset];
}

- (void) implDidPageDown:(BMInfinitePagerImpl *)impl {
    if ([self.delegate respondsToSelector: @selector(pagerDidPageDown:)]) {
        [self.delegate pagerDidPageDown: self];
    }
}

- (void) implDidPageLeft:(BMInfinitePagerImpl *)impl {
    if ([self.delegate respondsToSelector: @selector(pagerDidPageLeft:)]) {
        [self.delegate pagerDidPageLeft: self];
    }
}

- (void) implDidPageRight:(BMInfinitePagerImpl *)impl {
    if ([self.delegate respondsToSelector: @selector(pagerDidPageRight:)]) {
        [self.delegate pagerDidPageRight: self];
    }
}

- (void) implDidPageUp:(BMInfinitePagerImpl *)impl {
    if ([self.delegate respondsToSelector: @selector(pagerDidPageUp:)]) {
        [self.delegate pagerDidPageUp: self];
    }
}

- (void) impl:(BMInfinitePagerImpl *)impl didPageToOffset:(BMIndexPath *)offset {
    if ([self.delegate respondsToSelector: @selector(pager:didPageToOffset:)]) {
        [self.delegate pager: self didPageToOffset: offset];
    }
}

@end


