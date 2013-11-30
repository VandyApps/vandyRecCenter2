//
//  BMIndexPath.m
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "BMIndexPath.h"

@implementation BMIndexPath

#pragma mark - Class methods

+ (BMIndexPath*) indexPathWithRow:(NSInteger)row column:(NSInteger)column {
    return [[BMIndexPath alloc] initWithRow: row column: column];
}

+ (BMIndexPath*) indexPathWithRow:(NSInteger)row {
    return [BMIndexPath indexPathWithRow: row column: 0];
}

+ (BMIndexPath*) indexPathWithColumn:(NSInteger)column {
    return [BMIndexPath indexPathWithRow: 0 column: column];
}


#pragma mark - Initializers
- (id) init {
    self = [super init];
    if (self) {
        _row = 0;
        _column = 0;
    }
    return self;
}

- (id) initWithRow:(NSInteger)row column:(NSInteger)column {
    self = [self init];
    if (self) {
        _row = row;
        _column = column;
    }
    return self;
}


#pragma mark - Override NSObject methods

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass: [BMIndexPath class]]) {
        BMIndexPath* obj = object;
        return obj.row == _row && obj.column == _column;
    }
    return  NO;
}

- (id) copy {
    return [BMIndexPath indexPathWithRow: _row column: _column];
}

- (NSString*) description {
    return [NSString stringWithFormat: @"[row %i, column %i]", _row, _column];
}
@end
