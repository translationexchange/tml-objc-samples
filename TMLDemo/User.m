//
//  User.m
//  TMLDemo
//
//  Created by Michael Berkovich on 10/3/16.
//  Copyright © 2016 Translation Exchange, Inc. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name, gender, age;

- (id) initWithName: (NSString *) newName {
    return [self initWithName: newName gender: @"unknown" age: 0];
}

- (id) initWithName: (NSString *) newName age: (NSString *) newAge {
    return [self initWithName: newName gender: @"unknown" age: newAge];
}

- (id) initWithName: (NSString *) newName gender: (NSString *) newGender {
    return [self initWithName: newName gender: newGender age: 0];
}

- (id) initWithName: (NSString *) newName gender: (NSString *) newGender age: (NSString *) newAge {
    if (self = [super init]) {
        self.name = newName;
        self.gender = newGender;
        self.age = newAge;
    }
    return self;
}

- (NSString *) description {
    return self.name;
}

@end
