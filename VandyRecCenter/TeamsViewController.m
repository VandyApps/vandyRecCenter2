//
//  IntramuralTeamsViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "TeamsViewController.h"

@interface TeamsViewController ()

@property (nonatomic) CGSize size;

@end

@implementation TeamsViewController


#pragma mark - Initializer

- (id) initWithContentSize: (CGSize) size {
    if (self = [super init]) {
        self.size = size;
    }
    return self;
}
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
#warning Add variables for sizes
    
    self.teamView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 140)];
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height - 140)];
    
    self.teamView.backgroundColor = [UIColor orangeColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSLog(@"Height: %g", self.view.frame.size.height);
    
    
    [self.view addSubview: self.teamView];
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Datasource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"Team Name Here";
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


#pragma mark - Table View Delegate

@end
