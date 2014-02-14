//
//  IntramuralsViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IntramuralsViewController.h"

#import "LeagueViewController.h"

#import "IMSport.h"
#import "IMLeague.h"

@interface IntramuralsViewController ()

@property (nonatomic, strong) NSDictionary* demoData;

@end

@implementation IntramuralsViewController

//private
@synthesize demoData = _demoData;


//public
@synthesize tableView = _tableView;
@synthesize sportsCollection = _sportsCollection;

#pragma mark - Static Variables

static CGFloat headerHeight = 30;


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _sportsCollection = [[IMSports alloc] init];
    [self.sportsCollection parse:
  
     @[
       @{
            @"_id": @"00",
            @"name": @"Flag Football",
            @"season": @1,
            @"leagues":
                @[
                    @{
                        @"id": @"00",
                        @"name": @"Corec black",
                        @"entryStartDate": @"01/30/2014",
                        @"entryEndDate": @"02/01/2014",
                        @"startDate": @"02/01/2014",
                        @"endDate": @"03/01/2014",
                        @"teams":
  
                            @[
                                @{
                                    @"id": @"00",
                                    @"name": @"Patriots",
                                    @"wins": @10,
                                    @"losses": @3,
                                    @"ties": @1
                                },
                                @{
                                    @"id": @"01",
                                    @"name": @"Colts",
                                    @"wins": @6,
                                    @"losses": @6,
                                    @"ties": @0
                                },
                                @{
                                    @"id": @"02",
                                    @"name": @"Giants",
                                    @"wins": @3,
                                    @"losses": @6,
                                    @"ties": @1
                                },
                                @{
                                    @"id": @"03",
                                    @"name": @"Broncos",
                                    @"wins": @5,
                                    @"losses": @7,
                                    @"ties": @2
                                }
                            ],
                        @"games":
                            @[
                                
                                @{
                                    @"id": @"00",
                                    @"date": @"02/12/2014",
                                    @"startTime": @"12:00pm",
                                    @"endTime": @"01:00pm",
                                    @"homeTeam": @"01",
                                    @"awayTeam": @"03",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @5,
                                    @"location": @"Court 1"
                                },
                                @{
                                    @"id": @"01",
                                    @"date": @"02/12/2014",
                                    @"startTime": @"12:00pm",
                                    @"endTime": @"01:00pm",
                                    @"homeTeam": @"01",
                                    @"awayTeam": @"00",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @5,
                                    @"location": @"Court 2"
                                    },
                                @{
                                    @"id": @"02",
                                    @"date": @"02/16/2014",
                                    @"startTime": @"12:00pm",
                                    @"endTime": @"01:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"03",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @5,
                                    @"location": @"Court 2"
                                    },
                                @{
                                    @"id": @"03",
                                    @"date": @"02/12/2014",
                                    @"startTime": @"11:00am",
                                    @"endTime": @"12:00pm",
                                    @"homeTeam": @"00",
                                    @"awayTeam": @"03",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @5,
                                    @"location": @"Court 1"
                                    },
                                @{
                                    @"id": @"04",
                                    @"date": @"02/15/2014",
                                    @"startTime": @"01:00pm",
                                    @"endTime": @"02:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"03",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @5,
                                    @"location": @"Court 3"
                                },
                                @{
                                    @"id": @"05",
                                    @"date": @"01/20/2014",
                                    @"startTime": @"04:00pm",
                                    @"endTime": @"05:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"01",
                                    @"homeScore": @12,
                                    @"awayScore": @14,
                                    @"status": @1,
                                    @"location": @"Court 2"
                                },
                                @{
                                    @"id": @"05",
                                    @"date": @"01/12/2014",
                                    @"startTime": @"04:00pm",
                                    @"endTime": @"05:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"01",
                                    @"homeScore": @0,
                                    @"awayScore": @0,
                                    @"status": @2,
                                    @"location": @"Court 2"
                                    },
                                @{
                                    @"id": @"05",
                                    @"date": @"01/15/2014",
                                    @"startTime": @"07:00pm",
                                    @"endTime": @"08:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"01",
                                    @"homeScore": @12,
                                    @"awayScore": @14,
                                    @"status": @1,
                                    @"location": @"Court 2"
                                    },
                                @{
                                    @"id": @"05",
                                    @"date": @"01/25/2014",
                                    @"startTime": @"03:00pm",
                                    @"endTime": @"04:00pm",
                                    @"homeTeam": @"02",
                                    @"awayTeam": @"01",
                                    @"homeScore": @19,
                                    @"awayScore": @14,
                                    @"status": @0,
                                    @"location": @"Court 2"
                                    }
                                
                            ],
                        @"playoffs": @[]
                        
                    },
                    @{
                        @"id": @"00",
                        @"name": @"Corec red",
                        @"entryStartDate": @"01/30/2014",
                        @"entryEndDate": @"02/01/2014",
                        @"startDate": @"02/01/2014",
                        @"endDate": @"03/01/2014",
                        @"teams":
                            @[
                                @{
                                    @"id": @"00",
                                    @"name": @"Team Awesome",
                                    @"wins": @2,
                                    @"losses": @3,
                                    @"ties": @0
                                },
                                @{
                                    @"id": @"01",
                                    @"name": @"Cool Catz",
                                    @"wins": @5,
                                    @"losses": @3,
                                    @"ties": @1
                                },
                                @{
                                    @"id": @"02",
                                    @"name": @"Warriors",
                                    @"wins": @8,
                                    @"losses": @2,
                                    @"ties": @0
                                }
                                
                            ],
                        @"games":
                            @[],
                        @"playoffs":
                            @[],
                        
                    }
                ]
        },
       @{
           @"_id": @"01",
           @"name" : @"Basketball",
           @"season" : @3,
           @"leagues":
               @[
                   @{
                       @"id": @"00",
                       @"name": @"Corec black",
                       @"entryStartDate": @"03/15/2014",
                       @"entryEndDate": @"03/17/2014",
                       @"startDate": @"03/20/2014",
                       @"endDate": @"04/20/2014",
                       @"teams":
                           @[
                               @{
                                   @"id": @"00",
                                   @"name": @"Grizzlies",
                                   @"wins": @3,
                                   @"ties": @4,
                                   @"losses": @1
                                },
                               @{
                                    @"id": @"01",
                                    @"name": @"Spurs",
                                    @"wins": @5,
                                    @"ties": @10,
                                    @"losses": @1
                                },
                               @{
                                   @"id": @"02",
                                   @"name": @"Lakers",
                                   @"wins": @10,
                                   @"ties": @3,
                                   @"losses": @1
                                },
                               @{
                                    @"id": @"03",
                                    @"name": @"Heat",
                                    @"wins": @11,
                                    @"ties": @3,
                                    @"losses": @1
                                },
                               
                            ],
                       @"games": @[],
                       @"playoffs": @[]
                    }
                ]
        },
       
       @{
           @"_id": @"02",
           @"name": @"Volleyball",
           @"season": @3,
           @"leagues":
               @[]
        }
       
       ]];
    
	self.tableView = [[UITableView alloc] initWithFrame: self.view.frame style: UITableViewCellStyleDefault];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"%li, %li", indexPath.section, indexPath.row);
    NSLog(@"%@", self.sportsCollection.sports);
    
    IMSport* sport = self.sportsCollection.sports[indexPath.section];
    
    NSLog(@"%@", sport.leagues);
    
    IMLeague* league = sport.leagues[indexPath.row];
    
    cell.textLabel.text = league.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return  self.sportsCollection.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(IMSport*) self.sportsCollection.sports[section] count];
}


#pragma mark - UITableViewDelegate


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueViewController* leagueController = [[LeagueViewController alloc] initWithNibName: @"Intramurals.League" bundle:[NSBundle mainBundle]];
    
    leagueController.title = @"League";
    leagueController.league = [(IMSport*) self.sportsCollection.sports[indexPath.section] leagues][indexPath.row];
    
    [self.navigationController pushViewController: leagueController
                                         animated: YES];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = .75;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
    
    titleLabel.text = [(IMSport*) self.sportsCollection.sports[section] name];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview: titleLabel];
    
    return view;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

@end
