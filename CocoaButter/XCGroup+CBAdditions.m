//
//  XCGroup+CBAdditions.m
//  CocoaButter
//
//  Created by ilja on 13.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "XCGroup+CBAdditions.h"

#import "XCSourceFileDefinition.h"

@implementation XCGroup (CBAdditions)

/** Seems adding file references is not directly support by the XcodeEditor project. Trying to have something here. */

- (void)addSourceFile:(XCSourceFileDefinition*)sourceFileDefinition withPath:(NSString*)targetPath
{
	[self makeGroupMemberWithName:[sourceFileDefinition sourceFileName]
						 contents:[sourceFileDefinition data]
							 type:[sourceFileDefinition type]
			   fileOperationStyle:[sourceFileDefinition fileOperationStyle]
						 withPath:targetPath];
	[[_project objects] setObject:[self asDictionary] forKey:_key];
}

@end
