//
//  CBXcodeIntegrator.m
//  CocoaButter
//
//  Created by ilja on 13.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "CBXcodeIntegrator.h"

#import "CBModule.h"
#import "NSColorLog.h"
#import "XCProject.h"
#import "XCGroup.h"
#import "XCSourceFileDefinition.h"
#import "XCSourceFile.h"

#import "NSString+CBAdditions.h"

@interface XCGroup (Additions)

- (void)makeGroupMemberWithName:(NSString*)name
						   path:(NSString*)path
						   type:(XcodeSourceFileType)type
			 fileOperationStyle:(XCFileOperationType)fileOperationStyle;

- (id <XcodeGroupMember>)memberWithDisplayName:(NSString*)name;

- (void)addSourceFile:(XCSourceFile*)sourceFile toTargets:(NSArray*)targets;
@end

@interface CBXcodeIntegrator ()

@property NSString* projectPath;
@property NSArray*	modules;

@end

@implementation CBXcodeIntegrator

- (instancetype) initWithProjectFileAtPath:(NSString*) inPath modules:(NSArray*)inModules
{
	NSParameterAssert(inPath);
	NSParameterAssert(inModules);
	
	self = [super init];
	if (self)
	{
		_projectPath = inPath;
		_modules = inModules;
	}
	return self;
}

- (BOOL) integrateModulesIntoXcodeProject
{
	XCProject* project = [[XCProject alloc] initWithFilePath:self.projectPath];
	
	if (project == nil)
	{
		NSLogRed (@"reading xcode project file at path % failed", self.projectPath);
		return NO;
	}
	
	XCGroup *butterGroup = [project groupWithPathFromRoot:@"CocoaButterGroup"];
	if (butterGroup != nil)
	{
		[butterGroup removeFromParentDeletingChildren:NO];
	}
	// TODO: for some reason XcodeEditor wants to back up every group by a directory on disk. That's not what we want here.
	[project.rootGroup addGroupWithPath:@"CocoaButterGroup"];
	
	for (CBModule *module in self.modules)
	{
		[self integrateModule:module intoGroup:butterGroup targets:project.targets];
	}
	
	[project save];

	return YES;
}

- (BOOL) integrateModule:(CBModule*) inModule intoGroup:(XCGroup*) inParentGroup targets:(NSArray*)targets
{
	XCGroup		*moduleGroup = [inParentGroup addGroupWithPath:inModule.repositoryName];
	NSArray		*paths = [inModule effectiveFilePaths];
	
	NSLog (@"found %ld paths", paths.count);
	
	for (NSString *filePath in paths)
	{
		// TODO: get XCGroup to add file references with relative paths.
		//NSString *relativePath = [filePath stringWithPathRelativeTo:[self.projectPath stringByDeletingLastPathComponent]];
		
		[moduleGroup makeGroupMemberWithName:filePath.lastPathComponent
										path:filePath
										type:XCSourceFileTypeFromFileName(filePath)
						  fileOperationStyle:XCFileOperationTypeReferenceOnly];
		
		XCSourceFile* sourceFile = (XCSourceFile*) [moduleGroup memberWithDisplayName:filePath.lastPathComponent];
		if ([sourceFile canBecomeBuildFile])
		{
			// TODO: add support for a target pattern. If not given, the first target is the integration pattern.
			[moduleGroup addSourceFile:sourceFile toTargets:@[targets.firstObject]];
		}
	}
	
	return YES;

}

@end
