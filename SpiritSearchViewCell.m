//
//  SpiritSearchViewCell.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "SpiritSearchViewCell.h"

@interface SpiritSearchViewCell()

@property (nonatomic,strong) IBOutlet UILabel* label;

@end

@implementation SpiritSearchViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setRecipe:(Recipe *)recipe {
    _recipe = recipe;
    if(_recipe) {
        [self.label setText:self.recipe.name];
    }
}

@end
