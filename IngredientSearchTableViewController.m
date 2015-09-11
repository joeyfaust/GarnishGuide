//
//  IngredientSearchTableViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/9/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientSearchTableViewController.h"
#import "IngredientSearchViewCell.h"
#import "RecipeHelper.h"
#import "RecipeViewController.h"

@interface IngredientSearchTableViewController ()

@property (nonatomic,strong) NSArray* recipeList;
@property (nonatomic,strong) RecipeHelper* helper;

@end

@implementation IngredientSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helper = [[RecipeHelper alloc] initWithConfigs];
    [self.helper getRecipesForIngredient:self.ingredientList completion:^(NSArray * recipes, NSError * error) {
        self.recipeList = recipes;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IngredientSearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    [cell setRecipe:self.recipeList[indexPath.row]];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RecipeViewController* destViewController = [segue destinationViewController];
    IngredientSearchViewCell* cell = sender;
    [destViewController setRecipe:cell.recipe];
    destViewController.title = cell.recipe.name;
}


@end
