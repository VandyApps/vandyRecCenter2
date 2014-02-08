//
//  IntramuralSeasonViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "GamesViewController.h"

#import "IMGame.h"
#import "IMGames.h"


@implementation GamesViewController

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
    NSLog(@"%lu", self.gamesCollection.count);
    
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
