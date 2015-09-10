//
//  IngredientSearchViewCell.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/9/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientSearchViewCell.h"
#import "Recipe.h"

@interface IngredientSearchViewCell()

@property (nonatomic,strong) IBOutlet UILabel* label;

@end

@implementation IngredientSearchViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRecipe:(Recipe *)recipe {
    _recipe = recipe;
    self.label.text = recipe.name;
}

@end
