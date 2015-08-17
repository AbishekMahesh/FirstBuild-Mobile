//
//  FSTHumanaPillBottle.m
//  FirstBuild
//
//  Created by Myles Caley on 8/13/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTHumanaPillBottle.h"

@implementation FSTHumanaPillBottle

//notifications
NSString * const FSTHumanaPillBottleBatteryLevelChangedNotification         = @"FSTHumanaPillBottleBatteryLevelChangedNotification";


//app info service
NSString * const FSTServiceAppInfoService               = @"E936877A-8DD0-FAA7-B648-F46ACDA1F27B";
NSString * const FSTCharacteristicAppInfo               = @"318DB1F5-67F1-119B-6A41-1EECA0C744CE"; //read

//acm service
//NSString * const FSTServiceParagon                      = @"05C78A3E-5BFA-4312-8391-8AE1E7DCBF6F";
NSString * const FSTCharacteristicScratch1       = @"A495FF21-C5B1-4B44-B512-1370F02D74DE"; //read,notify,write

NSMutableDictionary *requiredCharacteristics; // a dictionary of strings with booleans

__weak NSTimer* _readCharacteristicsTimer;

#pragma mark - Allocation

- (id)init
{
    self = [super init];
    
    if (self)
    {
        // booleans for all the required characteristics, tell us whether or not the characteristic loaded
        requiredCharacteristics = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[
            [NSNumber alloc] initWithBool:0], FSTCharacteristicScratch1,
            nil];
    }
    
    return self;
}

-(void)dealloc
{
    [_readCharacteristicsTimer invalidate];
}


#pragma mark - Read Handlers

-(void)readHandler: (CBCharacteristic*)characteristic
{
    [super readHandler:characteristic];
    
    if ([[[characteristic UUID] UUIDString] isEqualToString: FSTCharacteristicScratch1])
    {
        [requiredCharacteristics setObject:[NSNumber numberWithBool:1] forKey:FSTCharacteristicScratch1];
        [self handleScratch1:characteristic];
    }
    
    NSEnumerator* requiredEnum = [requiredCharacteristics keyEnumerator]; // count how many characteristics are ready
    NSInteger requiredCount = 0; // count the number of discovered characteristics
    for (NSString* characteristic in requiredEnum) {
        requiredCount += [(NSNumber*)[requiredCharacteristics objectForKey:characteristic] integerValue];
    }
    
    if (requiredCount == [requiredCharacteristics count] && self.initialCharacteristicValuesRead == NO) // found all required characteristics
    {
        //we haven't informed the application that the device is completely loaded, but we have
        //all the data we need
        self.initialCharacteristicValuesRead = YES;
        
        [self notifyDeviceReady]; // logic contained in notification center
        for (NSString* requiredCharacteristic in requiredCharacteristics)
        {
            CBCharacteristic* c =[self.characteristics objectForKey:requiredCharacteristic];
            if (c.properties & CBCharacteristicPropertyNotify)
            {
                [self.peripheral setNotifyValue:YES forCharacteristic:c ];
            }
        }
    }
    else if(self.initialCharacteristicValuesRead == NO)
    {
        //we don't have all the data yet...
        // calculate fraction
        double progressCount = [[NSNumber numberWithInt:(int)requiredCount] doubleValue];
        double progressTotal = [[NSNumber numberWithInt:(int)[requiredCharacteristics count]] doubleValue];
        self.loadingProgress = [NSNumber numberWithDouble: progressCount/progressTotal];
        
        [self notifyDeviceLoadProgressUpdated];
    }
    
} // end assignToProperty

//-(void)handleBatteryLevel: (CBCharacteristic*)characteristic
//{
//    if (characteristic.value.length != 1)
//    {
//        DLog(@"handleBatteryLevel length of %lu not what was expected, %d", (unsigned long)characteristic.value.length, 1);
//        return;
//    }
//    
//    NSData *data = characteristic.value;
//    Byte bytes[characteristic.value.length] ;
//    [data getBytes:bytes length:characteristic.value.length];
//    self.batteryLevel = [NSNumber numberWithUnsignedInt:bytes[0]];
//    
//    //NSLog(@"FSTCharacteristicBatteryLevel: %@", self.batteryLevel );
//    [[NSNotificationCenter defaultCenter] postNotificationName:FSTBatteryLevelChangedNotification  object:self];
//    
//}

-(void)handleScratch1: (CBCharacteristic*)characteristic
{
    if (characteristic.value.length != 2)
    {
        //DLog(@"handleElapsedTime length of %lu not what was expected, %d", (unsigned long)characteristic.value.length, 2);
        return;
    }
    
    NSData *data = characteristic.value;
    Byte bytes[characteristic.value.length] ;
    [data getBytes:bytes length:characteristic.value.length];
//        uint16_t raw = OSReadBigInt16(bytes, 0);
//        [[NSNotificationCenter defaultCenter] postNotificationName:FSTElapsedTimeChangedNotification object:self];
    
}


#pragma mark - Characteristic Discovery Handler

-(void)handleDiscoverCharacteristics: (NSArray*)characteristics
{
    [super handleDiscoverCharacteristics:characteristics];
    
    self.initialCharacteristicValuesRead = NO;
    [requiredCharacteristics setObject:[NSNumber numberWithBool:0] forKey:FSTCharacteristicScratch1];
    NSLog(@"=======================================================================");
  //  NSLog(@"SERVICE %@", [service.UUID UUIDString]);
    
    for (CBCharacteristic *characteristic in characteristics)
    {
        [self.characteristics setObject:characteristic forKey:[characteristic.UUID UUIDString]];
        NSLog(@"    CHARACTERISTIC %@", [characteristic.UUID UUIDString]);
        
        if (characteristic.properties & CBCharacteristicPropertyWrite)
        {
            NSLog(@"        CAN WRITE");
        }
        
        if (characteristic.properties & CBCharacteristicPropertyNotify)
        {
            if  (
                 [[[characteristic UUID] UUIDString] isEqualToString: FSTCharacteristicScratch1]
                 )
            {
                [self.peripheral readValueForCharacteristic:characteristic];
            }
            NSLog(@"        CAN NOTIFY");
        }
        
        if (characteristic.properties & CBCharacteristicPropertyRead)
        {
            NSLog(@"        CAN READ");
        }
        
        if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse)
        {
            NSLog(@"        CAN WRITE WITHOUT RESPONSE");
        }
    }
}

@end
