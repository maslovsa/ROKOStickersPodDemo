//
//  UIViewController+ROKOCustomizer.h
//  ROKOStickers
//
//  Created by Alexey Golovenkov on 26.04.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROKONavigationBarScheme.h"

@interface UIViewController (ROKOCustomizer)

- (void)updateNavigationBarWithScheme:(ROKONavigationBarScheme *)scheme;

@end
