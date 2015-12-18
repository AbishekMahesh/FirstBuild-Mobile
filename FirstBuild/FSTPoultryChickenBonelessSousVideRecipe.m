//
//  FSTPoultryChickenBonelessSousVideRecipe.m
//  FirstBuild
//
//  Created by Myles Caley on 12/18/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTPoultryChickenBonelessSousVideRecipe.h"

@implementation FSTPoultryChickenBonelessSousVideRecipe
- (id) init
{
    self = [super init];
    if (self)
    {
        self.name = @"Breast (boneless)";
        
        self.donenesses = @[@140,
                            @150,
                            @165,
                            ];
        
        self.donenessLabels = @{@140:@"Medium",
                                @150:@"Medium-Well",
                                @165:@"Well",
                                };
        
        self.thicknesses = @[
                             @(0.25),
                             @(0.5),
                             @(0.75),
                             @(1),
                             @(1.25),
                             @(1.5),
                             @(1.75),
                             @(2)
                             ];
        
        self.thicknessLabels = @{
                                 @(0.25):@[@" ",@"1",@"4"],
                                 @(0.5):@[@" ",@"1",@"2"],
                                 @(0.75):@[@" ",@"3",@"4"],
                                 @(1):@[@"1",@"",@""],
                                 @(1.25):@[@"1",@"1",@"4"],
                                 @(1.5):@[@"1",@"1",@"2"],
                                 @(1.75):@[@"1",@"3",@"4"],
                                 @(2):@[@"2",@"",@""]
                                 };
        
        self.cookingTimes =
        @{
          @140:@{
                  @0.25:@[@1,@30,@2,@30],
                  @0.5:@[@1,@30,@2,@30],
                  @0.75:@[@1,@30,@2,@30],
                  @1:@[@2,@30,@3,@30],
                  @1.25:@[@2,@30,@3,@30],
                  @1.5:@[@2,@30,@3,@30],
                  @1.75:@[@3,@0,@4,@0],
                  @2:@[@3,@0,@4,@0],
                  },
          @150:@{
                  @0.25:@[@1,@0,@2,@0],
                  @0.5:@[@1,@0,@2,@0],
                  @0.75:@[@1,@0,@2,@0],
                  @1:@[@1,@45,@2,@45],
                  @1.25:@[@1,@45,@2,@45],
                  @1.5:@[@1,@45,@2,@45],
                  @1.75:@[@2,@45,@3,@45],
                  @2:@[@2,@45,@3,@45],
                  },
          @165:@{
                  @0.25:    @[@0,@45,@2,@0],
                  @0.5:     @[@0,@45,@2,@0],
                  @0.75:    @[@0,@45,@2,@0],
                  @1:       @[@1,@0, @2,@30],
                  @1.25:    @[@1,@0, @2,@30],
                  @1.5:     @[@1,@0, @2,@30],
                  @1.75:    @[@1,@30,@4,@0],
                  @2:       @[@1,@30,@4,@0],
                  },
          };
        
    }
    return self;
    
}

@end
