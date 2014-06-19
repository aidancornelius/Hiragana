//
//  ViewController.h
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 19/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate> {
    UITextField *translit;
}

@property (strong, nonatomic) IBOutlet UITextField *translit;
@property (strong, nonatomic) IBOutlet UILabel *hirigana;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end
