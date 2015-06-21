//
//  SpiritSearchViewController.h
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spirit.h"

@interface SpiritSearchTableViewController : UITableViewController

@property (nonatomic,strong) UISearchController* searchController;
@property (nonatomic,strong) Spirit* spirit;

@end
