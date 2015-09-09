//
//  PropertyHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 8/25/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "PropertyHelper.h"

@implementation PropertyHelper

static NSString* propFileExtension = @"plist";

+(NSDictionary*) readPropertyFile:(NSString*) propFileName {
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:propFileName ofType:propFileExtension];
    NSData* plistData = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSError* errorDesc = nil;
    NSPropertyListFormat plistFormat;
    
    NSDictionary* propFile = (NSDictionary*)[NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainersAndLeaves format:&plistFormat error:&errorDesc];
    
    if(!propFile) {
        NSLog(@"Error reading plist: %@", errorDesc);
        return nil;
    }
    else {
        return propFile;
    }
}

@end
