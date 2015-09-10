//
//  Ingredient.h
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) BOOL selected;

-(Ingredient*) initWithName:(NSString*) name;

@end
