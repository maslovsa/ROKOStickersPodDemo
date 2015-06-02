//
//  UIColor+ROKOComponents.h
//  ROKOComponents
//
//  Created by Alexey Golovenkov on 21.04.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ROKOComponents)

+ (UIColor *)colorWithROKOString:(NSString *)colorDescription;
- (NSString *)ROKOString;

@end
