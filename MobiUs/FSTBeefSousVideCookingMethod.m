//
//  FSTBeefSousVideCookingMethod.m
//  FirstBuild
//
//  Created by Myles Caley on 5/13/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTBeefSousVideCookingMethod.h"

@implementation FSTBeefSousVideCookingMethod

- (id) init
{
    self = [super init];
    if (self)
    {
        self.name = @"Beef";
        self.donenesses = @{ @134.5: @"MR",
                             @143.5: @"M",
                             @151.5: @"MW",
                             @160: @"W" };
        
        self.thicknesses = @[
                            @(0.2),
                            @(0.4),
                            @(0.6),
                            @(0.8),
                            @(1.2),
                            @(1.4),
                            @(1.6),
                            @(2.0),
                            @(2.15),
                            @(2.35),
                            @(2.5),
                            @(2.75)
                            ];
        
        //note: @0.2, etc are double values.
        self.cookingTimes =
            @{
              @134.5: @{
                        @0.2:@[@1,@00],
                        @0.4:@[@1,@15],
                        @0.6:@[@1,@30],
                        @0.8:@[@1,@45],
                        @1.2:@[@2,@00],
                        @1.4:@[@2,@15],
                        @1.6:@[@2,@30],
                        @2.0:@[@3,@07],
                        @2.15:@[@3,@45],
                        @2.35:@[@4,@15],
                        @2.5:@[@4,@45],
                        @2.75:@[@5,@15]
                      },
              @143.5: @{
                      @0.2:@[@0,@25],
                      @0.4:@[@0,@30],
                      @0.6:@[@0,@45],
                      @0.8:@[@0,@55],
                      @1.2:@[@1,@30],
                      @1.4:@[@1,@30],
                      @1.6:@[@1,@45],
                      @2.0:@[@2,@31],
                      @2.15:@[@2,@45],
                      @2.35:@[@3,@00],
                      @2.5:@[@3,@15],
                      @2.75:@[@3,@45]
                      },
              @151.0: @{
                      @0.2:@[@0,@13],
                      @0.4:@[@0,@25],
                      @0.6:@[@0,@35],
                      @0.8:@[@0,@45],
                      @1.2:@[@1,@15],
                      @1.4:@[@1,@15],
                      @1.6:@[@1,@30],
                      @2.0:@[@2,@28],
                      @2.15:@[@2,@15],
                      @2.35:@[@2,@30],
                      @2.5:@[@2,@45],
                      @2.75:@[@3,@15]
                      },
              @160: @{
                      @0.2:@[@0,@13],
                      @0.4:@[@0,@25],
                      @0.6:@[@0,@35],
                      @0.8:@[@0,@45],
                      @1.2:@[@1,@15],
                      @1.4:@[@1,@15],
                      @1.6:@[@1,@30],
                      @2.0:@[@2,@28],
                      @2.15:@[@2,@15],
                      @2.35:@[@2,@30],
                      @2.5:@[@2,@45],
                      @2.75:@[@3,@15]
                      },
            };
      
    }
    return self;
    
}

@end
