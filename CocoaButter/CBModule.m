//
//  CBModule.m
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "CBModule.h"

#import "CBGitWrapper.h"
#import "NSColorLog.h"

@interface CBModule ()

/** Identifies a code repo on GitHub */
@property (nonatomic) NSString *repo;

/** A pattern matching all project target names in your Xcode project, the sources from this module should be included. If ommited, files will be only added to the first target. */

@property NSString *target;

/** The release which should be checked out. */

@property NSString *revision;

/** An optional branch. If specificied, the head of the branch is checked out. */

@property NSString *branch;

/** An optional commit hash. */

@property NSString *commitHash;

/* A shell pattern for files that have been matched by include filter that should not be included in the project. */

@property NSString *includeFilter;

/* A shell pattern for files that have been matched by include filter that should not be included in the project. */
@property NSString *excludeFilter;

/** An optional dictionary specifingy special compile option, such as ARC or no-ARC. Key: shell pattern, value: compile options for machted files. */
@property NSDictionary *compileOptions;

/** the directory all repos should be checked out in */
@property NSString *butterDirectory;


@end

@implementation CBModule


- (instancetype) initWithDictionary:(NSDictionary*) inDict butterDirectory:(NSString*) inButterDirectory
{
	NSParameterAssert(inDict);
	NSParameterAssert(inButterDirectory);
	
	self = [super init];
	{
		for (NSString *key in inDict)
		{
			// TODO: check if the key can be set by using respondsToSelector
			[self setValue:inDict[key] forKey:key];
		}
		_butterDirectory = inButterDirectory;
	}
	return self;
}

- (void) setRepo:(NSString *)inRepo
{
	NSAssert([inRepo componentsSeparatedByString:@"/"].count == 2, @"GitHub should have both username and repo name");
	
	_repo = inRepo;
}

- (BOOL) needsCheckout
{
	BOOL isDir;
	
	if (NO == [[NSFileManager defaultManager] fileExistsAtPath:self.repositoryDirectory isDirectory:&isDir])
	{
		return YES;
	}
	if (isDir == NO)
	{
		return YES;
	}
	
	return NO;
}

- (BOOL) needsUpdateToDifferentRevision
{
	if (self.revision && ![CBGitWrapper repoAtPath:self.repositoryDirectory hasRevision:self.revision])
	{
		return YES;
	}
	
	return NO;
}

- (NSString*) repositoryDirectory
{
	return [self.butterDirectory stringByAppendingPathComponent:self.repositoryName];
}

- (NSString*) repositoryName
{
	return [self.repo lastPathComponent];
}

- (void) updateIfNecessary
{
	if (self.needsCheckout)
	{
		[CBGitWrapper cloneRepoFromURL:self.repoURL intoDirectory:self.repositoryDirectory];
	}
	else if (self.needsUpdateToDifferentRevision)
	{
		NSLogGreen (@"Installing %@ %@", self.repo, self.revision);

		[CBGitWrapper updateRepoAtPath:self.repositoryDirectory toRevision:self.revision];
	}
	else
	{
		NSLog (@"Using %@ %@", self.repo, self.revision);
	}
}

- (NSString*) repoURL
{
	return [NSString stringWithFormat:@"https://github.com/%@", self.repo];
}
@end
