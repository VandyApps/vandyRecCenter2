//
//  IMGames.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/31/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMGames.h"
#import "IMGame.h"

@implementation IMGames

@synthesize games = _games;
@dynamic count;


- (IMGame*) gameWithId:(NSString *)cid {
    for (IMGame* game in self.games) {
        if ([game.cid isEqualToString: cid]) {
            return game;
        }
    }
    return nil;
}

#pragma mark - Rec Model Protocol

- (void) parse:(NSArray*)hash {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (NSDictionary* gameHash in hash) {
        IMGame* game = [[IMGame alloc] init];
        [game parse: gameHash];
        [array addObject: game];
    }
    _games = [array copy];
}

- (NSArray*) serialize {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (IMGame* game in self.games) {
        [array addObject: [game serialize]];
    }
    return [array copy];
}

- (NSUInteger) count {
    return self.games.count;
}

@end
