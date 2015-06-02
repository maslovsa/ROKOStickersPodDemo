//
//  ROKOComponentManager.h
//  ROKOComponents
//
//  Created by Katerina Vinogradnaya on 6/27/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROKOHTTPClient.h"
#import "ROKOLocationManager.h"

//ROKOComponent

typedef NS_ENUM(NSInteger, ROKOComponentStatus) {
    kROKOComponentStatusInit = 0,
    kROKOComponentStatusWaitingForRegistration,
    kROKOComponentStatusRegistered,
    kROKOComponentStatusRegistrationFailed
};

@interface ROKOComponent : NSObject
@property (readonly, copy, nonatomic) NSString *componentID;
@property (readonly, copy, nonatomic) NSString *componentVersion;
@property (readonly, assign, nonatomic) ROKOComponentStatus status;

- (instancetype)initWithID:(NSString *)componentID
                   version:(NSString *)componentVersion;
+ (NSError *)registrationError;
@end



//ROKOComponentManager

extern NSString *const kROKOPushComponentID;
extern NSString *const kROKOShareComponentID;
extern NSString *const kROKOStickersComponentID;

typedef void(^ROKOComponentCompletion)(id responseObject, NSError *error);

@interface ROKOComponentManager : NSObject

+ (void)registerComponentWithID:(NSString *)componentID
                        version:(NSString *)componentVersion
                     completion:(ROKOComponentCompletion)completion;

+ (void)setUserWithID:(NSInteger)userID
           completion:(ROKOComponentCompletion)completion;

+ (void)setProperties:(NSDictionary *)properties
          componentID:(NSString *)componentID
           completion:(ROKOComponentCompletion)completion;

+ (ROKOComponent *)componentWithID:(NSString *)componentID;
+ (NSInteger)userID;

@end
