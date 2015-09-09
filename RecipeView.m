//
//  RecipeView.m
//  GarnishGuide
//
//  Created by Joey Faust on 8/27/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "RecipeView.h"
#import "Recipe.h"

@interface RecipeView()

@property (nonatomic,strong) IBOutlet UILabel* headerLabel;
@property (nonatomic,strong) IBOutlet UIWebView* contentView;
@property (nonatomic,strong) IBOutlet UIImageView* headerImageView;

@end

@implementation RecipeView

-(void)setText {
    if(self.recipe) {
        [self.headerLabel setText:self.recipe.name];
        [self.contentView loadHTMLString:self.recipe.recipe baseURL:nil];
    }
}

-(void)setImage {
    if(self.recipe && self.recipe.image) {
        [self.headerImageView setImage:self.recipe.image];
    }
}

@end
