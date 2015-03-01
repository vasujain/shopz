//
//  NSObject+NullObjects.h
//  Fluc Delivery
//
//  Created by Francisco Magdaleno on 11/17/13.
//  Copyright (c) 2013 Fluc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NullObjects)

/**
 * If the object is null, turns it to nil
 * @author Francisco Magdaleno
 *
 */
-(id)nilIfNull;

@end
