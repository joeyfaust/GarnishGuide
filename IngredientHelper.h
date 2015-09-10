//
//  IngredientHelper.h
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IngredientHelper : NSObject

-(IngredientHelper*) initWithConfigs;
-(void)getFullIngredientList:(void(^)(NSArray*,NSError*))completion;

@end
