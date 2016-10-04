//
//  User.h
//  TMLDemo
//
//  Created by Michael Berkovich on 10/3/16.
//  Copyright © 2016 Translation Exchange, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *gender;
@property(nonatomic) NSString *age;

- (id) initWithName: (NSString *) newName;

- (id) initWithName: (NSString *) newName age: (NSString *) newAge;

- (id) initWithName: (NSString *) newName gender: (NSString *) newGender;

- (id) initWithName: (NSString *) newName gender: (NSString *) newGender age: (NSString *) newAge;

@end
