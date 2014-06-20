//
//  ViewController.m
//  Hiragana
//
//  Created by Aidan Cornelius-Bell on 19/06/2014.
//  Copyright (c) 2014 Aidan Cornelius-Bell. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

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

NSString* returnAHirigana(bool *shouldUseSTN, bool *shouldUseHMYRW, bool *shouldUseGZDBP) {
    NSArray *basicHirigana;
    
    basicHirigana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", nil];
    
    NSArray *standardHirigana;
    
    standardHirigana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", @"か", @"き", @"く", @"け", @"こ", @"さ", @"し", @"す", @"せ", @"そ", @"た", @"ち", @"つ", @"て", @"と", @"な", @"に", @"ぬ", @"ね", @"の", nil];
    
    NSArray *intermediateHirigana;
    
    intermediateHirigana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", @"か", @"き", @"く", @"け", @"こ", @"さ", @"し", @"す", @"せ", @"そ", @"た", @"ち", @"つ", @"て", @"と", @"な", @"に", @"ぬ", @"ね", @"の", @"は", @"ひ", @"ふ", @"へ", @"ほ", @"ま", @"み", @"む", @"め", @"も", @"や", @"ゆ", @"よ", @"ら", @"り", @"る", @"れ", @"ろ", @"わ", @"ん", @"を", nil];
    
    NSArray *advancedHirigana;
    
    advancedHirigana = [NSArray arrayWithObjects:@"あ", @"い", @"う", @"え", @"お", @"か", @"き", @"く", @"け", @"こ", @"さ", @"し", @"す", @"せ", @"そ", @"た", @"ち", @"つ", @"て", @"と", @"な", @"に", @"ぬ", @"ね", @"の", @"は", @"ひ", @"ふ", @"へ", @"ほ", @"ま", @"み", @"む", @"め", @"も", @"や", @"ゆ", @"よ", @"ら", @"り", @"る", @"れ", @"ろ", @"わ", @"ん", @"を", @"が", @"ぎ", @"ぐ", @"げ", @"ご", @"ざ", @"じ", @"ず", @"ぜ", @"ぞ", @"だ", @"ぢ", @"づ", @"で", @"ど", @"ば", @"び", @"ぶ", @"べ", @"ぼ", @"ぱ", @"ぴ", @"ぷ", @"ぺ", @"ぽ", nil];
    
    NSArray *arrayForReturn;
    
    if (shouldUseSTN == (bool*)1) {
        NSLog(@"[Enabling use of standard Hirigana] KSTNH");
        arrayForReturn = standardHirigana;
    } else {
        arrayForReturn = basicHirigana;
    }
    if (shouldUseHMYRW == (bool*)1) {
        NSLog(@"[Enabling use of Intermediate Hirigana] HMYRW");
        arrayForReturn = intermediateHirigana;
    }
    if (shouldUseGZDBP == (bool*)1) {
        NSLog(@"[Enabling use of Advanced Hirigana] GZDBP");
        arrayForReturn = advancedHirigana;
    }
    
    uint32_t rnd = arc4random_uniform([arrayForReturn count]);
    
    NSString *nextHirigana = [arrayForReturn objectAtIndex:rnd];
    
    NSLog(@"[ Next Hiragana ] %@", nextHirigana);
    
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
    } else if ([theHirigana isEqualToString:@"は"]) {
        returnString = @"ha";
    } else if ([theHirigana isEqualToString:@"ひ"]) {
        returnString = @"hi";
    } else if ([theHirigana isEqualToString:@"ふ"]) {
        returnString = @"fu";
    } else if ([theHirigana isEqualToString:@"へ"]) {
        returnString = @"he";
    } else if ([theHirigana isEqualToString:@"ほ"]) {
        returnString = @"ho";
    } else if ([theHirigana isEqualToString:@"ま"]) {
        returnString = @"ma";
    } else if ([theHirigana isEqualToString:@"み"]) {
        returnString = @"mi";
    } else if ([theHirigana isEqualToString:@"む"]) {
        returnString = @"mu";
    } else if ([theHirigana isEqualToString:@"め"]) {
        returnString = @"me";
    } else if ([theHirigana isEqualToString:@"も"]) {
        returnString = @"mo";
    } else if ([theHirigana isEqualToString:@"や"]) {
        returnString = @"ya";
    } else if ([theHirigana isEqualToString:@"ゆ"]) {
        returnString = @"yu";
    } else if ([theHirigana isEqualToString:@"よ"]) {
        returnString = @"yo";
    } else if ([theHirigana isEqualToString:@"ら"]) {
        returnString = @"ra";
    } else if ([theHirigana isEqualToString:@"り"]) {
        returnString = @"ri";
    } else if ([theHirigana isEqualToString:@"る"]) {
        returnString = @"ru";
    } else if ([theHirigana isEqualToString:@"れ"]) {
        returnString = @"re";
    } else if ([theHirigana isEqualToString:@"ろ"]) {
        returnString = @"ro";
    } else if ([theHirigana isEqualToString:@"わ"]) {
        returnString = @"wa";
    } else if ([theHirigana isEqualToString:@"ん"]) {
        returnString = @"n";
    } else if ([theHirigana isEqualToString:@"を"]) {
        returnString = @"wo";
    } else if ([theHirigana isEqualToString:@"が"]) {
        returnString = @"ga";
    } else if ([theHirigana isEqualToString:@"ぎ"]) {
        returnString = @"gi";
    } else if ([theHirigana isEqualToString:@"ぐ"]) {
        returnString = @"gu";
    } else if ([theHirigana isEqualToString:@"げ"]) {
        returnString = @"ge";
    } else if ([theHirigana isEqualToString:@"ご"]) {
        returnString = @"go";
    } else if ([theHirigana isEqualToString:@"ざ"]) {
        returnString = @"za";
    } else if ([theHirigana isEqualToString:@"じ"]) {
        returnString = @"ji";
    } else if ([theHirigana isEqualToString:@"ず"]) {
        returnString = @"zu";
    } else if ([theHirigana isEqualToString:@"ぜ"]) {
        returnString = @"ze";
    } else if ([theHirigana isEqualToString:@"ぞ"]) {
        returnString = @"zo";
    } else if ([theHirigana isEqualToString:@"だ"]) {
        returnString = @"da";
    } else if ([theHirigana isEqualToString:@"ぢ"]) {
        returnString = @"ji";
    } else if ([theHirigana isEqualToString:@"づ"]) {
        returnString = @"zu";
    } else if ([theHirigana isEqualToString:@"で"]) {
        returnString = @"de";
    } else if ([theHirigana isEqualToString:@"ど"]) {
        returnString = @"do";
    } else if ([theHirigana isEqualToString:@"ば"]) {
        returnString = @"ba";
    } else if ([theHirigana isEqualToString:@"び"]) {
        returnString = @"bi";
    } else if ([theHirigana isEqualToString:@"ぶ"]) {
        returnString = @"bu";
    } else if ([theHirigana isEqualToString:@"べ"]) {
        returnString = @"be";
    } else if ([theHirigana isEqualToString:@"ぼ"]) {
        returnString = @"bo";
    } else if ([theHirigana isEqualToString:@"ぱ"]) {
        returnString = @"pa";
    } else if ([theHirigana isEqualToString:@"ぴ"]) {
        returnString = @"pi";
    } else if ([theHirigana isEqualToString:@"ぷ"]) {
        returnString = @"pu";
    } else if ([theHirigana isEqualToString:@"ぺ"]) {
        returnString = @"pe";
    } else if ([theHirigana isEqualToString:@"ぽ"]) {
        returnString = @"po";
    } else {
        returnString = @"No Result";
    }
    return returnString;
}

