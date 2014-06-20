//
//  SettingsViewController.h
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 20/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *standardHiriganaSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *intermediateHiriganaSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *advancedHiriganaSwitch;

- (IBAction)standardTouchAction:(id)sender;
- (IBAction)intermediateTouchAction:(id)sender;
- (IBAction)advancedTouchAction:(id)sender;

@end
