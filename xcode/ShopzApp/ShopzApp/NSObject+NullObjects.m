//
//  NSObject+NullObjects.m
//  Fluc Delivery
//
//  Created by Francisco Magdaleno on 11/17/13.
//  Copyright (c) 2013 Fluc. All rights reserved.
//

#import "NSObject+NullObjects.h"

@implementation NSObject (NullObjects)

-(id)nilIfNull
{
    if (self == [NSNull null]) {
        return nil;
    }
    return self;
}

@end
