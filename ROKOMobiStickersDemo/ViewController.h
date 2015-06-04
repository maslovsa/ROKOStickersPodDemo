//
//  ViewController.h
//  ROKOMobiStickersDemo
//
//  Created by Katerina Vinogradnaya on 6/20/14.
//  Copyright (c) 2014 ROKOLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ROKOStickers/ROKOStickers.h>


#ifdef USE_LOCAL
@interface ViewController : UIViewController <RLPhotoComposerDelegate, RLPhotoComposerDataSource>
#else
@interface ViewController : UIViewController <RLPhotoComposerDelegate>
#endif

@end
