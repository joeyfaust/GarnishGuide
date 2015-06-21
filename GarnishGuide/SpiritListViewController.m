//
//  SpiritListViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/19/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "SpiritListViewController.h"
#import "Spirit.h"
#import "SpiritListViewCell.h"
#import "SpiritSearchTableViewController.h"

@interface SpiritListViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray* spiritList;

@end

@implementation SpiritListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.spiritList = [Spirit generateSpiritList];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.spiritList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpiritListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.spirit = self.spiritList[indexPath.row];
    return cell;
}

#pragma mark - Navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SpiritSearchTableViewController* destViewController = [segue destinationViewController];
    SpiritListViewCell* cell = sender;
    
    destViewController.spirit = cell.spirit;
}


@end
