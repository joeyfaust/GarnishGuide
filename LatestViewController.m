//
//  RecipeViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "LatestViewController.h"
#import "Recipe.h"
#import "RecipeHelper.h"
#import "RecipeView.h"

@interface LatestViewController () <UIScrollViewDelegate,RecipeLoadedDelegate>

@property (nonatomic,strong) IBOutlet RecipeView* recipeView;

@property (nonatomic,strong) RecipeHelper* helper;

@end

@implementation LatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helper = [[RecipeHelper alloc] initWithConfigs];
    self.helper.delegate = self;
    
    [self.helper getLatestRecipe:^(Recipe * latestRecipe, NSError * error) {
        if(latestRecipe) {
            self.recipeView.recipe = latestRecipe;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.recipeView setText];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setRecipe:(Recipe *)recipe {
    self.recipeView.recipe = recipe;
}

#pragma mark - UIScrollViewDelegate
/*
 -(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}
*/

#pragma mark - RecipeLoadedDelegate

-(void)recipeImageLoaded:(Recipe *)recipe {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.recipeView setImage];
    });
}

@end
