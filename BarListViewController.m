//
//  BarListViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/25/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "BarListViewController.h"
#import "IngredientHelper.h"
#import "IngredientListViewCell.h"
#import "BarSearchTableViewController.h"

@interface BarListViewController () <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) NSArray* ingredientList;
@property (nonatomic,strong) IngredientHelper* helper;
@property (nonatomic,strong) IBOutlet UITableView* tableView;

@property (nonatomic,strong) NSString* libraryPath;

@end

@implementation BarListViewController


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
    
    // Retrieve ingredientList, if it exists
    NSString* libraryDir = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.libraryPath = [libraryDir stringByAppendingPathComponent:BAR_TEMP_FILE];
    NSArray* selectedIngredients = [[NSArray alloc] init];
    if([[NSFileManager defaultManager] fileExistsAtPath:self.libraryPath]) {
        selectedIngredients = [NSKeyedUnarchiver unarchiveObjectWithFile:self.libraryPath];
    }
    
    // Select ingredients in list based on file
    for(Ingredient* ingredient in self.ingredientList) {
        if([selectedIngredients containsObject:ingredient]) {
            ingredient.selected = YES;
            NSInteger index = [self.ingredientList indexOfObject:ingredient];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
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
    BarSearchTableViewController* destViewController = [segue destinationViewController];
    
    NSMutableArray* filteredIngredientList = [[NSMutableArray alloc] init];
    for (Ingredient* ingredient in self.ingredientList) {
        if (ingredient.selected) {
            [filteredIngredientList addObject:ingredient];
        }
    }
    
    // Write bar list to disk
    [NSKeyedArchiver archiveRootObject:filteredIngredientList toFile:self.libraryPath];
    
    destViewController.ingredientList = filteredIngredientList;
}

-(void)viewWillDisappear:(BOOL)animated {
    NSMutableArray* filteredIngredientList = [[NSMutableArray alloc] init];
    for (Ingredient* ingredient in self.ingredientList) {
        if (ingredient.selected) {
            [filteredIngredientList addObject:ingredient];
        }
    }
    
    // Write bar list to disk
    [NSKeyedArchiver archiveRootObject:filteredIngredientList toFile:self.libraryPath];
}

@end
