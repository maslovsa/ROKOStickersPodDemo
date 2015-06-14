//
//  ROKOComponentManager.h
//  ROKOComponents
//
//  Created by Katerina Vinogradnaya on 6/27/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROKOComponentManager : NSObject

@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, copy) NSString *apiToken;

+ (instancetype)sharedManager;

- (instancetype)initWithURL:(NSString *)baseURL;

- (void)registerObject:(NSObject *)object withName:(NSString *)objectName;
- (NSObject *)objectWithName:(NSString *)objectName;
- (void)unregisterObject:(NSObject *)object;
- (void)unregisterObjectWithName:(NSString *)objectName;

@end
