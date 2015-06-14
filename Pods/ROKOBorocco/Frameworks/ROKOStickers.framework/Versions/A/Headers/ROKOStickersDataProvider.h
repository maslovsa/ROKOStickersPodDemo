//
//  ROKOStickersDataProvider.h
//  ROKOStickers
//
//  Created by Alexey Golovenkov on 12.05.15.
//  Copyright (c) 2015 ROKOLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ROKOComponents/ROKOComponents.h>

@interface ROKOStickersDataProvider : ROKOComponent

/**
 *  Loads stickers from server
 *
 *  @param completionBlock Complention block to be called when loading is completed. responseObject parameter contains array of ROKOStickerPack objects if loading was successfull.
 */
- (void)loadStickersWithCompletionBlock:(ROKOHTTPClientCompletion)completionBlock;

/**
 *  Loads stickers list from local storage
 *
 *  @return Array of ROKOStickerPack objects
 */
- (NSArray *)cachedStickers;

/**
 *  Save stickers list to local storage
 *
 *  @param stickersPack Array of ROKOStickerPack objects
 */
- (BOOL)saveStickerPack:(NSArray*)stickersPack;

@end
