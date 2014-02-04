//
//  IMSport.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

typedef enum {
    IMSportSeasonSummer = 0,
    IMSportSeasonFall = 1,
    IMSportSeasonWinter = 2,
    IMSportSeasonSpring = 3
    
} IMSportSeason;

@interface IMSport : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSString* cid;
@property (nonatomic, assign, readonly) IMSportSeason season;
@property (nonatomic, strong, readonly) NSArray* leagues;
@property (readonly) BOOL leaguesResolved;

- (void) resolveLeague: (void(^)(IMSport* sport)) block;

@end
