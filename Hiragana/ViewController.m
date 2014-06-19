//
//  ViewController.m
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 19/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize translit, hirigana, nextButton;

-(void)showKeyboard {
    [translit becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self resignFirstResponder];

    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
}

NSString* returnAHirigana(bool *shouldUseHMYRW, bool *shouldUseGZDBP) {
    NSArray *basicHirigana;
    
    basicHirigana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", @"か", @"き", @"く", @"け", @"こ", @"さ", @"し", @"す", @"せ", @"そ", @"な", @"た", @"ち", @"つ", @"て", @"と", @"な", @"に", @"ぬ", @"ね", @"の", nil];
    
    //NSArray *IntermediateHirigana;
    
    //NSArray *AdvancedHirigana;
    
    uint32_t rnd = arc4random_uniform([basicHirigana count]);
    
    NSString *nextHirigana = [basicHirigana objectAtIndex:rnd];
    
    return(nextHirigana);
}

NSString* findTranslitForHirigana(NSString *theHirigana) {
    NSString *returnString;
    
    // Basic Translits
    if ([theHirigana isEqualToString:@"あ"]) {
        returnString = @"a";
    } else if ([theHirigana isEqualToString:@"い"]) {
        returnString = @"i";
    } else if ([theHirigana isEqualToString:@"う"]) {
        returnString = @"u";
    } else if ([theHirigana isEqualToString:@"え"]) {
        returnString = @"e";
    } else if ([theHirigana isEqualToString:@"お"]) {
        returnString = @"o";
    } else if ([theHirigana isEqualToString:@"か"]) {
        returnString = @"ka";
    } else if ([theHirigana isEqualToString:@"き"]) {
        returnString = @"ki";
    } else if ([theHirigana isEqualToString:@"く"]) {
        returnString = @"ku";
    } else if ([theHirigana isEqualToString:@"け"]) {
        returnString = @"ke";
    } else if ([theHirigana isEqualToString:@"こ"]) {
        returnString = @"ko";
    } else if ([theHirigana isEqualToString:@"さ"]) {
        returnString = @"sa";
    } else if ([theHirigana isEqualToString:@"し"]) {
        returnString = @"shi";
    } else if ([theHirigana isEqualToString:@"す"]) {
        returnString = @"su";
    } else if ([theHirigana isEqualToString:@"せ"]) {
        returnString = @"se";
    } else if ([theHirigana isEqualToString:@"そ"]) {
        returnString = @"so";
    } else if ([theHirigana isEqualToString:@"な"]) {
        returnString = @"ta";
    } else if ([theHirigana isEqualToString:@"ち"]) {
        returnString = @"chi";
    } else if ([theHirigana isEqualToString:@"つ"]) {
        returnString = @"tsu";
    } else if ([theHirigana isEqualToString:@"て"]) {
        returnString = @"te";
    } else if ([theHirigana isEqualToString:@"と"]) {
        returnString = @"to";
    } else if ([theHirigana isEqualToString:@"な"]) {
        returnString = @"na";
    } else if ([theHirigana isEqualToString:@"に"]) {
        returnString = @"ni";
    } else if ([theHirigana isEqualToString:@"ぬ"]) {
        returnString = @"nu";
    } else if ([theHirigana isEqualToString:@"ね"]) {
        returnString = @"ne";
    } else if ([theHirigana isEqualToString:@"の"]) {
        returnString = @"no";
    } else {
        returnString = @"No Result";
    }
    return returnString;
}

void showWrongTranslitError() {
    UIAlertView *wrongTranslit = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"That translit was wrong!" delegate:nil cancelButtonTitle:@"Try again?" otherButtonTitles: nil ];
    
    [wrongTranslit show];
}

-(void) verifyTranslitOnButtonPress {
    // Create some useful variables...
    NSString *typedTranslit = translit.text;
    NSString *currentHirigana = hirigana.text;
    NSString *correctTranslit = findTranslitForHirigana(currentHirigana);
    
    // Log these variables...
    NSLog(@"[ Current Hirigana: %@ ]Correct TL: %@ Typed Translit: %@", currentHirigana, correctTranslit, typedTranslit);
    
    // Figure out if the translit was correct or not...
    if ([correctTranslit isEqualToString:(typedTranslit)]) {
        // Log that it was correct...
        NSLog(@"[ Current Hirigana: %@ ]Correct TL: %@ ./", currentHirigana, correctTranslit);
        // Clean up the translit field for the next entry...
        translit.text = @"";
        // Get a new hirigana...
        NSString *nextHirigana = returnAHirigana(0, 0);
        // Display the aforementioned new hirigana!
        hirigana.text = nextHirigana;
        
        [self resignFirstResponder];
        [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
    } else {
        // Log that it was incorrect... :(
        NSLog(@"[ Current Hirigana: %@ ]Correct TL: %@ x", currentHirigana, correctTranslit);
        // Show the user a "try again" dialogue
        showWrongTranslitError();
        // Show the user the same hirigana...
        hirigana.text = currentHirigana;
        // Clean up the translit field for the next entry...
        translit.text = @"";
        
        [self resignFirstResponder];
        [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
    }

}

- (IBAction)EditingDidEnd:(id)sender {
    [self verifyTranslitOnButtonPress];
}

-(IBAction)nextButton:(UIBarButtonItem *)sender {
    [self verifyTranslitOnButtonPress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
