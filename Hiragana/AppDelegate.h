//
//  AppDelegate.h
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 19/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL *standardHiriganaOption;

@property (nonatomic) BOOL *intermediateHiriganaOption;

@property (nonatomic) BOOL *advancedHiriganaOption;

@property (nonatomic) BOOL *hideHintButtons;

@end
