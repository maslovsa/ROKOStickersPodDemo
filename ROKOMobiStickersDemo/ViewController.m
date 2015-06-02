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

@interface ViewController () {
	ROKOStickersCustomizer *_customizer;
	ROKOStickersScheme *_scheme;
	//ROKOStickersDataProvider *_dataProvider;
    ROKOStickersWatermarkInfo *_currentWatermarkInfo;

	NSArray *_stickers;
}

- (IBAction)takePhotoButtonPressed:(UIButton *)sender;
- (IBAction)choosePhotoButtonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_customizer =  [[ROKOStickersCustomizer alloc]initWithBaseURL:@"rmsws.stage.rokolabs.com/external/v1/"];
//	_dataProvider = [[ROKOStickersDataProvider alloc]initWithBaseURL:@"rmsws.stage.rokolabs.com/external/v1/"];
//	[_dataProvider loadStickersWithCompletionBlock:^(id responseObject, NSError *error) {
//		if (!error) {
//			_stickers = responseObject;
//		}
//	}];
    
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    [mutableArray addObject:[self getStickerPack: @"hats"]];
    
    _stickers = [mutableArray copy];
    
}

- (void)dealloc {

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (RLStickerPackInfo *)getStickerPack:(NSString*)packName {
    static int totalIdCounter = 0;
    RLStickerPackInfo *packInfo = [RLStickerPackInfo new];
    packInfo.title = packName;
    packInfo.iconDefault = [UIImage imageNamed: [NSString stringWithFormat:@"%@_icon_default", packName]];
    packInfo.iconSelected = [UIImage imageNamed: [NSString stringWithFormat:@"%@_icon_default", packName]];
    packInfo.isLocked = NO;
    packInfo.packID = totalIdCounter++;
    int n = 1;
    UIImage *i1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d", packName, n]];
    n = 2;
    UIImage *i2 = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%d", packName, n]];
    
    packInfo.stickers = [NSArray arrayWithObjects: i1, i2, nil];
    
    return packInfo;
}

#pragma mark - Button Interaction

- (IBAction)takePhotoButtonPressed:(UIButton *)sender {
	RLComposerWorkflowController *workflowController = [RLComposerWorkflowController buildComposerWorkflowWithType:kRLComposerWorkflowTypeCamera useROKOCMS:NO];

	if (nil != workflowController) {
		workflowController.composer.dataSource = self;
		workflowController.composer.delegate = self;
		[self presentViewController:workflowController animated:YES completion:nil];
	}
}

- (IBAction)choosePhotoButtonPressed:(UIButton *)sender {
	RLComposerWorkflowController *workflowController = [RLComposerWorkflowController buildComposerWorkflowWithType:kRLComposerWorkflowTypePhotoPicker useROKOCMS:NO];

	if (nil != workflowController) {
		RLPhotoComposerController *photoComposer = workflowController.composer;
		photoComposer.delegate = self;
		photoComposer.dataSource = self;

		[self presentViewController:workflowController animated:YES completion:nil];
	}
}

#pragma mark - RLPhotoComposerDataSource implementation

- (NSInteger)numberOfStickerPacksInComposer:(RLPhotoComposerController *)composer {
	return [_stickers count];
}

- (NSInteger)numberOfStickersInPackAtIndex:(NSInteger)packIndex composer:(RLPhotoComposerController *)composer {
	RLStickerPackInfo *pack = _stickers[packIndex];
	return [pack.stickers count];
}

- (RLStickerPackInfo *)composer:(RLPhotoComposerController *)composer infoForStickerPackAtIndex:(NSInteger)packIndex {
	return _stickers[packIndex];
}

- (RLStickerInfo *)composer:(RLPhotoComposerController *)composer infoForStickerAtIndex:(NSInteger)stickerIndex packIndex:(NSInteger)packIndex {
	RLStickerPackInfo *pack = _stickers[packIndex];
	ROKOSticker *sticker = pack.stickers[stickerIndex];
	UIImage *image = sticker.imageInfo.image;

	RLStickerInfo *info = [RLStickerInfo new];
	info.iconURL = sticker.imageInfo.imageURL;
	info.icon = image;
	info.name = [NSString stringWithFormat:@"%@_%@", pack.title, @(stickerIndex + 1)];
	info.stickerID = sticker.objectId.integerValue;

	return info;
}

#pragma mark - RLPhotoComposerDelegate implementation

- (void)composer:(RLPhotoComposerController *)composer didFinishWithPhoto:(UIImage *)photo {
	return;
}

- (void)composerDidCancel:(RLPhotoComposerController *)composer {
	return;
}

- (void)composer:(RLPhotoComposerController *)composer willAppearAnimated:(BOOL)animated {
	composer.projectWatermark = nil;
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

- (void)composer:(RLPhotoComposerController *)composer didAddSticker:(RLStickerInfo *)stickerInfo {
    if (_currentWatermarkInfo){
        composer.projectWatermark = [[RLWatermarkInfo alloc]initWithRokoStickersWatermarkInfo:_currentWatermarkInfo];
    }
   
}
-(void)composer:(RLPhotoComposerController *)composer didSwitchToStickerPackAtIndex:(NSInteger)packIndex{
    
//        _currentWatermarkInfo = nil;
//        ROKOStickerPack *pack = _stickers[packIndex];
//
//        if(pack.useWatermark){
//            _currentWatermarkInfo = pack.watermark;
//            _currentWatermarkInfo.position = pack.watermarkPosition;
//            _currentWatermarkInfo.scale = pack.watermarkScaleFactor;
//        }        
}

- (void)composer:(RLPhotoComposerController *)composer didRemoveSticker:(RLStickerInfo *)stickerInfo {
//	if (composer.projectWatermark) {
//		composer.projectWatermark = nil; //  FIX later
//	}
}

#pragma mark - properties


@end
