//
//  RSButtonAttributes.h
//  ROKOShareDemo
//
//  Created by Katerina Vinogradnaya on 7/31/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSViewAttributes : NSObject
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *imageURL;
@property (assign, nonatomic) CGFloat alpha;
@property (assign, nonatomic) BOOL isEditable;
@end
