//
//  data.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "data.h"

@implementation Location

@end

NSArray *getCurrentData(void)
{
	NSString *indta = @"508413,065512;508413,065729;508246,065729;508079,065512;507912,065512;";
	
	NSArray *a = [indta componentsSeparatedByString: @";"];
	NSMutableArray *ret = [NSMutableArray arrayWithCapacity: [a count]+2];
	for (NSString *elem in a) {
		NSArray *b = [elem componentsSeparatedByString: @","];
		if ([b count] != 2)
			continue;
		
		Location *loc = [[[Location alloc] init] autorelease];
		loc->lat = [[b objectAtIndex: 0] intValue];
		loc->lon = [[b objectAtIndex: 1] intValue];
		[ret addObject: loc];
	}
	
	return [NSArray arrayWithArray: ret];
}