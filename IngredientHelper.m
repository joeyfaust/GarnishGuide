//
//  IngredientHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientHelper.h"
#import "Ingredient.h"

@interface IngredientHelper()

@property (nonatomic,strong) NSDictionary* properties;

@end

@implementation IngredientHelper

-(IngredientHelper *)initWithConfigs {
    self = [[IngredientHelper alloc] init];
    
    self.properties = [PropertyHelper readPropertyFile:PROPERTIES_FILE];
    
    return self;
}

-(void)getFullIngredientList:(void (^)(NSArray *, NSError *))completion {
    NSMutableArray* ingredientArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    [ingredientArray addObject:[[Ingredient alloc] initWithName:@"Bitters"] ];
    [ingredientArray addObject:[[Ingredient alloc] initWithName:@"Rum"] ];
    [ingredientArray addObject:[[Ingredient alloc] initWithName:@"Tonic"] ];
    [ingredientArray addObject:[[Ingredient alloc] initWithName:@"Orange Juice"] ];
    
    completion(ingredientArray,nil);
}

@end
