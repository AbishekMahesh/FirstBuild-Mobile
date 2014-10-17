//
//  Sharer.m
//  CFShareCircle
//
//  Created by Camden on 1/15/13.
//  Copyright (c) 2013 Camden. All rights reserved.
//

#import "CFSharer.h"

@implementation CFSharer

@synthesize name = _name;
@synthesize image = _image;

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName {
    self = [super init];
    if (self) {
        _name = name;
        _image = [UIImage imageNamed:imageName];
    }
    return self;    
}

+ (CFSharer *)beer {
    return [[CFSharer alloc] initWithName:@"Beer Tracker" imageName:@"beer.png"];
}

+ (CFSharer *)scale {
    return [[CFSharer alloc] initWithName:@"Milk Minder" imageName:@"scale.png"];
}

+ (CFSharer *)quickchill {
    return [[CFSharer alloc] initWithName:@"QuickChill" imageName:@"quickchill.png"];
}



@end
