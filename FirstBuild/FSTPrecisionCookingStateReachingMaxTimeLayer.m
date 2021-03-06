//
//  FSTPrecisionCookingProgressStateReachingMaxTimeLayer.m
//  FirstBuild
//
//  Created by John Nolan on 8/6/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTPrecisionCookingStateReachingMaxTimeLayer.h"

@implementation FSTPrecisionCookingStateReachingMaxTimeLayer

- (void)layoutSublayers {
    [super layoutSublayers];
    [self drawCompleteTicks];
    self.progressLayer.strokeEnd = 1.0F;
    self.sittingLayer.strokeEnd = 0.0F;
}

- (void)drawPathsForPercent {
    [self drawCompleteTicks];
    self.progressLayer.strokeEnd = 1.0F; // complete
    self.sittingLayer.strokeEnd = self.percent; // based on time range
}


@end
