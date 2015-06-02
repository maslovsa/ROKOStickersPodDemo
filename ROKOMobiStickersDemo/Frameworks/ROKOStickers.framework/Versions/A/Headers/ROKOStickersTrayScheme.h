//
//  ROKOStickersTrayScheme.h
//  ROKOStickers
//
//  Created by Alexey Golovenkov on 25.04.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <ROKOComponents/ROKOComponents.h>

typedef NS_ENUM(NSInteger, ROKOStickersTrayDisplayType) {
	ROKOStickersTrayDisplayTypeIconOnly,
	ROKOStickersTrayDisplayTypeTitleOnly,
	ROKOStickersTrayDisplayTypeTitleAndIcon
};

@interface ROKOStickersTrayScheme : ROKOComponentScheme

@property (nonatomic, strong) ROKOFontDataObject *font;
@property (nonatomic, assign) ROKOStickersTrayDisplayType displayType;
@property (nonatomic, strong) ROKOImageDataObject *closeIconFile;
@property (nonatomic, strong) ROKOImageDataObject *openIconFile;
@property (nonatomic, strong) UIColor *backgroundColor;

@end
