//
//  FSTOpal.h
//  FirstBuild
//
//  Created by Myles Caley on 3/22/16.
//  Copyright © 2016 FirstBuild. All rights reserved.
//

#import "FSTBleProduct.h"

@protocol FSTOpalDelegate <NSObject>
@optional - (void) iceMakerStatusChanged: (NSNumber*) status withLabel: (NSString*)label;
@optional - (void) iceMakerModeChanged: (BOOL) on;
@optional - (void) iceMakerLightChanged: (BOOL) on;
@optional - (void) iceMakerCleanCycleChanged: (NSNumber*) cycle;

@end

@interface FSTOpal : FSTBleProduct

  @property (strong, nonatomic) NSNumber* status;
  @property (strong, nonatomic) NSString* statusLabel;
  @property (strong, nonatomic) NSNumber* cleanCycle;
  @property (strong, nonatomic) NSDate* time;
  @property BOOL iceMakerOn;
  @property BOOL nightLightOn;

@property (nonatomic, weak) id<FSTOpalDelegate> delegate;

- (void) turnNightLightOn: (BOOL) on;
- (void) turnIceMakerOn: (BOOL) on;
- (void) configureSchedule: (NSArray*) schedule ;

@end