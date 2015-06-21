//
//  Spirit.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "Spirit.h"

@implementation Spirit

+ (NSArray*) generateSpiritList {
    
    Spirit* vodka = [Spirit initWithName:@"Vodka"];
    Spirit* rum = [Spirit initWithName:@"Rum"];
    Spirit* whisky = [Spirit initWithName:@"Whisky"];
    Spirit* tequila = [Spirit initWithName:@"Tequila"];
    return @[vodka,rum,whisky,tequila];
    
}

+ (Spirit*) initWithName:(NSString *)name {
    Spirit* spirit = [[Spirit alloc] init];
    spirit.name = name;
    return spirit;
}

@end
