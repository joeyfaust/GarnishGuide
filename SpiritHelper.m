//
//  SpiritHelper.m
//  GarnishGuide
//
//  Created by Joey Faust on 8/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "SpiritHelper.h"
#import "Spirit.h"
#import "ConnectionHelper.h"

@interface SpiritHelper()

@property (nonatomic,strong) NSDictionary* properties;
@property (nonatomic,strong) NSArray* spirits;

@end

@implementation SpiritHelper

-(SpiritHelper*) initWithConfigs {
    self = [[SpiritHelper alloc] init];
    
    self.properties = [PropertyHelper readPropertyFile:PROPERTIES_FILE];
    NSArray* spiritNames = self.properties[@"spirits"];
    
    NSMutableArray* spiritList = [[NSMutableArray alloc] initWithCapacity:[self.spirits count]];
    for(NSDictionary* spiritName in spiritNames) {
        NSString* name = spiritName[@"name"];
        NSString* imageUrl = spiritName[@"image-url"];
        [spiritList addObject:[[Spirit alloc] initWithName:name andImageUri:imageUrl]];
    }
    self.spirits = spiritList;
    
    return self;
}

-(NSArray*) getSpiritList {
    return self.spirits;
}

-(void) loadSpiritImages:(NSArray *)spirits {
    
    ConnectionHelper* connectionHelper = [ConnectionHelper mainConnectionHelper];
    __weak SpiritHelper* weakSelf = self;
    for(Spirit* spirit in spirits) {
        [connectionHelper getDataAsync:spirit.imageUri completion:^(NSData * data, NSError * error) {
            spirit.image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.delegate spiritImageLoaded:spirit];
            });
        }];
    }
    
}

@end
