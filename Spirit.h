//
//  Spirit.h
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spirit : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* imageUri;
@property (nonatomic,strong) UIImage* image;

- (Spirit*) initWithName:(NSString*)name andImageUri:(NSString*) imageUri;

@end
