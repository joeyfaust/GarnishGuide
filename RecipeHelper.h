//
//  RecipeHelper.h
//  GarnishGuide
//
//  Created by Joey Faust on 8/22/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "Spirit.h"

@protocol RecipeLoadedDelegate
-(void)recipeImageLoaded:(Recipe*)recipe;
@end

@interface RecipeHelper : NSObject
@property (nonatomic,strong) id<RecipeLoadedDelegate> delegate;

-(RecipeHelper*) initWithConfigs;

-(void) loadRecipeImage:(Recipe*) recipe;
-(void) getLatestRecipe:(void(^)(Recipe*,NSError*)) completion;
-(void) getAllRecipesForSpirit:(Spirit*) spirit completion:(void(^)(NSArray*,NSError*)) completion;
@end
