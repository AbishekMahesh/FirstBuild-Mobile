//
//  FSTPorkChopsSousVideRecipe.m
//  FirstBuild
//
//  Created by Myles Caley on 12/18/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTPorkChopsSousVideRecipe.h"

@implementation FSTPorkChopsSousVideRecipe
- (id) init
{
    self = [super init];
    if (self)
    {
        self.name = @"Chops";
        
        self.donenesses = @[@140,
                            @150,
                            @160,
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
                  @0.25:    @[@0,@30,@1,@30],
                  @0.5:     @[@0,@30,@1,@30],
                  @0.75:    @[@0,@30,@1,@30],
                  @1:       @[@1,@0, @2,@30],
                  @1.25:    @[@1,@0, @2,@30],
                  @1.5:     @[@1,@0, @2,@30],
                  @1.75:    @[@1,@30,@3,@0],
                  @2:       @[@1,@30,@3,@0],
                  },
          @150:@{
                  @0.25:    @[@0,@30,@1,@30],
                  @0.5:     @[@0,@30,@1,@30],
                  @0.75:    @[@0,@30,@1,@30],
                  @1:       @[@1,@0, @2,@30],
                  @1.25:    @[@1,@0, @2,@30],
                  @1.5:     @[@1,@0, @2,@30],
                  @1.75:    @[@1,@30,@3,@0],
                  @2:       @[@1,@30,@3,@0],
                  },
          @160:@{
                  @0.25:    @[@0,@30,@1,@30],
                  @0.5:     @[@0,@30,@1,@30],
                  @0.75:    @[@0,@30,@1,@30],
                  @1:       @[@1,@0, @2,@30],
                  @1.25:    @[@1,@0, @2,@30],
                  @1.5:     @[@1,@0, @2,@30],
                  @1.75:    @[@1,@30,@3,@0],
                  @2:       @[@1,@30,@3,@0],
                  },
          };
        
    }
    return self;
    
}
@end
