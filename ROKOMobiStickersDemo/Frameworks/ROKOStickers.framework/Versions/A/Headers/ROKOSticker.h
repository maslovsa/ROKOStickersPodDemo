//
//  ROKOSticker.h
//  ROKOStickers
//
//  Created by Alexey Golovenkov on 14.05.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <ROKOComponents/ROKOComponents.h>

@interface ROKOSticker : ROKODataObject

@property (nonatomic, assign) float scaleFactor;
@property (nonatomic, strong) ROKOImageDataObject *imageInfo;

@end
