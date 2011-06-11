//
//  data.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "data.h"
#import "bounds.h"

@implementation Location
@synthesize lat;
@synthesize lon;
@end

NSArray *getCurrentData(void)
{
	NSURL *u = [NSURL URLWithString: [NSString stringWithFormat: g_DATA_URL, g_LAND.data_file]];
	NSLog(@"fetching from: %@", u);
	
//	NSString *indta = @"51.6095,07.1371;51.5928,07.1154;51.5594,07.1154;51.5594,07.1371;51.5427,07.1154;51.5427,07.1371;51.5093,07.1154;51.1753,06.2474;51.1753,06.2691;51.1586,06.2474;51.1586,06.2691;51.0417,05.5530;51.0417,05.5747;51.0250,08.5693;51.0250,05.5530;51.0250,05.5747;51.0083,08.5476;51.0083,08.5693;51.0083,05.3143;51.0083,05.5313;50.9916,05.2926;50.9916,05.5096;50.9916,05.5313;";
	
	
	NSString *indta = [NSString stringWithContentsOfURL: u encoding: NSUTF8StringEncoding error: nil];
	NSLog(@"indta: %@", indta);
	if ([indta length] == 0)
		return nil;
	
	NSArray *a = [indta componentsSeparatedByString: @";"];
	if ([a count] == 0)
		return nil;
	
	NSMutableArray *ret = [NSMutableArray arrayWithCapacity: [a count]+2];
	for (NSString *elem in a) {
		NSArray *b = [elem componentsSeparatedByString: @","];
		if ([b count] != 2)
			continue;
		
		Location *loc = [[[Location alloc] init] autorelease];
		[loc setLat: [[b objectAtIndex: 0] doubleValue]];
		[loc setLon: [[b objectAtIndex: 1] doubleValue]];
		[ret addObject: loc];
	}
	
	return [NSArray arrayWithArray: ret];
}

NSArray *getMetaData(void)
{
	NSURL *u = [NSURL URLWithString: [NSString stringWithFormat: g_DATA_URL, g_LAND.metadata_file]];
	
	NSLog(@"fetching from: %@", u);
	
	//	NSString *indta = @"51.6095,07.1371;51.5928,07.1154;51.5594,07.1154;51.5594,07.1371;51.5427,07.1154;51.5427,07.1371;51.5093,07.1154;51.1753,06.2474;51.1753,06.2691;51.1586,06.2474;51.1586,06.2691;51.0417,05.5530;51.0417,05.5747;51.0250,08.5693;51.0250,05.5530;51.0250,05.5747;51.0083,08.5476;51.0083,08.5693;51.0083,05.3143;51.0083,05.5313;50.9916,05.2926;50.9916,05.5096;50.9916,05.5313;";
	
	
	NSString *indta = [NSString stringWithContentsOfURL: u encoding: NSUTF8StringEncoding error: nil];
	NSLog(@"indta: %@", indta);
	if ([indta length] == 0)
		return nil;
	
	NSArray *a = [indta componentsSeparatedByString: @";"];
	if ([a count] == 0)
		return nil;

	a = [[a objectAtIndex: 0] componentsSeparatedByString: @","];
	if ([a count] == 0)
		return nil;
	
	return a;
}