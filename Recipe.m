//
//  Recipe.m
//  GarnishGuide
//
//  Created by Joey Faust on 6/20/15.
//  Copyright (c) 2015 Garnish Girl. All rights reserved.
//

#import "Recipe.h"

@interface Recipe()
-(NSString*) getImageURIFromContent:(NSString*) content;
-(NSString*) removeMarkupFromContent:(NSString*) content;
@end

@implementation Recipe

-(Recipe*) initFromDictionary:(NSDictionary *)dictionary {
    Recipe* recipe = [[Recipe alloc] init];
    
    recipe.postId = dictionary[POST_ID];
    recipe.name = dictionary[POST_NAME];
    
    // Get data from big content string
    NSString* content = dictionary[POST_CONTENT];
    recipe.imageURI = [self getImageURIFromContent:content];
    recipe.recipe = [self removeMarkupFromContent:content];
    
    return recipe;
}

-(NSString*) getImageURIFromContent:(NSString *)content {
    
    // Find first img tag
    NSRegularExpression* imgRegex = [NSRegularExpression
                                  regularExpressionWithPattern:@"<img[^>]+>"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSRange imgMatch = [imgRegex rangeOfFirstMatchInString:content options:0 range:NSMakeRange(0, [content length])];
    
    NSString* imgTag = [content substringWithRange:imgMatch];
    
    // Extract URI
    NSRange uriRange1 = [imgTag rangeOfString:@"http"];
    NSString* imgUri = [imgTag substringFromIndex:uriRange1.location];
    NSRange uriRange2 = [imgUri rangeOfString:@"\""];
    imgUri = [imgUri substringToIndex:uriRange2.location];
    
    return imgUri;
    
}

-(NSString*) removeMarkupFromContent:(NSString *)content {
    // Find image tags that close
    NSRegularExpression* imgRegex1 = [NSRegularExpression
                                     regularExpressionWithPattern:@"<img.+/>"
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    content = [imgRegex1 stringByReplacingMatchesInString:content
                                     options:0
                                     range:NSMakeRange(0,[content length])
                                     withTemplate:@""];
    
    // Find image tags that bookend
    NSRegularExpression* imgRegex2 = [NSRegularExpression
                                     regularExpressionWithPattern:@"<img.+img>"
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    
    content = [imgRegex2 stringByReplacingMatchesInString:content
                                     options:0
                                     range:NSMakeRange(0,[content length])
                                     withTemplate:@""];
    // Find links
    NSRegularExpression* imgRegex3 = [NSRegularExpression
                                     regularExpressionWithPattern:@"<[/]?a[^>]*>"
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    content = [imgRegex3 stringByReplacingMatchesInString:content
                                     options:0
                                     range:NSMakeRange(0,[content length])
                                     withTemplate:@""];
    
    // Find divs
    NSRegularExpression* imgRegex4 = [NSRegularExpression
                                     regularExpressionWithPattern:@"<[/]?div[^/]*>"
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    content = [imgRegex4 stringByReplacingMatchesInString:content
                                     options:0
                                     range:NSMakeRange(0,[content length])
                                     withTemplate:@""];
    
    // Reduce extra new lines
    NSRegularExpression* imgRegex5 = [NSRegularExpression
                                     regularExpressionWithPattern:@"<br />[\n]*<br />[\n]*<br />"
                                     options:NSRegularExpressionCaseInsensitive
                                     error:nil];
    content = [imgRegex5 stringByReplacingMatchesInString:content
                                     options:0
                                     range:NSMakeRange(0,[content length])
                                     withTemplate:@"<br /><br />"];
    
    return content;
}

-(NSString *)description {
    return self.name;
}

@end
