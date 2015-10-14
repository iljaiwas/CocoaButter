//
//  NSFileManager+CBAdditions.m
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import "NSFileManager+CBAdditions.h"

#include <glob.h>

@implementation NSFileManager (CBAdditions)


- (NSArray*) subpathsOfDirectoryAtPath:(NSString *)inDirectory matchingPattern:(NSString*) inPattern
{
	NSMutableArray* files = [NSMutableArray array];
	glob_t			gt;
	NSString*		globPathComponent = [NSString stringWithFormat: @"/%@", inPattern];
	NSString*		expandedDirectory = [inDirectory stringByExpandingTildeInPath];
	const char*		fullPattern = [[expandedDirectory stringByAppendingPathComponent: globPathComponent] UTF8String];
	int				globReturn;
	
	globReturn= glob(fullPattern, GLOB_BRACE, NULL, &gt);
	if ( globReturn == 0)
	{
		for (int i=0; i<gt.gl_matchc; i++)
		{
			NSInteger len = strlen(gt.gl_pathv[i]);
			NSString* filename = [[NSFileManager defaultManager] stringWithFileSystemRepresentation: gt.gl_pathv[i] length: len];
			[files addObject: filename];
		}
	}
	globfree(&gt);
	return [NSArray arrayWithArray: files];
}

//- (NSArray*) subpathsOfDirectoryAtPath:(NSString *)path matchingPattern:(NSString*) inPattern error:(NSError**) error
//{
//	NSArray				*subpaths;
//	//NSRegularExpression *expression;
//	NSMutableArray		*matches = [NSMutableArray array];
//	
//	subpaths = [self subpathsOfDirectoryAtPath:path error:error];
//	if (subpaths == nil)
//	{
//		return nil;
//	}
//	
//	glob_t gt;
//	
//	if (glob(fullPattern, 0, NULL, &gt) == 0) {
//		int i;
//		for (i=0; i<gt.gl_matchc; i++) {
//			int len = strlen(gt.gl_pathv[i]);
//			NSString* filename = [[NSFileManager defaultManager] stringWithFileSystemRepresentation: gt.gl_pathv[i] length: len];
//			[files addObject: filename];
//		}
//	}
//	globfree(&gt);

	
//	expression = [NSRegularExpression regularExpressionWithPattern:inPattern options:0 error:error];
//	if (expression == nil)
//	{
//		return nil;
//	}
//	
//	for (NSString *subpath in subpaths)
//	{
//		if ([expression numberOfMatchesInString:subpath options:0 range:NSMakeRange(0, subpath.length)])
//		{
//			[matches addObject:subpath];
//		}
////	}
//	return matches.copy;
//}

@end
