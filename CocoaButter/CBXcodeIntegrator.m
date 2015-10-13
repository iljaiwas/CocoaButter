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
	
	XCGroup *butterGroup = [project groupWithPathFromRoot:@"CocoaButter"];
	if (butterGroup != nil)
	{
		[butterGroup removeFromParentDeletingChildren:YES];
	}
	[project.rootGroup addGroupWithPath:@"CocoaButter"];
	
	for (CBModule *module in self.modules)
	{
		[self integrateModule:module intoGroup:butterGroup];
	}
	
	[project save];

	return YES;
}

- (BOOL) integrateModule:(CBModule*) inModule intoGroup:(XCGroup*) inParentGroup
{
	//XCGroup		*moduleGroup = [inParentGroup addGroupWithPath:inModule.repositoryName];
	NSArray		*paths = [inModule effectiveFilePaths];
	
	NSLog (@"paths %@", paths);
	
	return YES;

}

@end
