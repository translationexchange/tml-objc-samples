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

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)samplesMenuTouched:(id)sender {
//  [self presentViewController:<#(nonnull UIViewController *)#> animated:YES completion:nil]
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.sample) {
        
        NSString *method = @"TMLLocalizedAttributedString";
        NSMutableArray *params = [NSMutableArray arrayWithObjects:@"label", nil];
        
        self.stringLabel.textColor = [UIColor whiteColor];
        self.stringLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        self.descriptionLabel.textColor = [UIColor whiteColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        self.tokensTextView.textColor = [UIColor whiteColor];
        self.tokensTextView.font = [UIFont fontWithName:@"Helvetica" size:15];
        
        self.dataLabel.textColor = [UIColor whiteColor];
        self.dataLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        self.dataLabel.textAlignment = NSTextAlignmentCenter;

        self.stringLabel.text = [NSString stringWithFormat:@"\"%@\"", [self.sample valueForKey:@"label"]];
        
        if ([self.sample valueForKey:@"description"]) {
            self.dataLabel.attributedText = TMLLocalizedAttributedString([self.sample valueForKey:@"label"], [self.sample valueForKey:@"description"], [self.sample valueForKey:@"tokens"]);
            self.descriptionLabel.text = [NSString stringWithFormat:@"\"%@\"", [self.sample valueForKey:@"description"]];

            [params addObject:@"description"];
            
            self.descriptionTitleLabel.hidden = NO;
        } else {
            self.dataLabel.attributedText = TMLLocalizedAttributedString([self.sample valueForKey:@"label"], [self.sample valueForKey:@"tokens"]);
            self.descriptionLabel.text = @"";
            
            self.descriptionTitleLabel.hidden = YES;
        }
        
        if ([self.sample objectForKey:@"tokens_desc"]) {
            self.tokensTextView.text = [self.sample objectForKey:@"tokens_desc"];
            [params addObject:@"tokens"];
            
            self.tokensTitleLabel.hidden = NO;
            self.descriptionTitleLabel.hidden = NO;

        } else if ([self.sample objectForKey:@"tokens"]) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject: [self.sample objectForKey:@"tokens"]
                                                               options: NSJSONWritingPrettyPrinted
                                                                 error: &error];
            
            if (jsonData) {
                self.tokensTextView.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [params addObject:@"tokens"];
            }
            
            self.tokensTitleLabel.hidden = NO;
            self.descriptionTitleLabel.hidden = NO;
            
        } else {
            method = @"TMLLocalizedString";
            self.tokensTextView.text = @"";
            self.tokensTitleLabel.hidden = YES;
        }

        self.methodLabel.text = [NSString stringWithFormat:@"%@(%@)", method, [params componentsJoinedByString:@", "]];
        self.indexLabel.text = [NSString stringWithFormat:@"%d/%d", (int) self.index + 1, (int) self.total];
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SamplesSelectorSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        SamplesTableViewController *samplesTable = (SamplesTableViewController *) [navigationController topViewController];
        samplesTable.delegate = self;
    }
}


@end
