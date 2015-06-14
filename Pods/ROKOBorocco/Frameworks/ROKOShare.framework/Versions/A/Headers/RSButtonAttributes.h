//
//  RSCancelButtonAttributes.h
//  ROKOShareDemo
//
//  Created by Katerina Vinogradnaya on 7/31/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSViewAttributes.h"

@interface RSButtonAttributes : RSViewAttributes
//@property (strong, nonatomic) RSViewAttributes *defaultAttributes;
@property (strong, nonatomic) RSViewAttributes *selectedAttribures;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) BOOL hidden;
@end

