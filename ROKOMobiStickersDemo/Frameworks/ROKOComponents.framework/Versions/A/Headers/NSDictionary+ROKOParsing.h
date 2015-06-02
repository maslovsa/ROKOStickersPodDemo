//
//  NSDictionary+ROKOParsing.h
//  ROKOComponents
//
//  Created by Alexey Golovenkov on 23.04.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROKOFontDataObject.h"
#import "ROKOImageDataObject.h"

@interface NSDictionary (ROKOParsing)

- (id)notNullValueForKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key;
- (NSInteger)integerValueForKey:(NSString *)key;
- (float)floatValueForKey:(NSString *)key;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key;
- (ROKOImageDataObject *)imageDataObjectWithKey:(NSString *)key;

@end
