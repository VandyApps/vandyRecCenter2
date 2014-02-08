//
//  IMGames.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/31/14.
//  Copyright(c) 2014 Brendan McNamara. All rights reserved.
//


#import "RecModelProtocol.h"

#import <Foundation/Foundation.h>
@class IMGame;

@interface IMGames : NSObject <RecModelProtocol>

@property (nonatomic, strong) NSArray* games;
@property (nonatomic, assign, readonly) NSUInteger count;

- (IMGame*) gameWithId: (NSString*) cid;

- (void) sort;

- (NSArray*) newGames;
- (NSArray*) oldGames;

@end
