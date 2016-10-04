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
#import "User.h"

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
    [config setDefaultTokenValue:@{@"font": @{@"name": @"Helvetica-Bold", @"size": @28}} forName:@"font1" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": [UIFont fontWithName:@"Helvetica-Bold" size:28]} forName:@"font2" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": @{@"name": @"Helvetica-Bold", @"size": @30}} forName:@"bold" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"font": @{@"name": @"system", @"size": @28, @"type": @"italic"}} forName:@"italic" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"color": @"red"} forName:@"red" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    [config setDefaultTokenValue:@{@"color": [UIColor greenColor]} forName:@"green" type:TMLDecorationTokenType format:TMLAttributedTokenFormat];
    
    User *anna = [[User alloc] initWithName: @"Anna" gender: @"female" age: @"25"];
    User *peter = [[User alloc] initWithName: @"Peter" gender: @"male" age: @"18"];
    
    self.samples =
    @[
      @{
          @"label": @"Hello World",
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
          @"label": @"Hello <bold>World</bold>",
          @"attributed": @true,
          },
      @{
          @"label": @"Hello [bold: World]"
          },
      @{
          @"presets": @"TMLConfiguration *config = [[TML sharedInstance] configuration];\n\n[config setDefaultTokenValue:@{@\"color\": @\"red\"} forName:@\"red\"];",
          @"label": @"Hello <red>World</red>",
          @"attributed": @true,
          },
      @{
          @"label": @"[indent: Adjust fonts] using an attribute dictionary.",
          @"tokens": @{@"indent": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @26}}},
          @"attributed": @true,
          },
      @{
          @"label": @"Hello {user}",
          @"tokens": @{@"user": @"Michael"}
          },
      @{
          @"label": @"Hello [indent: {user}]",
          @"tokens": @{@"user": @"Michael", @"indent": @{@"color": @"red"}},
          @"attributed": @true,
          },
      @{
          @"label": @"Do you speak {language}?",
          @"tokens": @{
                  @"language": TMLLocalizedString(@"English")
                  },
          @"tokens_desc": @"{\n  @\"language\" : TMLLocalizedString(@\"English\")\n}",
          },
      @{
          @"presets": @"User *anna = [[User alloc] initWithName: @\"Anna\" age: 25];",
          @"label": @"{user.name} just turned {user.age} years old",
          @"tokens": @{@"user": anna},
          @"tokens_desc": @"{\n  @\"user\" : anna\n}"
          },
      @{
          @"label": @"You have messages: {count}",
          @"tokens": @{@"count": @5}
          },
      @{
          @"label": @"You have {count || one: message, other: messages}",
          @"tokens": @{@"count": @1}
          },
      @{
          @"label": @"You have {count || message, messages}",
          @"tokens": @{@"count": @1}
          },
      @{
          @"label": @"You have {count || message}",
          @"tokens": @{@"count": @3}
          },
      @{
          @"label": @"You have {count | a message, #count# messages}",
          @"tokens": @{@"count": @1}
          },
      @{
          @"label": @"You have {count | a message, #count# messages}",
          @"tokens": @{@"count": @3}
          },
      @{
          @"label": @"You have [red: {count}] {count | message}",
          @"tokens": @{@"count": @3, @"red": @{@"color": @"red"}},
          @"attributed": @true,
          },
      @{
          @"presets": @"User *peter = [[User alloc] initWithName: @\"Peter\" gender: @\"male\"];",
          @"label": @"{user} liked this post.",
          @"tokens": @{@"user": peter},
          @"tokens_desc": @"{\n  @\"user\" : peter\n}"
          },
      @{
          @"presets": @"User *anna = [[User alloc] initWithName: @\"Anna\" gender: @\"female\"];",
          @"label": @"{user | He, She} liked this post.",
          @"tokens": @{@"user": anna},
          @"tokens_desc": @"{\n  @\"user\" : anna\n}"
          },
      @{
          @"label": @"{user | He, She} liked this movie.",
          @"tokens": @{@"user": @{@"gender": @"male"}},
          },
      @{
          @"presets": @"User *peter = [[User alloc] initWithName: @\"Peter\" gender: @\"male\"];",
          @"label": @"{user} uploaded {count || photo} to {user | his, her} photo album.",
          @"tokens": @{
                  @"user": peter,
                  @"count": @2
                  },
          @"tokens_desc": @"{\n  @\"user\" : peter\n}"
          },
      
      
      @{
          @"label": @"[underline: {user}] uploaded [indent: {count || photo}] to [underline: {user | his, her} photo album].",
          @"tokens": @{
                  @"user": @{@"gender": @"male", @"value": @"Michael"},
                  @"count": @2,
                  @"underline": @{@"underline": @"single"},
                  @"indent": @{@"font": @{@"name": @"Helvetica-Bold", @"size": @18}, @"color": @"red"}
                  },
          @"attributed": @true,
          },
      
      
      @{
          @"presets": @"User *peter = [[User alloc] initWithName: @\"Peter\" gender: @\"male\"];\nUser *anna = [[User alloc] initWithName: @\"Anna\" gender: @\"female\"];",
          @"label": @"{actor} added [bold: {count || photo}] to {target::pos} photo album.",
          @"tokens": @{
                  @"actor": peter,
                  @"target": anna,
                  @"count": @3
                  },
          @"tokens_desc": @"{\n  @\"actor\" : peter\n  @\"target\" : anna\n  @\"count\" : @3\n}"
          },

      @{
          @"presets": @"User *peter = [[User alloc] initWithName: @\"Peter\" gender: @\"male\"];\nUser *anna = [[User alloc] initWithName: @\"Anna\" gender: @\"female\"];",
          @"label": @"{actor} added [bold: {count || photo}] to {target::pos} photo album.",
          @"tokens": @{
                  @"actor": anna,
                  @"target": peter,
                  @"count": @3
                  },
          @"tokens_desc": @"{\n  @\"actor\" : anna\n  @\"target\" : peter\n  @\"count\" : @3\n}",
          @"attributed": @true,
          },
      
      @{
          @"label": @"{actor} tagged {target} in {actor | his, her} blog post.",
          @"tokens": @{
                  @"actor": @{@"value": TMLLocalizedString(@"Michael"), @"gender": @"male"},
                  @"target": @{@"value": TMLLocalizedString(@"Anna"), @"gender": @"female"},
                  }
          },

      @{
          @"label": @"{actor} tagged {target} in {actor | his, her} blog post.",
          @"tokens": @{
                  @"target": @{@"value": TMLLocalizedString(@"Michael"), @"gender": @"male"},
                  @"actor": @{@"value": TMLLocalizedString(@"Anna"), @"gender": @"female"},
                  }
          },
      
      @{
          @"label": @"Adjust fonts using the [font2: UIFont class].",
          @"tokens": @{@"font2": @{@"font": [UIFont fontWithName:@"Helvetica-Bold" size:26]}},
          @"tokens_desc": @"{'font2': {'font': [UIFont fontWithName:@\"ChalkboardSE-Bold\" size:14]}",
          @"attributed": @true,
          },
      @{
          @"label": @"System [bold: bold font] followed by [italic: italic font].",
          @"tokens": @{
                  @"bold": @{@"font": @{@"name": @"system", @"size": @26, @"type": @"bold"}},
                  @"italic": @{@"font": @{@"name": @"system", @"size": @26, @"type": @"italic"}}
                  },
          @"attributed": @true,
          
          },
      @{
          @"label": @"[red: Color] can be changed using a dictionary.",
          @"tokens": @{@"red": @{@"color": @"red"}},
          @"attributed": @true,
          },
      @{
          @"label": @"Color [green: can also be changed] using a UIColor class.",
          @"tokens": @{@"green": @{@"color": [UIColor greenColor]}},
          @"tokens_desc": @"{'green: {'color': [UIColor greenColor]}",
          @"attributed": @true,
          },
      @{
          @"label": @"You can even [external: overlap colors and [internal: use RGB] color scheme].",
          @"tokens": @{@"external": @{@"color": [UIColor grayColor]},
                       @"internal": @{@"color": @{@"red": @0.5, @"green": @0.2, @"blue": @0.7, @"alpha": @1}}},
          @"tokens_desc": @"{'external: {'color': [UIColor grayColor]}, 'internal': {'color': {'red': 0.5, 'green': 0.2, 'blue': 0.7, 'alpha': 1}}}",
          @"attributed": @true,
          },
      @{
          @"label": @"[purple: Background color] can also be changed using the same methods.",
          @"tokens": @{@"purple": @{@"background-color": @"purple", @"color": @"white"}},
          @"attributed": @true,
          },
      @{
          @"label": @"You can [font1: mix fonts [font2: and colors] in any way] you like.",
          @"tokens": @{
                  @"font1": @{@"color": [UIColor grayColor], @"font": [UIFont fontWithName:@"Helvetica-Bold" size:26]},
                  @"font2": @{@"background-color": @"light-gray", @"color": @{@"red": @0.5, @"green": @0.2, @"blue": @0.7, @"alpha": @1}}
                  },
          @"tokens_desc": @"  {\n  @\"font1\": {\n    @\"color\" : [UIColor grayColor],\n    @\"font\" : [UIFont fontWithName:@\"ChalkboardSE-Bold\" size:14]\n},\n  @\"font2\"  :  {\n    @\"color\" : {\n      @\"red\" : 0.5,\n      @\"green\": 0.2,\n      @\"blue\": 0.7,\n      @\"alpha\": 1\n    }\n  }\n}",
          @"attributed": @true,
          },
      @{
          @"label": @"You can [under: underline any part] of text.",
          @"tokens": @{@"under": @{@"underline": @"single"}},
          @"attributed": @true,
          },
      @{
          @"label": @"You can even indicate [under: the thickness and pattern] of the line.",
          @"tokens": @{
                  @"under": @{@"underline": @{@"style": @"thick", @"pattern": @"dot", @"byword": @"true", @"color": @"blue"}}
                  },
          @"attributed": @true,
          },
      @{
          @"label": @"You can [strike: use a strike-through] as well.",
          @"tokens": @{@"strike": @{@"strike": @"1"}},
          @"attributed": @true,
          },
      @{
          @"label": @"You can indicate the [strike: strike-through color and thickness].",
          @"tokens": @{@"strike": @{@"strike": @{@"thickness": @"3", @"color": @"purple"}}},
          @"attributed": @true,
          },
      @{
          @"label": @"[shadow: Shadows] are also very easy to add.",
          @"tokens": @{
                  @"shadow": @{@"shadow": @{@"offset": @"1,1", @"radius": @"0.5", @"color": @"blue"}}
                  },
          @"attributed": @true,
          },
      @{
          @"label": @"You can mix [decor: fonts, colors and shadows].",
          @"tokens": @{
                  @"decor": @{
                          @"shadow": @{@"offset": @"1,1", @"radius": @"0.5", @"color": @"gray"},
                          @"font": [UIFont fontWithName:@"Helvetica-Bold" size:26],
                          @"color": @"purple"
                          }
                  },
          @"tokens_desc": @"{\n  @\"decor\": {\n    @\"shadow\": {\n      @\"offset\": @\"1,1\",\n      @\"radius\": @\"0.5\", \n      @\"color\": @\"gray\"\n    },\n    @\"font\": [UIFont fontWithName:@\"Helvetica-Bold\" size:26], \n    @\"color\": @\"purple\"\n  }\n}",
          @"attributed": @true,
          }
      ];
}

@end
