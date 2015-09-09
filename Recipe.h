//
//  Recipe.h
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic,strong) NSString* postId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) UIImage* image;
@property (nonatomic,strong) NSArray* tags;
@property (nonatomic,strong) NSString* recipe;
@property (nonatomic,strong) NSString* imageURI;

-(Recipe*) initFromDictionary:(NSDictionary*) dictionary;

@end
