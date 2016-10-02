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

#import "AppDelegate.h"
#import <TMLKit/TML.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initSamples];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) initSamples {
    TMLConfiguration *config = [[TML sharedInstance] configuration];
    [config setDefaultTokenValue:@{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}} forName:@"font1" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": [UIFont fontWithName:@"Helvetica-Bold" size:26]} forName:@"font2" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": @{@"name": @"system", @"size": @26, @"type": @"bold"}} forName:@"bold" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": @{@"name": @"system", @"size": @26, @"type": @"italic"}} forName:@"italic" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"color": @"red"} forName:@"red" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"color": [UIColor greenColor]} forName:@"green" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];

    
    self.samples =
    @[
      @{
          @"label": @"Hello World"
          },
      @{
          @"label": @"Eats shoots and leaves",
          @"description": @"A panda"
          },
      @{
          @"label": @"Eats shoots and leaves",
          @"description": @"A violent restaurant patron"
          },
      @{
          @"label": @"Hello [green: {user}]",
          @"tokens": @{@"user": @"Michael", @"green": @{@"color": @"green"}}
          },
      @{
          @"label": @"Do you speak {language}?",
          @"tokens": @{
                  @"language": TMLLocalizedString(@"English")
                  },
          },
      @{
          @"label": @"Number of messages: {count}",
          @"tokens": @{@"count": @5}
          },
      @{
          @"label": @"Hello {user.name}, you are a {user.gender}",
          @"tokens": @{@"user": @{@"object": @{@"gender": @"male", @"name": @"Michael"}, @"property": @"name"}},
          @"tokens_desc": @"{\"user\": michael}"
          },
      @{
          @"label": @"You have {count||message}",
          @"tokens": @{@"count": @1}
          },
      @{
          @"label": @"You have {count||message}",
          @"tokens": @{@"count": @3}
          },
      @{
          @"label": @"You have {count| one message, #count# messages}",
          @"tokens": @{@"count": @1}
          },
      @{
          @"label": @"You have {count| one message, #count# messages}",
          @"tokens": @{@"count": @2}
          },
      @{
          @"label": @"{user| He, She} likes this movie.",
          @"tokens": @{@"user": @{@"gender": @"male"}},
          },
      @{
          @"label": @"{user} uploaded {count|| photo} to {user| his, her} photo album.",
          @"tokens": @{
                  @"user": @{@"object": @{@"gender": @"male", @"name": @"Michael"}, @"property": @"name"},
                  @"count": @2
                  }
          },
      @{
          @"label": @"[font1: Adjust fonts] using an attribute dictionary.",
          @"tokens": @{@"font1": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}},
          },
      @{
          @"label": @"Adjust fonts using the [font2: UIFont class].",
          @"tokens": @{@"font2": @{@"font": [UIFont fontWithName:@"Helvetica-Bold" size:26]}},
          @"tokens_desc": @"{'font2': {'font': [UIFont fontWithName:@\"ChalkboardSE-Bold\" size:14]}",
          },
      @{
          @"label": @"System [bold: bold font] followed by [italic: italic font].",
          @"tokens": @{
                  @"bold": @{@"font": @{@"name": @"system", @"size": @26, @"type": @"bold"}},
                  @"italic": @{@"font": @{@"name": @"system", @"size": @26, @"type": @"italic"}}
                  }
          },
      @{
          @"label": @"[red: Color] can be changed using a dictionary.",
          @"tokens": @{@"red": @{@"color": @"red"}}
          },
      @{
          @"label": @"Color [green: can also be changed] using a UIColor class.",
          @"tokens": @{@"green": @{@"color": [UIColor greenColor]}},
          @"tokens_desc": @"{'green: {'color': [UIColor greenColor]}"
          },
      @{
          @"label": @"You can even [external: overlap colors and [internal: use RGB] color scheme].",
          @"tokens": @{@"external": @{@"color": [UIColor grayColor]},
                       @"internal": @{@"color": @{@"red": @0.5, @"green": @0.2, @"blue": @0.7, @"alpha": @1}}},
          @"tokens_desc": @"{'external: {'color': [UIColor grayColor]}, 'internal': {'color': {'red': 0.5, 'green': 0.2, 'blue': 0.7, 'alpha': 1}}}",
          },
      @{
          @"label": @"[purple: Background color] can also be changed using the same methods.",
          @"tokens": @{@"purple": @{@"background-color": @"purple", @"color": @"white"}},
          },
      @{
          @"label": @"You can [font1: mix fonts [font2: and colors] any way] you like.",
          @"tokens": @{
                  @"font1": @{@"color": [UIColor grayColor], @"font": [UIFont fontWithName:@"Helvetica-Bold" size:26]},
                  @"font2": @{@"background-color": @"light-gray", @"color": @{@"red": @0.5, @"green": @0.2, @"blue": @0.7, @"alpha": @1}}
                  },
          @"tokens_desc": @"{'external: {'color': [UIColor grayColor], 'font': [UIFont fontWithName:@\"ChalkboardSE-Bold\" size:14]}, 'internal': {'color': {'red': 0.5, 'green': 0.2, 'blue': 0.7, 'alpha': 1}}}",
          },
      @{
          @"label": @"You can [under: underline any part] of text.",
          @"tokens": @{@"under": @{@"underline": @"single"}}
          },
      @{
          @"label": @"You can even indicate [under: the thickness and pattern] of the line.",
          @"tokens": @{
                  @"under": @{@"underline": @{@"style": @"thick", @"pattern": @"dot", @"byword": @"true", @"color": @"blue"}}
                  },
          },
      @{
          @"label": @"You can [strike: use a strike-through] as well.",
          @"tokens": @{@"strike": @{@"strike": @"1"}}
          },
      @{
          @"label": @"You can indicate the [strike: strike-through color and thickness].",
          @"tokens": @{@"strike": @{@"strike": @{@"thickness": @"3", @"color": @"purple"}}}
          },
      @{
          @"label": @"[shadow: Shadows] are also very easy to add.",
          @"tokens": @{
                  @"shadow": @{@"shadow": @{@"offset": @"1,1", @"radius": @"0.5", @"color": @"gray"}}
                  },
          },
      @{
          @"label": @"You can mix [decor: fonts, colors and shadows] are also very easy to add.",
          @"tokens": @{
                  @"decor": @{
                          @"shadow": @{@"offset": @"1,1", @"radius": @"0.5", @"color": @"gray"},
                          @"font": [UIFont fontWithName:@"Helvetica-Bold" size:26],
                          @"color": @"purple"
                          }
                  },
          @"tokens_desc": @"{'shadow': {'offset': '1,1', 'radius': '0.5', 'color': 'gray'}}",
          },
      @{
          @"label": @"[bold: Adjust fonts] using default decorations.",
          @"tokens_desc": @"Using default decorations",
          @"tokens": @{}
          },
      
      @{
          @"label": @"You have [bold: {count|| message}]",
          @"tokens": @{
                  @"count": @1,
                  @"bold": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}
                  },
          },
      @{
          @"label": @"You have [bold: {count|| message}]",
          @"tokens": @{
                  @"count": @5,
                  @"bold": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}
                  }
          },
      @{
          @"label": @"[bold: {user}] uploaded [bold: {count|| photo}] to {user| his, her} photo album.",
          @"tokens": @{
                  @"user": @{@"object": @{@"gender": @"male", @"name": @"Michael"}, @"property": @"name"},
                  @"count": @2,
                  @"bold": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}
                  },
          },
      @{
          @"label": @"[red: {actor}] added [blue: {count||photo}] to [purple: {target::pos} album].",
          @"tokens": @{
                  @"actor": @"Michael",
                  @"target": @"Jenny",
                  @"count": @3,
                  @"red": @{@"color": @"red"},
                  @"blue": @{@"color": @"blue"},
                  @"purple": @{@"color": @"purple"},
                  }
          },
      
      @{
          @"label": @"[bold: {actor}] tagged [bold: {target}] in a blog post.",
          @"tokens": @{
                  @"actor": TMLLocalizedString(@"Michael"),
                  @"target": TMLLocalizedString(@"Anna"),
                  @"bold": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}
                  }
          }
      
      ];
}

@end
