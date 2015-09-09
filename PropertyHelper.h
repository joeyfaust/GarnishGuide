//
//  PropertyHelper.h
//  GarnishGuide
//
//  Created by Joey Faust on 8/25/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyHelper : NSObject
+(NSDictionary*) readPropertyFile:(NSString*) propFileName;
@end
