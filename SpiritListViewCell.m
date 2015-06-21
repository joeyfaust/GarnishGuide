//
//  SpiritListViewCell.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "SpiritListViewCell.h"

@interface SpiritListViewCell()

@property (nonatomic,strong) IBOutlet UILabel* nameLabel;

@end

@implementation SpiritListViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSpirit:(Spirit *)spirit {
    _spirit = spirit;
    self.nameLabel.text = self.spirit.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
