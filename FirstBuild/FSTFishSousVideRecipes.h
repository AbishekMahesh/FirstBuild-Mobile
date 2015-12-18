//
//  FSTFishSousVideRecipes.h
//  FirstBuild
//
//  Created by Myles Caley on 12/18/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTSousVideRecipes.h"
#import "FSTFishFilletSousVideRecipe.h"
#import "FSTFishSteakSousVideRecipe.h"

@interface FSTFishSousVideRecipes : FSTSousVideRecipes
@property (nonatomic, retain) NSArray* thicknesses;
@property (nonatomic, retain) NSDictionary* thicknessLabels;
@property (nonatomic, retain) NSArray* donenesses;
@property (nonatomic, retain) NSDictionary* donenessLabels;

@property (nonatomic, retain) NSDictionary* cookingTimes;
@end
