//
//  CBEngine.m
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "CBEngine.h"

#import "CBModule.h"
#import "NSFileManager+CBAdditions.h"

@interface CBEngine ()

@property NSString	*projectDirectoryPath;
@property NSString	*xcodeProjectPath;

@property NSArray	*modules;
@property NSArray	*modulesFromLockfile;

@end

@implementation CBEngine

- (instancetype) initWithProjectDirectoryPath:(NSString*) inProjectDir
{
	self = [super init];
	if (self)
	{
		NSError *error;
		
		_projectDirectoryPath = inProjectDir;
		_xcodeProjectPath = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:inProjectDir matchingPattern:@"*.xcodeproj"].firstObject;
		
		if (nil == _xcodeProjectPath)
		{
			NSLog (@"No Xcode project found in directory %@", inProjectDir);
			return nil;
		}
		if (![[NSFileManager defaultManager] fileExistsAtPath:@"CocoaButter.json"])
		{
			NSLog (@"No CocoaButter.json project found in directory %@", inProjectDir);
			return nil;
		}
		NSData	*data = [NSData dataWithContentsOfFile:@"CocoaButter.json"];
		NSArray *moduleConfigs = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
		
		if (nil == moduleConfigs)
		{
			NSLog (@"%@", error.localizedDescription);
			return nil;
		}
		for (NSDictionary *moduleConfig in moduleConfigs)
		{
			CBModule *module = [[CBModule alloc] initWithDictionary:moduleConfig butterDirectory:self.butterDirectory];
			
			[module updateIfNecessary];
		}
		
		
	}
	return self;
}


- (NSString*) butterDirectory
{
	NSString	*butterDir = [self.projectDirectoryPath stringByAppendingPathComponent:@"Butter"];
	NSError		*error;
	BOOL		isDir;
	
	if (YES == [[NSFileManager defaultManager] fileExistsAtPath:butterDir isDirectory:&isDir] && isDir)
	{
		return butterDir;
	}
	
	if (NO == [[NSFileManager defaultManager] createDirectoryAtPath:butterDir withIntermediateDirectories:YES attributes:nil error:&error])
	{
		NSLog (@"%@", error);
		return nil;
	}
	return butterDir;
}



@end
