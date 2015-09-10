//
//  RecipeHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 8/22/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "RecipeHelper.h"
#import "Recipe.h"
#import "Ingredient.h"
#import "ConnectionHelper.h"

@interface RecipeHelper()
-(void) getSomeRecipes: (NSInteger)num completion:(void(^)(NSArray*,NSError*)) completion;
-(void) getRecipesForQuery: (NSString*) queryString completion:(void(^)(NSArray*,NSError*)) completion;

@property (nonatomic,strong) NSDictionary* properties;
@end

@implementation RecipeHelper

-(RecipeHelper*) initWithConfigs {
    self = [[RecipeHelper alloc] init];
    self.properties = [PropertyHelper readPropertyFile:PROPERTIES_FILE];
    
    return self;
}

-(void) getSomeRecipes:(NSInteger)num completion:(void (^)(NSArray*, NSError *))completion {
    ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
    NSString* fullUrl = [NSString stringWithFormat:
                         self.properties[@"posts-url-latest"],
                         self.properties[@"blog-id"],
                         [@(num) stringValue],
                         self.properties[@"api-key"]];
    [connectionHelper getJSONAsync:fullUrl completion:^(NSDictionary * postsDictionary, NSError * error) {
        NSArray* posts = postsDictionary[LIST_ITEMS];
        completion(posts,error);
    }];
}

-(void)getRecipesForQuery:(NSString *)queryString completion:(void (^)(NSArray *, NSError *))completion {
    ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
    NSString* fullUrl = [NSString stringWithFormat:
                         self.properties[@"posts-url-query"],
                         self.properties[@"blog-id"],
                         queryString,
                         self.properties[@"api-key"]];
    [connectionHelper getJSONAsync:fullUrl completion:^(NSDictionary * postsDictionary, NSError * error) {
        NSArray* posts = postsDictionary[LIST_ITEMS];
        NSMutableArray* recipes = [[NSMutableArray alloc] initWithCapacity:[posts count]];
        for(NSDictionary* post in posts) {
            Recipe* recipe = [[Recipe alloc] initFromDictionary:post];
            [recipes addObject:recipe];
        }
        completion(recipes,error);
    }];
}

-(void) getAllRecipesForSpirit:(Spirit *)spirit completion:(void (^)(NSArray *, NSError *))completion {
    NSString* queryString = self.properties[@"query-label"];
    queryString = [queryString stringByAppendingString:spirit.name];
    [self getRecipesForQuery:queryString completion:^(NSArray * recipes, NSError * error) {
        completion(recipes,error);
    }];
}

-(void)getRecipesForIngredient:(NSArray *)ingredientList completion:(void (^)(NSArray *, NSError *))completion {
    NSString* queryString = self.properties[@"query-label"];
    NSString* queryAnd = self.properties[@"query-and-delim"];
    queryString = [queryString stringByAppendingString:[ingredientList componentsJoinedByString:queryAnd]];
    [self getRecipesForQuery:queryString completion:^(NSArray * recipes, NSError * error) {
        completion(recipes,error);
    }];
}

-(void) getLatestRecipe:(void (^)(Recipe *, NSError *))completion {
    [self getSomeRecipes:1 completion:^(NSArray * recipeList, NSError * error) {
        if(!recipeList || !recipeList[0]) {
            completion(nil,error);
        }
        else {
            ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
            
            // Get full post from header post
            NSDictionary* postsEntry = recipeList[0];
            NSString* postID = postsEntry[POST_ID];
            NSString* postURI = [NSString stringWithFormat:
                                 self.properties[@"post-url"],
                                 self.properties[@"blog-id"],
                                 postID,
                                 self.properties[@"api-key"]];
            [connectionHelper getJSONAsync:postURI completion:^(NSDictionary * post, NSError * error) {
                if(!post || !post[POST_ID]) {
                    completion(nil,error);
                }
                else {
                    Recipe* recipe = [[Recipe alloc] initFromDictionary:post];
                    
                    [self loadRecipeImage:recipe];
                    
                    completion(recipe,error);
                }
            }];
        }
    }];
}

-(void) loadRecipeImage:(Recipe *)recipe {
    ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
    __weak RecipeHelper* weakSelf = self;
    [connectionHelper getDataAsync:recipe.imageURI completion:^(NSData * data, NSError * error) {
        recipe.image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.delegate recipeImageLoaded:recipe];
        });
    }];
}

@end
