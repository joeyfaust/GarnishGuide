//
//  SpiritHelper.h
//  GarnishGuide
//
//  Created by Joey Faust on 8/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Spirit.h"

@protocol SpiritLoadedDelegate
-(void)spiritImageLoaded:(Spirit*)spirit;
@end

@interface SpiritHelper : NSObject

@property (nonatomic,strong) id<SpiritLoadedDelegate> delegate;

-(SpiritHelper*) initWithConfigs;

-(NSArray*) getSpiritList;
-(void) loadSpiritImages:(NSArray*) spirits;
@end
