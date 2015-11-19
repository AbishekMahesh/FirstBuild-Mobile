//
//  FSTBeefSousVideRecipes.m
//  FirstBuild
//
//  Created by Myles Caley on 11/19/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTBeefSousVideRecipes.h"
#import "FSTBeefSteakSousVideRecipe.h"

@implementation FSTBeefSousVideRecipes

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.recipes = [[NSArray alloc] initWithObjects:
                        [FSTBeefSteakSousVideRecipe new],
                        nil];
    }
    return self;
}

@end
