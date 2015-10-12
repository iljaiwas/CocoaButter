//
//  NSColorLog.m
//  CocoaButter
//
//  Created by ilja on 12.10.15.
//  Copyright © 2015 iwascoding GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

void NSLogGreen (NSString *format, ...)
{
	NSString *newFormat = [NSString stringWithFormat:@"\e[1;32m%@\e[m", format];
	va_list		ap;

	va_start(ap, format);
	NSLogv(newFormat, ap);
	va_end(ap);
}