void showWrongTranslitError() {
    UIAlertView *wrongTranslit = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"That translit was wrong!" delegate:nil cancelButtonTitle:@"Try again?" otherButtonTitles: nil ];
    
    [wrongTranslit show];
}

void showTranslitHint(NSString *theTranslit) {
    NSString *showHelpString = [NSString stringWithFormat:@"The correct translit is... %@", theTranslit];
    
    UIAlertView *wrongTranslit = [[UIAlertView alloc] initWithTitle:@"Hint:" message:showHelpString delegate:nil cancelButtonTitle:@"Try again?" otherButtonTitles: nil ];
    
    [wrongTranslit show];
}

-(void) verifyTranslitOnButtonPress {
    // Create some useful variables...
    NSString *typedTranslit = translit.text;
    NSString *currentHirigana = hirigana.text;
    NSString *correctTranslit = findTranslitForHirigana(currentHirigana);
    
    // Log these variables...
    NSLog(@"[ Current Hirigana: %@ ] Correct TL: %@ Typed Translit: %@", currentHirigana, correctTranslit, typedTranslit);
    
    // Figure out if the translit was correct or not...
    if ([correctTranslit isEqualToString:(typedTranslit)]) {
        // Log that it was correct...
        NSLog(@"[ Current Hirigana: %@ ] Correct TL: %@ ./", currentHirigana, correctTranslit);
        // Clean up the translit field for the next entry...
        translit.text = @"";
        // Get a new hirigana...
        NSString *nextHirigana = returnAHirigana(AppDelegate.standardHiriganaOption, AppDelegate.intermediateHiriganaOption, AppDelegate.advancedHiriganaOption);
        // Display the aforementioned new hirigana!
        hirigana.text = nextHirigana;
        
        [self resignFirstResponder];
        [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
    } else {
        // Log that it was incorrect... :(
        NSLog(@"[ Current Hirigana: %@ ] Correct TL: %@ x", currentHirigana, correctTranslit);
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

- (IBAction)skipButton:(id)sender {
    // Clean up the translit field for the next entry...
    translit.text = @"";
    // Get a new hirigana...
    NSString *nextHirigana = returnAHirigana(AppDelegate.standardHiriganaOption, AppDelegate.intermediateHiriganaOption, AppDelegate.advancedHiriganaOption);
    // Display the aforementioned new hirigana!
    hirigana.text = nextHirigana;
    
    [self resignFirstResponder];
    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];
}

- (IBAction)hintButton:(id)sender {
    NSString *currentHirigana = hirigana.text;
    NSString *correctTranslit = findTranslitForHirigana(currentHirigana);
    
    showTranslitHint(correctTranslit);
}
@end
