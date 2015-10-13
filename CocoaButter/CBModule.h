//
//  CBModule.h
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBModule : NSObject

- (instancetype) initWithDictionary:(NSDictionary*) inDict butterDirectory:(NSString*) inButterDirectory;

- (BOOL)		updateIfNecessary;

- (NSString*)	repositoryName;
- (NSArray*)	effectiveFilePaths;

@end
