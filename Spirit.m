//
//  Spirit.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "Spirit.h"

@implementation Spirit

- (Spirit*) initWithName:(NSString *)name andImageUri:(NSString *)imageUri {
    self = [[Spirit alloc] init];
    self.name = name;
    self.imageUri = imageUri;
    return self;
}

@end
