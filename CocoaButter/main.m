//
//  main.m
//  CocoaButter
//
//  Created by ilja on 09.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CBEngine.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		
		char *workingDirectory;
		
		workingDirectory = malloc(MAXPATHLEN);
		getcwd(workingDirectory, MAXPATHLEN);
		
		CBEngine *engine = [[CBEngine alloc] initWithProjectDirectoryPath:[NSString stringWithCString:workingDirectory encoding:NSUTF8StringEncoding]];
		free(workingDirectory);
		
		if (nil == engine)
		{
			return -1;
		}
		[engine updateRepositories];
		[engine integrateIntoXcodeProject];
		
	}
    return 0;
}
