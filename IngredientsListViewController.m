//
//  IngredientsListViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientsListViewController.h"
#import "IngredientsListViewCell.h"
#import "IngredientHelper.h"
#import "IngredientSearchTableViewController.h"

@interface IngredientsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UIButton* searchButton;
@property (nonatomic,strong) NSArray* ingredientList;
@property (nonatomic,strong) IngredientHelper* helper;

@end

@implementation IngredientsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    
    self.helper = [[IngredientHelper alloc] initWithConfigs];
    self.ingredientList = [self.helper getFullIngredientList];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.ingredientList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientsListViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    [cell setIngredient:ingredient];
    
    if(ingredient.selected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientsListViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    ingredient.selected = YES;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientsListViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    ingredient.selected = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - Navigation

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IngredientSearchTableViewController* destViewController = [segue destinationViewController];
    
    NSMutableArray* filteredIngredientList = [[NSMutableArray alloc] init];
    for (Ingredient* ingredient in self.ingredientList) {
        if (ingredient.selected) {
            [filteredIngredientList addObject:ingredient];
        }
    }
    
    destViewController.ingredientList = filteredIngredientList;
}

@end
