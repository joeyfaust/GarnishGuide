//
//  RecipeViewController.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "RecipeViewController.h"
#import "Recipe.h"
#import "RecipeHelper.h"
#import "RecipeView.h"

@interface RecipeViewController () <UIScrollViewDelegate,RecipeLoadedDelegate>

@property (nonatomic,strong) IBOutlet RecipeView* recipeView;
@property (nonatomic,strong) Recipe* recipe;

@property (nonatomic,strong) RecipeHelper* helper;

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helper = [[RecipeHelper alloc] initWithConfigs];
    self.helper.delegate = self;
    
    if (self.recipe && !self.recipeView.recipe) {
        self.recipeView.recipe = self.recipe;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.recipeView setText];
        });
    }
    
    if (self.recipeView.recipe) {
        [self.helper loadRecipeImage:self.recipeView.recipe];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setRecipe:(Recipe *)recipe {
    if (self.recipeView) {
        self.recipeView.recipe = recipe;
    }
    
    _recipe = recipe;
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
