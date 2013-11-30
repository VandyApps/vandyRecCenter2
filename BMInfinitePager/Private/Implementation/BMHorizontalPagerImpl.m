//
//  BMHorizontalPagerImpl.m
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMHorizontalPagerImpl.h"

@implementation BMHorizontalPagerImpl

@synthesize rightPagingEnabled;
@synthesize leftPagingEnabled;

#pragma mark - Override methods
- (void) setup {
    
    [super setup];
}

- (void) scrolledToPoint:(CGPoint)point {
    
    if ([self pointIsAtIncrementedPage: point]) {
        NSUInteger prevPageNumber = self.currentPage;
        
        [self didPageRight];
        if (self.currentPage == self.centerPageIndex && prevPageNumber != self.centerPageIndex -1) {
            [self recenterLeftFromPoint: point];
        }
        
    } else if ([self pointIsAtDecrementedPage: point]) {
        NSUInteger prevPageNumber = self.currentPage;
        
        [self didPageLeft];
        if (self.currentPage == self.centerPageIndex && prevPageNumber != self.centerPageIndex + 1) {
            [self recenterRightFromPoint: point];
        }
        
    } else if ([self pointIsAtNewPage: point]) {
        [self.delegate impl: self didPageToOffset: [self.offset copy]];
    }
}


- (void) setupCenterPageWithOffset:(BMIndexPath *)offset threshold:(NSUInteger)threshold {
    
    for (NSInteger i = -1 * (NSInteger) threshold; i <= (NSInteger) threshold; ++i) {
        
        [self initializePageAtIndex: i + self.centerPageIndex withOffset: [BMIndexPath indexPathWithRow:offset.row + i column: 0]];
    }
    
}

- (void) setOffset:(BMIndexPath *)offset animated:(BOOL)animated {
    //don't need to do anything if setting to the same row
    if (offset.row != self.offset.row) {
        if (animated) {
            //don't call delegate until the end
            [self silent];
            
            if (self.offset.row > offset.row) { //scroll down
              
                if (self.offset.row - offset.row > self.lookAhead) {
                    
                    [self initializePageAtIndex: self.lastPageIndex withOffset: self.offset];
                    [self moveToPageAtIndex: self.lastPageIndex animated:NO];
                    [self setupCenterPageWithOffset: offset threshold: self.lookAhead - 1];
                    
                    [self moveToPageAtIndex: self.centerPageIndex animated: YES];
                } else {
                    NSUInteger distance = self.offset.row - offset.row;
                    
                    [self initializePageAtIndex: self.centerPageIndex + distance
                                     withOffset: self.offset];
                    
                    [self moveToPageAtIndex: self.centerPageIndex + distance animated: NO];
                    
                    [self setupCenterPageWithOffset: offset
                                          threshold: MAX(distance, self.preparationThreshold)];
                    
                    [self moveToPageAtIndex: self.centerPageIndex animated: YES];
                    
                }
            } else { //scroll up
                if (offset.row - self.offset.row > self.lookAhead) {
                    
                    [self initializePageAtIndex: 0 withOffset: self.offset];
                    [self moveToPageAtIndex: 0 animated: NO];
                    [self setupCenterPageWithOffset: offset threshold: self.lookAhead - 1];
                    
                    [self moveToPageAtIndex: self.centerPageIndex animated: YES];
                } else {
                    NSUInteger distance = offset.row - self.offset.row;
                    
                    [self initializePageAtIndex: self.centerPageIndex - distance withOffset:self.offset];
                    [self moveToPageAtIndex: self.centerPageIndex - distance animated: NO];
                    [self setupCenterPageWithOffset: offset
                                          threshold: MAX(distance, self.preparationThreshold)];
                    
                    [self moveToPageAtIndex: self.centerPageIndex animated: YES];
                }
            }
            
        } else {
            //call normal setter
            self.offset = offset;
        }
        //super class sets properties but does not deal with animation
        [super setOffset: offset animated: YES];
        
    }
}

#pragma mark - Setup

- (CGRect) rectForPageAtIndex: (NSUInteger) index {
    return CGRectMake(self.pageSize.width * index, 0, self.pageSize.width, self.pageSize.height);
}

#pragma mark - Recentering

- (void) recenterLeftFromPoint: (CGPoint) point {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    CGFloat normalizedOffset = 1 - (pageProgress - floor(pageProgress));
    self.scrollView.contentOffset = CGPointMake((self.centerPageIndex - normalizedOffset) * self.pageSize.width, 0);
}

- (void) recenterRightFromPoint: (CGPoint) point {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    CGFloat normalizedOffset = pageProgress - floor(pageProgress);
    self.scrollView.contentOffset = CGPointMake((self.centerPageIndex + normalizedOffset) * self.pageSize.width, 0);
}

