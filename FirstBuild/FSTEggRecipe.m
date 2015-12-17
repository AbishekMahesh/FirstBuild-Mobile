//
//  FSTEggRecipe.m
//  FirstBuild
//
//  Created by Myles Caley on 12/17/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTEggRecipe.h"

@implementation FSTEggRecipe

- (id) init
{
    self = [super init];
    if (self)
    {
        self.name = @"Eggs";
        self.recipeType = [NSNumber numberWithInt: FSTRecipeTypeFirstBuildSousVide];
    }
    return self;
    
}

@end
