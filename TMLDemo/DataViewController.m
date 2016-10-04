/*
 *  Copyright (c) 2016 Translation Exchange, Inc. All rights reserved.
 *
 *  _______                  _       _   _             ______          _
 * |__   __|                | |     | | (_)           |  ____|        | |
 *    | |_ __ __ _ _ __  ___| | __ _| |_ _  ___  _ __ | |__  __  _____| |__   __ _ _ __   __ _  ___
 *    | | '__/ _` | '_ \/ __| |/ _` | __| |/ _ \| '_ \|  __| \ \/ / __| '_ \ / _` | '_ \ / _` |/ _ \
 *    | | | | (_| | | | \__ \ | (_| | |_| | (_) | | | | |____ >  < (__| | | | (_| | | | | (_| |  __/
 *    |_|_|  \__,_|_| |_|___/_|\__,_|\__|_|\___/|_| |_|______/_/\_\___|_| |_|\__,_|_| |_|\__, |\___|
 *                                                                                        __/ |
 *                                                                                       |___/
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

#import "DataViewController.h"
#import <TMLKit/TML.h>
#import "SamplesTableViewController.h"
#import "AppDelegate.h"
#import <TMLKit/TMLLanguage.h>

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [center addObserverForName:TMLLanguageChangedNotification object:nil
                         queue:mainQueue usingBlock:^(NSNotification *note) {
                             [appDelegate initSamples];
                             self.sample = [appDelegate.samples objectAtIndex:self.index];
                             [self updateSample];
                         }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)samplesMenuTouched:(id)sender {
//  [self presentViewController:<#(nonnull UIViewController *)#> animated:YES completion:nil]
}

- (void) updateSample {
    if (!self.sample) return;
    
    TMLLanguage *language = TMLCurrentLanguage();
    self.resultsTitle.text = [NSString stringWithFormat: @"%@ Translation", [language englishName]];
    
    self.indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int) self.index + 1, (int) self.total];

    self.resultsLabel.textColor = [UIColor whiteColor];
    self.resultsLabel.font = [UIFont fontWithName:@"Helvetica" size:28];

    self.methodView.backgroundColor = [UIColor colorWithRed:0.98 green:0.96 blue:0.96 alpha:1.0];
    self.methodLabel.textColor = [UIColor blackColor];
    self.methodLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    
    NSString *method = @"TMLLocalizedString";
    
    if ([self.sample valueForKey:@"attributed"]) {
        method = @"TMLLocalizedAttributedString";
    }
    
    NSMutableAttributedString *methodCall = [[NSMutableAttributedString alloc]
                                             initWithString: @""];
    
    if ([self.sample valueForKey:@"presets"]) {
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: [self.sample valueForKey:@"presets"] attributes: @{NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];

        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"\n\n\n"]];
    }
    
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: method attributes: @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.42 green:0.36 blue:0.36 alpha:1.0]}]];
    
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"(" attributes: @{NSForegroundColorAttributeName : [UIColor blackColor]}]];

    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"\n  "]];
    
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"@\"" attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: [self.sample objectForKey:@"label"] attributes: @{NSForegroundColorAttributeName : [UIColor blueColor]}]];
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"\"" attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];

    if ([self.sample valueForKey:@"description"]) {
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @", \n  " attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"@\"" attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: [self.sample objectForKey:@"description" ] attributes: @{NSForegroundColorAttributeName : [UIColor blueColor]} ]];
        [methodCall appendAttributedString: [[NSMutableAttributedString alloc] initWithString: @"\"" attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];
        
        
        self.resultsLabel.attributedText = TMLLocalizedAttributedString([self.sample objectForKey:@"label"], [self.sample objectForKey:@"description"], [self.sample valueForKey:@"tokens"]);
    } else {
        self.resultsLabel.attributedText = TMLLocalizedAttributedString([self.sample objectForKey:@"label"], [self.sample objectForKey:@"tokens"]);
    }

    NSString *tokens = [self.sample objectForKey:@"tokens_desc"];
    if (!tokens && [self.sample valueForKey:@"tokens"]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject: [self.sample objectForKey:@"tokens"]
                                                           options: NSJSONWritingPrettyPrinted
                                                             error: &error];
        tokens = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    if (tokens) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s\"" options:NSRegularExpressionCaseInsensitive error:&error];
        tokens = [regex stringByReplacingMatchesInString:tokens options:0 range:NSMakeRange(0, [tokens length]) withTemplate:@" @\""];
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\{" options:NSRegularExpressionCaseInsensitive error:&error];
        tokens = [regex stringByReplacingMatchesInString:tokens options:0 range:NSMakeRange(0, [tokens length]) withTemplate:@"@\\{"];

        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @", " attributes: @{NSForegroundColorAttributeName : [UIColor grayColor]}]];
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: tokens attributes: @{NSForegroundColorAttributeName : [UIColor darkGrayColor]}]];
    } else {
        [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @"\n"]];
    }
        
    [methodCall appendAttributedString: [[NSAttributedString alloc] initWithString: @");" attributes: @{NSForegroundColorAttributeName : [UIColor blackColor]}]];
    
    self.methodLabel.attributedText = methodCall;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateSample];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SamplesSelectorSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SamplesTableViewController *samplesTable = (SamplesTableViewController *) [navigationController topViewController];
        samplesTable.delegate = self;
    }
}


@end
