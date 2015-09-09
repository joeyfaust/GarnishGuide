//
//  ConnectionHelper.h
//  GarnishGuide
//
//  Created by Joey Faust on 8/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionHelper : NSObject
+(ConnectionHelper*) mainConnectionHelper;
-(void) getJSONAsync:(NSString*) fullURL completion:(void (^)(NSDictionary*,NSError*)) completion;
-(void) getDataAsync:(NSString*) fullURL completion:(void (^)(NSData*,NSError*)) completion;
@end
