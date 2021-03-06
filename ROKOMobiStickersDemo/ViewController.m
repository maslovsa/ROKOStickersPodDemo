//
//  ViewController.m
//  ROKOMobiStickersDemo
//
//  Created by Katerina Vinogradnaya on 6/20/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import "ViewController.h"
#import <ROKOShare/ROKOShare.h>
#import <ROKOStickers/ROKOStickers.h>
#import <ROKOComponents/ROKOComponents.h>

#define USE_LOCAL

@interface ViewController () {
	ROKOStickersScheme *_scheme;
    
#ifdef USE_LOCAL
    NSArray *_stickerPacks;
    NSDictionary *_stickerPackToIconsCount;
#else
    ROKOPortalStickersDataSource *_dataSource;
#endif
    
    
}

- (IBAction)takePhotoButtonPressed:(UIButton *)sender;
- (IBAction)choosePhotoButtonPressed:(UIButton *)sender;

@end

@implementation ViewController

#pragma mark - UIViewController implementation

- (void)viewDidLoad {
	[super viewDidLoad];
    
#ifdef USE_LOCAL
    _stickerPackToIconsCount = @{ @"glasses" : @10, @"hats" : @9, @"mustaches" : @9, @"baby" : @22,
                                  @"cake" : @9, @"cat" : @12, @"emoji" : @18, @"wedding" : @12 };
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:_stickerPackToIconsCount.allKeys.count];
    for (NSString *key in _stickerPackToIconsCount.allKeys) {
        [mutableArray addObject:[self getStickerPack:key]];
    }
    _stickerPacks = [mutableArray copy];
    [self addWatermarkToWeddingStickerPack];
#else
    _dataSource = [[ROKOPortalStickersDataSource alloc]initWithManager:nil];
#endif
    
    _scheme = [self createScheme];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Useful utilities

- (ROKOStickersScheme *)createScheme {
	ROKONavigationBarScheme *naviScheme = [ROKONavigationBarScheme new];
	naviScheme.controllerTitle = @"Stickers";
	naviScheme.useTextButtons = YES;
	naviScheme.navigationLeftButtonText = @"back";
	naviScheme.navigationRightButtonText = @"next";
	naviScheme.navigationBarColor = [UIColor whiteColor];

	ROKOStickersTrayScheme *trayScheme = [ROKOStickersTrayScheme new];
	trayScheme.displayType = ROKOStickersTrayDisplayTypeIconOnly;
	trayScheme.backgroundColor = [[UIColor alloc] initWithWhite:1 alpha:0.5];

	ROKOStickersScheme *scheme = [ROKOStickersScheme new];
	scheme.configurationViaPortal = NO;
    scheme.albumName = @"ROKO Strik";
	scheme.navigationBarScheme = naviScheme;
	scheme.trayScheme = trayScheme;
	return scheme;
}

- (RLStickerInfo *)stickerInfoWithIndex:(NSInteger)i packName:(NSString *)packName {
	RLStickerInfo *info = [RLStickerInfo new];
	info.name = [NSString stringWithFormat:@"%@_%@", packName, @(i + 1)];
	info.icon = [UIImage imageNamed:info.name];
	info.thumbnail = [UIImage imageNamed:info.name];
	info.stickerID = i + 1;
	return info;
}

#ifdef USE_LOCAL
- (void)addWatermarkToWeddingStickerPack {
    for (RLStickerPackInfo *stickerPack in _stickerPacks) {
        if ([stickerPack.title isEqualToString:@"wedding"]) {
            RLWatermarkInfo *info = [RLWatermarkInfo new];
            info.icon = [UIImage imageNamed:@"watermark_3"];
            info.position = kRLWatermarkPositionBottomRight;
            stickerPack.watermarkInfo = info;
        }
    }
}

