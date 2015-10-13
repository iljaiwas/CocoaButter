//
//  CBGitWrapper.h
//  CocoaButter
//
//  Created by ilja on 12.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBGitWrapper : NSObject

+ (BOOL) cloneRepoFromURL:(NSString*) inRepoURL intoDirectory:(NSString*) inDestinationDirectory;
+ (BOOL) repoAtPath:(NSString*)inRepoPath hasRevision:(NSString*) inRevision;
+ (BOOL) updateRepoAtPath:(NSString*) inRepoPath toRevision:(NSString*)inRevision;
+ (BOOL) resetRepoAtPath:(NSString*) inRepoPath;

@end
