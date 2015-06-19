//
//  FSTBleCentralManager.h
//  FirstBuild
//
//  Created by Myles Caley on 6/19/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//TODO: temporarily need CBPeripheralManagerDelegate
@interface FSTBleCentralManager : NSObject <CBCentralManagerDelegate, CBPeripheralManagerDelegate>

@end
