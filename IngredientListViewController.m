//
//  IngredientsListViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientListViewController.h"
#import "IngredientListViewCell.h"
#import "IngredientHelper.h"
#import "IngredientSearchTableViewController.h"

@interface IngredientListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSArray* ingredientList;
@property (nonatomic,strong) IngredientHelper* helper;
@property (nonatomic,strong) IBOutlet UITableView* tableView;

@end

@implementation IngredientListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    
    self.helper = [[IngredientHelper alloc] initWithConfigs];
    [self.helper getFullIngredientList:^(NSArray * ingredients, NSError * error) {
        self.ingredientList = ingredients;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.ingredientList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientListViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    [cell setIngredient:ingredient];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    ingredient.selected = YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    Ingredient* ingredient = self.ingredientList[indexPath.row];
    ingredient.selected = NO;
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
    destViewController.inclusive = NO;
}

@end
