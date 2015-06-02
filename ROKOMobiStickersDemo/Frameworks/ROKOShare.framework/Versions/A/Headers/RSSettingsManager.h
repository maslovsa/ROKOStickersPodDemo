//
//  RSSettingsManager.h
//  ROKOShareDemo
//
//  Created by Katerina Vinogradnaya on 7/31/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSButtonAttributes.h"
#import "RSActivityAttributes.h"

typedef void(^RSSettingsManagerCompletion)(NSError *error);

@interface RSSettingsManager : NSObject

@property (strong, nonatomic) RSViewAttributes *promptViewAttributes;
@property (strong, nonatomic) RSViewAttributes *messageViewAttributes;
@property (strong, nonatomic) RSViewAttributes *backgroundViewAttributes;
@property (strong, nonatomic) RSButtonAttributes *closeButtonAttributes;
@property (strong, nonatomic) RSButtonAttributes *cancelButtonAttributes;
@property (strong, nonatomic) NSMutableArray *enabledActivities;

+ (instancetype)sharedManager;
+ (void)buildSettingsWithCompletion:(RSSettingsManagerCompletion)completion;
+ (RSActivityAttributes *)attributesForActivityType:(RSActivityType)type;
@end
