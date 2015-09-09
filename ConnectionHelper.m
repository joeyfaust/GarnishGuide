//
//  ConnectionHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 8/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "ConnectionHelper.h"

@interface ConnectionHelper()
-(NSOperationQueue*) internalQueue;
@end

@implementation ConnectionHelper
static ConnectionHelper* mainHelper;
+(ConnectionHelper*) mainConnectionHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainHelper = [[ConnectionHelper alloc] init];
    });
    return mainHelper;
}

static NSOperationQueue* queue;
-(NSOperationQueue*) internalQueue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc] init];
    });
    return queue;
}

-(void)getDataAsync:(NSString *)fullURL completion:(void (^)(NSData *, NSError *))completion {
    NSURL* requestURL = [NSURL URLWithString:fullURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:requestURL];
    [NSURLConnection sendAsynchronousRequest:request queue:[self internalQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        completion(data,connectionError);
        
    }];
}

-(void)getJSONAsync:(NSString *)fullURL completion:(void (^)(NSDictionary *, NSError *))completion {
    
    [self getDataAsync:fullURL completion:^(NSData * data, NSError * connectionError) {
        
        if (connectionError) {
            completion(nil,connectionError);
        }
        else {
            NSError* jsonError;
            NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if(jsonError) {
                completion(nil,jsonError);
            }
            else {
                completion(dictionary,nil);
            }
        }

    }];

}

@end
