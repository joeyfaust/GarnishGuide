//
//  IngredientHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientHelper.h"
#import "Ingredient.h"
#import "ConnectionHelper.h"

@interface IngredientHelper()

@property (nonatomic,strong) NSDictionary* properties;

-(void) getIngredientPageRecursive:(NSMutableArray*)labels pageToken:(NSString*)pageToken completion:(void(^)(NSArray*, NSError*)) completion;

@end

@implementation IngredientHelper

-(IngredientHelper *)initWithConfigs {
    self = [[IngredientHelper alloc] init];
    
    self.properties = [PropertyHelper readPropertyFile:PROPERTIES_FILE];
    
    return self;
}

-(void)getFullIngredientList:(void (^)(NSArray *, NSError *))completion {
    NSMutableArray* labels = [[NSMutableArray alloc] init];
    
    [self getIngredientPageRecursive:labels pageToken:nil completion:^(NSArray * resultLabels, NSError * error) {
        NSMutableArray* ingredientList = [[NSMutableArray alloc] initWithCapacity:[resultLabels count]];
        for(NSString* label in resultLabels) {
            Ingredient* ingredient = [[Ingredient alloc] initWithName:label];
            [ingredientList addObject:ingredient];
        }
        
        // Order alphabetically
        NSSortDescriptor* ingredientSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [ingredientList sortUsingDescriptors:@[ingredientSortDescriptor]];
        
        completion(ingredientList,error);
    }];
}

-(void)getIngredientPageRecursive:(NSMutableArray*)labels pageToken:(NSString *)pageToken completion:(void (^)(NSArray *, NSError *))completion {
    ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
    
    // Format URL for page 1 or N
    NSString* fullUrl = nil;
    if(pageToken) {
        fullUrl = [NSString stringWithFormat:
                   self.properties[@"posts-url-labels-page"],
                   self.properties[@"blog-id"],
                   pageToken,
                   self.properties[@"api-key"]];
    }
    else {
        fullUrl = [NSString stringWithFormat:
                   self.properties[@"posts-url-labels"],
                   self.properties[@"blog-id"],
                   self.properties[@"api-key"]];
    }
    
    [connectionHelper getJSONAsync:fullUrl completion:^(NSDictionary * result, NSError * error) {
        NSString* newPageToken = result[NEXT_PAGE_TOKEN];
        NSArray* listItems = result[LIST_ITEMS];
        
        for(NSDictionary* listItem in listItems) {
            NSArray* listLabels = listItem[LIST_LABELS];
            for(NSString* label in listLabels) {
                
                // Add new labels
                if(![labels containsObject:label]) {
                    [labels addObject:label];
                }
                
            }
        }
        
        if(newPageToken) {
            [self getIngredientPageRecursive:labels pageToken:newPageToken completion:^(NSArray * newResult, NSError * newError) {
                completion(newResult,newError);
            }];
        }
        else {
            completion(labels,error);
        }
        
    }];
}

@end
