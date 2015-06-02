//
//  RSActivityViewController.h
//  ROKOShare
//
//  Created by Katerina Vinogradnaya on 08.05.14.
//  Copyright (c) 2014 ROKOLabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSettingsManager.h"

typedef NS_ENUM(NSInteger, RSActivityViewControllerResult) {
    kRSActivityViewControllerResultDone = 0,
    kRSActivityViewControllerResultCancelled,
    kRSActivityViewControllerResultFailed
};


@class RSActivityViewController;

@protocol RSActivityViewControllerDelegate <NSObject>

@optional
- (void)activityController:(RSActivityViewController *)controller
 didFinishWithActivityType:(RSActivityType)activityType
                    result:(RSActivityViewControllerResult)result;

- (void)activityControllerDidCancel:(RSActivityViewController *)controller;

@end


@interface RSActivityViewController : UIViewController

@property (weak, nonatomic) id<RSActivityViewControllerDelegate>delegate;

+ (instancetype)buildController;

- (void)addSubject:(NSString *)subject;
- (void)addShareMessage:(NSString *)shareMessage;
- (void)addDisplayMessage:(NSString *)displayMessage;
- (void)addImage:(UIImage *)image;
- (void)addURL:(NSURL *)URL;

@end
