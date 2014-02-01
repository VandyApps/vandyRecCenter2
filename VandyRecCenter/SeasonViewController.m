//
//  IntramuralSeasonViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "SeasonViewController.h"

#import "IMGame.h"
#import "IMGames.h"

@interface SeasonViewController ()

@property (nonatomic, strong) IMGames* gamesCollection;

@end

@implementation SeasonViewController

#pragma mark - Initializer

- (id) initWithContentSize: (CGSize) size {
    if (self = [super init]) {
        _size = size;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
    
    self.tableView = [[UITableView alloc] initWithFrame: (CGRect) {{0,0}, self.view.frame.size}
                                                  style:UITableViewStyleGrouped];
    
    self.gamesCollection = [[IMGames alloc] init];
    
    [self.gamesCollection parse:
  @[
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Lakers",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @0,
        @"awayScore": @0,
        @"date": @"01/02/2013",
        @"startTime": @"5:00pm",
        @"endTime": @"6:00pm",
        @"status": @4,
        @"location": @"Court 1"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Bucks",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @20,
        @"awayScore": @0,
        @"date": @"01/04/2013",
        @"startTime": @"6:30pm",
        @"endTime": @"8:00pm",
        @"status": @3,
        @"location": @"Court 3"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Lakers",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @0,
        @"awayScore": @0,
        @"date": @"01/02/2013",
        @"startTime": @"5:00pm",
        @"endTime": @"6:00pm",
        @"status": @4,
        @"location": @"Court 1"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Bucks",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @20,
        @"awayScore": @0,
        @"date": @"01/04/2013",
        @"startTime": @"6:30pm",
        @"endTime": @"8:00pm",
        @"status": @3,
        @"location": @"Court 3"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Lakers",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @0,
        @"awayScore": @0,
        @"date": @"01/02/2013",
        @"startTime": @"5:00pm",
        @"endTime": @"6:00pm",
        @"status": @4,
        @"location": @"Court 1"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Bucks",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @20,
        @"awayScore": @0,
        @"date": @"01/04/2013",
        @"startTime": @"6:30pm",
        @"endTime": @"8:00pm",
        @"status": @3,
        @"location": @"Court 3"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Lakers",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @0,
        @"awayScore": @0,
        @"date": @"01/02/2013",
        @"startTime": @"5:00pm",
        @"endTime": @"6:00pm",
        @"status": @4,
        @"location": @"Court 1"
        },
    @{
        @"_id": @"00",
        @"homeTeam":
            @{
                @"_id": @"00",
                @"name": @"Grizzlies",
                @"wins": @0,
                @"losses": @1,
                @"ties": @2
                },
        @"awayTeam":
            @{
                @"_id": @"01",
                @"name": @"Bucks",
                @"wins": @1,
                @"losses": @2,
                @"ties": @1
                },
        @"homeScore": @20,
        @"awayScore": @0,
        @"date": @"01/04/2013",
        @"startTime": @"6:30pm",
        @"endTime": @"8:00pm",
        @"status": @3,
        @"location": @"Court 3"
        }
                                   
    
    ]];
    
}


#pragma mark - Table View Datasource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}


@end