#pragma mark - Page management

- (void) didPageLeft {
    self.offset.row = self.offset.row - 1;
    
    if (self.currentPage < self.preparationThreshold) {
        NSUInteger distanceFromCenter = self.preparationThreshold - self.currentPage + 1;
        NSUInteger distanceFromPageZero = self.currentPage;
        
        [self initializePageAtIndex: self.centerPageIndex - distanceFromCenter
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row - self.preparationThreshold]];
        
        [self initializePageAtIndex: self.centerPageIndex + distanceFromCenter
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row - distanceFromPageZero + distanceFromCenter + 1]];
        
        
    } else if (self.currentPage == self.preparationThreshold) {
        
        [self initializePageAtIndex: 0
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row - self.preparationThreshold + 1]];
        
        [self initializePageAtIndex: self.centerPageIndex
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row - self.preparationThreshold + 1]];
        
        [self initializePageAtIndex: self.centerPageIndex - 1
                         withOffset: [BMIndexPath indexPathWithRow:self.offset.row - self.preparationThreshold]];
        
        [self initializePageAtIndex: self.centerPageIndex + 1
                         withOffset: [BMIndexPath indexPathWithRow:self.offset.row - self.preparationThreshold +2]];
        
    } else { //currentPage > prep
        
        [self initializePageAtIndex: self.currentPage - self.preparationThreshold - 1
                         withOffset:[BMIndexPath indexPathWithRow: self.offset.row - self.preparationThreshold]];
    }
    [self decrementPageNumber];
    [self.delegate implDidPageLeft: self];
    [self.delegate impl: self didPageToOffset: [self.offset copy]];
    
}

- (void) didPageRight {
    self.offset.row = self.offset.row + 1;
    
    if (self.currentPage + self.preparationThreshold > self.lastPageIndex) {
     
        NSUInteger distanceFromCenter = (self.currentPage + self.preparationThreshold) - self.lastPageIndex;
        NSUInteger distanceFromLastPage = self.lastPageIndex - self.currentPage;
        
        [self initializePageAtIndex: self.centerPageIndex + distanceFromCenter + 1
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row + self.preparationThreshold]];
        
        [self initializePageAtIndex: self.centerPageIndex - distanceFromCenter - 1
                         withOffset: [BMIndexPath indexPathWithRow: self.offset.row + distanceFromLastPage - distanceFromCenter - 2]];
        
    } else if (self.currentPage + self.preparationThreshold == self.lastPageIndex) {
        [self initializePageAtIndex: self.lastPageIndex withOffset: [BMIndexPath indexPathWithRow:self.offset.row + self.preparationThreshold - 1]];
        [self initializePageAtIndex: self.centerPageIndex withOffset: [BMIndexPath indexPathWithRow:self.offset.row + self.preparationThreshold - 1]];
        
        [self initializePageAtIndex: self.centerPageIndex + 1
                         withOffset: [BMIndexPath indexPathWithRow:self.offset.row + self.preparationThreshold]];
        
        [self initializePageAtIndex: self.centerPageIndex - 1
                         withOffset: [BMIndexPath indexPathWithRow:self.offset.row + self.preparationThreshold - 2]];
        
    } else { //current page + prep < last index
        [self initializePageAtIndex: self.currentPage + self.preparationThreshold + 1 withOffset: [BMIndexPath indexPathWithRow: self.offset.row + self.preparationThreshold]];
    }
    
    [self incrementPageNumber];
    [self.delegate implDidPageRight: self];
    [self.delegate impl: self didPageToOffset: [self.offset copy]];
}

#pragma mark - Detection methods
- (CGFloat) pageProgressForPoint: (CGPoint) point {
    return point.x / self.pageSize.width;
}

- (BOOL) pointIsAtNewPage: (CGPoint) point {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    return pageProgress <= floor(pageProgress) + self.pageDistanceError
        && pageProgress >= floor(pageProgress) - self.pageDistanceError
        && self.currentPage != (NSUInteger) round(pageProgress);
}

- (BOOL) pointIsAtIncrementedPage: (CGPoint) point  {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    
    return pageProgress >= (self.currentPage + 1) - self.pageDistanceError
        && pageProgress <= (self.currentPage + 1);
}

- (BOOL) pointIsAtDecrementedPage: (CGPoint) point {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    
    return pageProgress <= (self.currentPage - 1) + self.pageDistanceError
    && pageProgress >= floor(pageProgress)
    && (self.currentPage - 1) == (NSUInteger) round(pageProgress);

}

- (BOOL) pointIsAtNewPageWithoutError: (CGPoint) point {
    CGFloat pageProgress = [self pageProgressForPoint: point];
    return pageProgress == floor(pageProgress);
}

@end
