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
#import "RecipeHelper.h"

@interface SpiritSearchTableViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) NSArray* recipeList;
@property (nonatomic,strong) NSArray* filteredRecipeList;
@property (nonatomic,strong) RecipeHelper* helper;

-(NSArray*) filterRecipesForSearchText:(NSString*)searchText;

@end

@implementation SpiritSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Manual setup of search controller
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    self.title = self.spirit.name;
    
    // Load all recipes for given spirit
    self.helper = [[RecipeHelper alloc] initWithConfigs];
    [self.helper getAllRecipesForSpirit:self.spirit completion:^(NSArray * recipeList, NSError * error) {
        self.recipeList = recipeList;
        self.filteredRecipeList = recipeList;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredRecipeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpiritSearchViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setRecipe:self.filteredRecipeList[indexPath.row]];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RecipeViewController* destViewController = [segue destinationViewController];
    SpiritSearchViewCell* cell = sender;
    [destViewController setRecipe:cell.recipe];
    destViewController.title = cell.recipe.name;
}

#pragma mark - Search Results Updating

-(NSArray*)filterRecipesForSearchText:(NSString *)searchText {
    
    NSPredicate* resultPredicate = [NSPredicate predicateWithFormat: @"name contains [c] %@", searchText];
    return [self.recipeList filteredArrayUsingPredicate:resultPredicate];
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString* searchString = searchController.searchBar.text;
    if([searchString isEqual:@""]) {
        self.filteredRecipeList = self.recipeList;
    }
    else {
        self.filteredRecipeList = [self filterRecipesForSearchText:searchString];
    }
    [self.tableView reloadData];
    
}

-(void) searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

@end
