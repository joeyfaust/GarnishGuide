//
//  IngredientsListViewCell.m
//  GarnishGuide
//
//  Created by Joey Faust on 9/8/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "IngredientsListViewCell.h"

@interface IngredientsListViewCell()

@property (nonatomic,strong) IBOutlet UILabel* label;

@end

@implementation IngredientsListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setIngredient:(Ingredient *)ingredient {
    _ingredient = ingredient;
    if (_ingredient) {
        [self.label setText:self.ingredient.name];
    }
    
}

@end
