//
//  ROKOHTTPClient.h
//  ROKOComponents
//
//  Created by Katerina Vinogradnaya on 6/27/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kROKOMobiAPITokenKey;

typedef void(^ROKOHTTPClientCompletion)(id responseObject, NSError *error);

@interface ROKOHTTPClient : NSObject

- (instancetype)initWithBaseURL:(NSString *)baseURL;

- (void)getDataWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(ROKOHTTPClientCompletion)completion;

- (void)getDataWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters customHeaders:(NSDictionary *)headers completion:(ROKOHTTPClientCompletion)completion;

- (void)postDataWithURL:(NSString *)URLString parameters:(NSDictionary *)parameters body:(NSData *)body completion:(ROKOHTTPClientCompletion)completion;

- (void)downloadImageWithURL:(NSURL *)url completion:(ROKOHTTPClientCompletion)completion;

@end
