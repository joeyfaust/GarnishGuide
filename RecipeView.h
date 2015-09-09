//
//  RecipeView.h
//  GarnishGuide
//
//  Created by Joey Faust on 8/27/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeView : UIScrollView

@property (nonatomic,strong) Recipe* recipe;

-(void) setText;
-(void) setImage;

@end
