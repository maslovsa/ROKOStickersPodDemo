//
//  ROKOLocationManager.h
//  ROKOComponents
//
//  Created by Abrikos Kokos on 01.04.14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kROKOLocationManagerDidReceiveLocationNotification;
extern NSString * const kROKOLocationManagerDidFailToReceiveLocationNotification;
extern NSString * const kROKOLocationManagerNotificationLongitudeKey;
extern NSString * const kROKOLocationManagerNotificationLatitudeKey;

@interface ROKOLocationManager : NSObject
@property (assign, nonatomic) BOOL isUpdatingLocation;
+ (instancetype)sharedManager;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (NSDictionary *)gpsDictionaryForCurrentLocation;
@end
