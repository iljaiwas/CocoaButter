//
//  NSString+CBAdditions.m
//  CocoaButter
//
//  Created by ilja on 13.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "NSString+CBAdditions.h"

@implementation NSString (CBAdditions)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath {
	NSArray *pathComponents = [self pathComponents];
	NSArray *anchorComponents = [anchorPath pathComponents];
	
	NSInteger componentsInCommon = MIN([pathComponents count], [anchorComponents count]);
	for (NSInteger i = 0, n = componentsInCommon; i < n; i++) {
		if (![[pathComponents objectAtIndex:i] isEqualToString:[anchorComponents objectAtIndex:i]]) {
			componentsInCommon = i;
			break;
		}
	}
	
	NSUInteger numberOfParentComponents = [anchorComponents count] - componentsInCommon;
	NSUInteger numberOfPathComponents = [pathComponents count] - componentsInCommon;
	
	NSMutableArray *relativeComponents = [NSMutableArray arrayWithCapacity:
										  numberOfParentComponents + numberOfPathComponents];
	for (NSInteger i = 0; i < numberOfParentComponents; i++) {
		[relativeComponents addObject:@".."];
	}
	[relativeComponents addObjectsFromArray:
	 [pathComponents subarrayWithRange:NSMakeRange(componentsInCommon, numberOfPathComponents)]];
	return [NSString pathWithComponents:relativeComponents];
}

@end
