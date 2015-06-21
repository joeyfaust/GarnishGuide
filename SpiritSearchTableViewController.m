//
//  SpiritSearchViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "SpiritSearchTableViewController.h"
#import "Spirit.h"
#import "SpiritSearchViewCell.h"
#import "RecipeViewController.h"

@interface SpiritSearchTableViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) NSArray* recipeList;

@end

@implementation SpiritSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup search controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    
    // Load all recipes for given spirit
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpiritSearchViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.recipe = self.recipeList[indexPath.row];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RecipeViewController* destViewController = [segue destinationViewController];
    SpiritSearchViewCell* cell = sender;
    destViewController.recipe = cell.recipe;
}


#pragma mark - Search Results Updating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // update recipe list for subset
}

@end
