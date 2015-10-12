//
//  NSFileManager+CBAdditions.h
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CBAdditions)

- (NSArray*) subpathsOfDirectoryAtPath:(NSString *)inDirectory matchingPattern:(NSString*) inPattern;

@end
