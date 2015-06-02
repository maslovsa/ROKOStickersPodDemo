//
//  ROKOReachability.h
//  ROKOComponents
//
//  Created by Katerina Vinogradnaya on 7/7/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef enum : NSInteger {
	ROKONetworkStatusNotReachable = 0,
	ROKONetworkStatusReachableViaWiFi,
	ROKONetworkStatusReachableViaWWAN
} ROKONetworkStatus;


extern NSString *kROKOReachabilityChangedNotification;

@interface ROKOReachability : NSObject

+ (BOOL)startMonitoring;
+ (void)stopMonitoring;
+ (ROKONetworkStatus)networkStatus;

@end
