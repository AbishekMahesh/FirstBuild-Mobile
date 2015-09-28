//
//  FSTParagonCookingSession.m
//  FirstBuild
//
//  Created by Myles Caley on 6/2/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTParagonCookingSession.h"

@implementation FSTParagonCookingSession
{
    uint8_t _currentStageIndex;
}
NSString * const FSTCurrentCookStageChangedNotification     = @"FSTCurrentCookStageChanged";


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.activeRecipe = nil;
        self.toBeRecipe = nil;
        self.currentProbeTemperature = 0;
        self.currentStageCookTimeElapsed = 0;
        self.currentStage = nil;
        _currentStageIndex = 0;
    }
    return self;
}

-(void) moveToStageIndex: (NSNumber*)stageIndex
{
    if ([stageIndex intValue] >= self.activeRecipe.paragonCookingStages.count)
    {
        DLog("requested stage index greater than available");
        return;
    }
    
    self.currentStage = self.activeRecipe.paragonCookingStages[[stageIndex intValue]];
    [[NSNotificationCenter defaultCenter] postNotificationName:FSTCurrentCookStageChangedNotification  object:self];
}

@end
