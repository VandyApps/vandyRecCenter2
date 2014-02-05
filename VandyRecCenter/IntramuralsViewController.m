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
                        @"games": @[],
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
    
    self.demoData = @{
                      
                      @"Basketball" :
                        @[
                           @"Black League 1",
                           @"Black League 2",
                           @"Black League 3",
                           @"Fraternity League",
                           @"Cool League",
                           @"Lame League"
                              
                        ],
                      @"Football" :
                        @[
                            @"Green League",
                            @"Black League",
                            @"Blue League",
                            @"Orange League",
                            @"Teal League",
                            @"Lightish-Grayish-Blue League"
                            
                              
                        ],
                      @"Volleyball" :
                        @[
                              @"Co-ed League",
                              @"Orange League",
                              @"Red League",
                              @"Girl's League",
                              @"Boy's League",
                              @"Men's League",
                              @"Women's League"
                        ]
                      };
    
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

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [(IMSport*) self.sportsCollection.sports[section] name];
}


#pragma mark - UITableViewDelegate


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueViewController* leagueController = [[LeagueViewController alloc] initWithNibName: @"Intramurals.League" bundle:[NSBundle mainBundle]];
    
    leagueController.title = @"League";
    [self.navigationController pushViewController: leagueController
                                         animated: YES];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = .75;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
    
    titleLabel.text = [self.demoData allKeys][section];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview: titleLabel];
    
    return view;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

@end
