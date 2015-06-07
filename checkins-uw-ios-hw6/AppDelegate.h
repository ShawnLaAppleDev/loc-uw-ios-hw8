//
//  AppDelegate.h
//  checkins-uw-ios-hw6
//
//  Created by Parker, Carl (HBO) on 5/24/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL) shouldSaveToPhotoAlbum;

@end

