//
//  FSTFishSteakSousVideRecipe.m
//  FirstBuild
//
//  Created by Myles Caley on 12/18/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTFishSteakSousVideRecipe.h"

@implementation FSTFishSteakSousVideRecipe
- (id) init
{
    self = [super init];
    if (self)
    {
        self.name = @"Steak";
        
        self.donenesses = @[@110,
                            @120,
                            @125,
                            @140,
                            ];
        
        self.donenessLabels = @{@110:@"Very Rare",
                                @120:@"Rare",
                                @125:@"Medium-Rare",
                                @140:@"Well",
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
          @110:@{
                  @0.25:    @[@0,@10,@0,@15],
                  @0.5:     @[@0,@10,@0,@15],
                  @0.75:    @[@0,@10,@0,@15],
                  @1:       @[@0,@15,@0,@20],
                  @1.25:    @[@0,@15,@0,@20],
                  @1.5:     @[@0,@15,@0,@20],
                  @1.75:    @[@0,@15,@0,@20],
                  @2:       @[@0,@15,@0,@20],
                  
                  },
          @120:@{
                  @0.25:    @[@0,@15,@0,@20],
                  @0.5:     @[@0,@15,@0,@20],
                  @0.75:    @[@0,@15,@0,@20],
                  @1:       @[@0,@15,@0,@20],
                  @1.25:    @[@0,@15,@0,@20],
                  @1.5:     @[@0,@15,@0,@20],
                  @1.75:    @[@0,@15,@0,@20],
                  @2:       @[@0,@15,@0,@20],
                  
                  },
          @125:@{
                  @0.25:    @[@0,@15,@0,@20],
                  @0.5:     @[@0,@15,@0,@20],
                  @0.75:    @[@0,@15,@0,@20],
                  @1:       @[@0,@15,@0,@20],
                  @1.25:    @[@0,@15,@0,@20],
                  @1.5:     @[@0,@15,@0,@20],
                  @1.75:    @[@0,@15,@0,@20],
                  @2:       @[@0,@15,@0,@20],
                  
                  },
          @140:@{
                  @0.25:    @[@0,@40,@0,@50],
                  @0.5:     @[@0,@40,@0,@50],
                  @0.75:    @[@0,@40,@0,@50],
                  @1:       @[@0,@40,@0,@50],
                  @1.25:    @[@0,@40,@0,@50],
                  @1.5:     @[@0,@40,@0,@50],
                  @1.75:    @[@0,@40,@0,@50],
                  @2:       @[@0,@40,@0,@50],
                  
                  },
          };
        
        
    }
    return self;
    
}
@end
