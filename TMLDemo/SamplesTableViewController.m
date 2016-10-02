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

#import "SamplesTableViewController.h"
#import "AppDelegate.h"
#import "DataViewController.h"

@interface SamplesTableViewController ()

@end

@implementation SamplesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    return [delegate.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SampleCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:@"SampleCell"];
    }
    
    NSString *title = [[delegate.samples objectAtIndex: indexPath.row] objectForKey:@"label"];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", (int) indexPath.row + 1, title];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (self.delegate) {
        DataViewController *controller = (DataViewController *) self.delegate;
        controller.sample = [appDelegate.samples objectAtIndex: indexPath.row];
        controller.index = indexPath.row;
        controller.total = [appDelegate.samples count];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
