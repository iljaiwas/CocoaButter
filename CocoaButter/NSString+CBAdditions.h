//
//  NSString+CBAdditions.h
//  CocoaButter
//
//  Created by ilja on 13.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CBAdditions)

- (NSString*)stringWithPathRelativeTo:(NSString*)anchorPath;

@end
