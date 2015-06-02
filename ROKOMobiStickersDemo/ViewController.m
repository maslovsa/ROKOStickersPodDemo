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

#pragma mark - RLCameraViewController Delegate

- (NSInteger)numberOfStickerPacksInComposer:(RLPhotoComposerController *)composer {
	return [_stickers count];
}

- (NSInteger)numberOfStickersInPackAtIndex:(NSInteger)packIndex composer:(RLPhotoComposerController *)composer {
	ROKOStickerPack *pack = _stickers[packIndex];
	return [pack.stickers count];
}

- (RLStickerPackInfo *)composer:(RLPhotoComposerController *)composer infoForStickerPackAtIndex:(NSInteger)packIndex {
	ROKOStickerPack *pack = _stickers[packIndex];
	UIImage *imageDefault = pack.unselectedIcon.image;
	UIImage *imageSelected = pack.selectedIcon.image;

//    create an instance of RLStickerPackInfo class
	RLStickerPackInfo *packInfo = [RLStickerPackInfo new];

//     and populate it's properties:
	packInfo.title = pack.name;
	packInfo.iconDefault = imageDefault;
	packInfo.iconDefaultURL = pack.unselectedIcon.imageURL;
	packInfo.iconSelected = imageSelected;
	packInfo.iconSelectedURL = pack.selectedIcon.imageURL;
	packInfo.isLocked = NO;
	packInfo.packID = [pack.objectId integerValue];

	return packInfo;
}

- (RLStickerInfo *)composer:(RLPhotoComposerController *)composer infoForStickerAtIndex:(NSInteger)stickerIndex packIndex:(NSInteger)packIndex {
	ROKOStickerPack *pack = _stickers[packIndex];
	ROKOSticker *sticker = pack.stickers[stickerIndex];
	UIImage *image = sticker.imageInfo.image;

	RLStickerInfo *info = [RLStickerInfo new];
	info.iconURL = sticker.imageInfo.imageURL;
	info.icon = image;
	info.name = [NSString stringWithFormat:@"%@_%@", pack.name, @(stickerIndex + 1)];
	info.stickerID = sticker.objectId.integerValue;

	return info;
}

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
    
        _currentWatermarkInfo = nil;
        ROKOStickerPack *pack = _stickers[packIndex];

        if(pack.useWatermark){
            _currentWatermarkInfo = pack.watermark;
            _currentWatermarkInfo.position = pack.watermarkPosition;
            _currentWatermarkInfo.scale = pack.watermarkScaleFactor;
        }        
}

- (void)composer:(RLPhotoComposerController *)composer didRemoveSticker:(RLStickerInfo *)stickerInfo {
	if (composer.projectWatermark) {
		composer.projectWatermark = nil;
	}
}

#pragma mark - properties


@end
