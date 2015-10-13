//
//  CBGitWrapper.m
//  CocoaButter
//
//  Created by ilja on 12.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "CBGitWrapper.h"

#import "NSTask+CBAdditions.h"

@implementation CBGitWrapper

+ (BOOL) cloneRepoFromURL:(NSString*) inRepoURL intoDirectory:(NSString*) inDestinationDirectory
{
	NSParameterAssert(inRepoURL);
	NSParameterAssert(inDestinationDirectory);
	
	NSString *command = [NSString stringWithFormat:@"git clone %@ %@", inRepoURL, inDestinationDirectory];
	
	[NSTask runCommand:command];
	
	//TODO: error checking FTW!
	return YES;
}

+ (BOOL) repoAtPath:(NSString*)inRepoPath hasRevision:(NSString*) inRevision
{
	NSParameterAssert(inRepoPath);
	NSParameterAssert(inRevision);
	
	NSString *command = [NSString stringWithFormat:@"cd %@ && git describe --tags --abbrev=0", inRepoPath];
	NSString *installedRevision;

	installedRevision = [NSTask runCommand:command];
	
	//TODO: error checking FTW!
	installedRevision = [installedRevision stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	return [installedRevision isEqualToString:inRevision];
}

+ (BOOL) updateRepoAtPath:(NSString*) inRepoPath toRevision:(NSString*)inRevision
{
	NSParameterAssert(inRepoPath);
	NSParameterAssert(inRevision);
		
	NSString *command = [NSString stringWithFormat:@"cd %@ 2>&1 && " \
						 @"git reset HEAD --hard 2>&1 && " \
						 @"git checkout . 2>&1 && " \
						 @"git clean -fd 2>&1 && " \
						 @"git fetch origin %@ --tags 2>&1 && " \
						 @"git checkout %@ 2>&1", inRepoPath, inRevision, inRevision];
	[NSTask runCommand:command];
	return YES;
}

+ (BOOL) resetRepoAtPath:(NSString*) inRepoPath
{
	NSParameterAssert(inRepoPath);
	
	NSString *command = [NSString stringWithFormat:@"cd %@ 2>&1 && " \
						 @"git reset HEAD --hard 2>&1 && " \
						 @"git checkout . 2>&1 && " \
						 "git clean -fd 2>&1", inRepoPath];
	[NSTask runCommand:command];
	return YES;
}

@end