- (RLStickerPackInfo *)getStickerPack:(NSString *)packName {
	RLStickerPackInfo *packInfo = [RLStickerPackInfo new];
	packInfo.title = packName;
	packInfo.iconDefault = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon_default", packName]];
	packInfo.iconSelected = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon_selected", packName]];
	packInfo.isLocked = NO;

	NSNumber *iconsCount = [_stickerPackToIconsCount objectForKey:packName];
	if (iconsCount) {
		NSInteger count = [iconsCount integerValue];
		NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:count];
		for (NSInteger i = 0; i < count; ++i) {
			RLStickerInfo *info = [self stickerInfoWithIndex:i packName:packName];
			[mutableArray addObject:info];
		}
		packInfo.stickers = [mutableArray copy];
	}
	return packInfo;
}
#endif

#ifndef USE_LOCAL
- (void)loadStickersForController:(RLComposerWorkflowController *)controller {
    __weak RLPhotoComposerController *composer = controller.composer;
    [_dataSource reloadStickersWithCompletionBlock:^(id responseObject, NSError *error) {
        [composer reloadData];
    }];
}
#endif

#pragma mark - Button Interaction

- (IBAction)takePhotoButtonPressed:(UIButton *)sender {
	RLComposerWorkflowController *workflowController = [RLComposerWorkflowController buildComposerWorkflowWithType:kRLComposerWorkflowTypeCamera useROKOCMS:NO];

	if (nil != workflowController) {
#ifdef USE_LOCAL
        workflowController.composer.dataSource = self;
#else
        workflowController.composer.dataSource = _dataSource;
        [self loadStickersForController:workflowController];
#endif
        workflowController.composer.delegate = self;
		[self presentViewController:workflowController animated:YES completion:nil];
	}
}

- (IBAction)choosePhotoButtonPressed:(UIButton *)sender {
	RLComposerWorkflowController *workflowController = [RLComposerWorkflowController buildComposerWorkflowWithType:kRLComposerWorkflowTypePhotoPicker useROKOCMS:NO];

    if (nil != workflowController) {
#ifdef USE_LOCAL
        workflowController.composer.dataSource = self;
#else
        workflowController.composer.dataSource = _dataSource;
        [self loadStickersForController:workflowController];
#endif
        workflowController.composer.delegate = self;
        [self presentViewController:workflowController animated:YES completion:nil];
    }
}

#pragma mark - RLPhotoComposerDataSource implementation

#ifdef USE_LOCAL
- (NSInteger)numberOfStickerPacksInComposer:(RLPhotoComposerController *)composer {
	return [_stickerPacks count];
}

- (NSInteger)numberOfStickersInPackAtIndex:(NSInteger)packIndex composer:(RLPhotoComposerController *)composer {
	RLStickerPackInfo *pack = _stickerPacks[packIndex];
	return [pack.stickers count];
}

- (RLStickerPackInfo *)composer:(RLPhotoComposerController *)composer infoForStickerPackAtIndex:(NSInteger)packIndex {
	return _stickerPacks[packIndex];
}

- (RLStickerInfo *)composer:(RLPhotoComposerController *)composer infoForStickerAtIndex:(NSInteger)stickerIndex packIndex:(NSInteger)packIndex {
	RLStickerPackInfo *pack = _stickerPacks[packIndex];
	RLStickerInfo *info = pack.stickers[stickerIndex];
	return info;
}
#endif

#pragma mark - RLPhotoComposerDelegate implementation

- (void)composer:(RLPhotoComposerController *)composer willAppearAnimated:(BOOL)animated {
	if (_scheme) {
		composer.scheme = _scheme;
	}
}

- (void)composer:(RLPhotoComposerController *)composer didPressShareButtonForImage:(UIImage *)image {
	RSActivityViewController *controller = [RSActivityViewController buildController];

	if (nil != controller) {
		[controller addImage:image];
		NSString *message = @"I made this for you on the ROKO Stickers app!";
		[controller addDisplayMessage:message];

		RSViewAttributes *messageViewAttributes = [RSViewAttributes new];
		messageViewAttributes.isEditable = YES;
		[RSSettingsManager sharedManager].messageViewAttributes = messageViewAttributes;

		composer.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
		[composer.navigationController presentViewController:controller animated:YES completion:nil];
	}
}

@end
