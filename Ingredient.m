//
//  Ingredient.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

-(Ingredient *)initWithName:(NSString *)name {
    self = [[Ingredient alloc] init];
    _name = name;
    _selected = NO;
    return self;
}

-(NSString *)description {
    return self.name;
}

@end
