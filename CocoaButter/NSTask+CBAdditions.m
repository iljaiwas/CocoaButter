//
//  NSTask+CBAdditions.m
//  CocoaButter
//
//  Created by ilja on 12.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "NSTask+CBAdditions.h"

@implementation NSTask (CBAdditions)

+ (NSString*) runCommand:(NSString*) inCommand
{
	NSTask	*task;
	NSArray *components = [inCommand componentsSeparatedByString:@" "];
	
	task = [[NSTask alloc] init];
	[task setLaunchPath:@"/bin/sh"];
	
	if (components.count > 1)
	{
		[task setArguments: [@[@"-c"] arrayByAddingObject:inCommand]];
	}
	
	NSPipe *pipe;
	pipe = [NSPipe pipe];
	[task setStandardOutput: pipe];
	
	NSFileHandle *file;
	file = [pipe fileHandleForReading];
	
	[task launch];
	
	NSData *data;
	data = [file readDataToEndOfFile];
	
	NSString *string;
	string = [[NSString alloc] initWithData: data
								   encoding: NSUTF8StringEncoding];
	return string;
}

@end
