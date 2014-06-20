//
//  SettingsViewController.m
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 20/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize standardHiriganaSwitch, intermediateHiriganaSwitch, advancedHiriganaSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Check and set the settings as they were...
    
    if (AppDelegate.standardHiriganaOption == (bool*)true) {
        standardHiriganaSwitch.on = true;
    } else if (AppDelegate.standardHiriganaOption == (bool*)false) {
        standardHiriganaSwitch.on = false;
    }
    if (AppDelegate.intermediateHiriganaOption == (bool*)true) {
        intermediateHiriganaSwitch.on = true;
    } else if (AppDelegate.intermediateHiriganaOption == (bool*)false) {
        intermediateHiriganaSwitch.on = false;
    }
    if (AppDelegate.advancedHiriganaOption == (bool*)true) {
        advancedHiriganaSwitch.on = true;
    } else if (AppDelegate.advancedHiriganaOption == (bool*)false) {
        advancedHiriganaSwitch.on = false;
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)standardTouchAction:(id)sender {
    if (standardHiriganaSwitch.on == true) {
        standardHiriganaSwitch.on = true;
        intermediateHiriganaSwitch.on = false;
        advancedHiriganaSwitch.on = false;
        NSLog(@"[Settings Change] Standard Hirigana Enabled");
        AppDelegate.standardHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)false;
        AppDelegate.advancedHiriganaOption = (bool *)false;
    } else {
        standardHiriganaSwitch.on = false;
        intermediateHiriganaSwitch.on = false;
        advancedHiriganaSwitch.on = false;
        NSLog(@"[Settings Change] Standard Hirigana Disabled");
        AppDelegate.standardHiriganaOption = (bool *)false;
        AppDelegate.intermediateHiriganaOption = (bool *)false;
        AppDelegate.advancedHiriganaOption = (bool *)false;
    }
}

- (IBAction)intermediateTouchAction:(id)sender {
    if (intermediateHiriganaSwitch.on == true) {
        standardHiriganaSwitch.on = true;
        intermediateHiriganaSwitch.on = true;
        NSLog(@"[Settings Change] Intermediate Hirigana Enabled");
        AppDelegate.standardHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)true;
        AppDelegate.advancedHiriganaOption = (bool *)false;
    } else {
        intermediateHiriganaSwitch.on = false;
        advancedHiriganaSwitch.on = false;
        NSLog(@"[Settings Change] Intermediate Hirigana Disabled");
        AppDelegate.standardHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)false;
        AppDelegate.advancedHiriganaOption = (bool *)false;
    }
}

- (IBAction)advancedTouchAction:(id)sender {
    if (advancedHiriganaSwitch.on == true) {
        standardHiriganaSwitch.on = true;
        intermediateHiriganaSwitch.on = true;
        advancedHiriganaSwitch.on = true;
        NSLog(@"[Settings Change] Advanced Hirigana Enabled");
        AppDelegate.standardHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)true;
        AppDelegate.advancedHiriganaOption = (bool *)true;
    } else {
        intermediateHiriganaSwitch.on = true;
        NSLog(@"[Settings Change] Advanced Hirigana Disabled");
        AppDelegate.standardHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)true;
        AppDelegate.intermediateHiriganaOption = (bool *)false;
    }
}
@end
