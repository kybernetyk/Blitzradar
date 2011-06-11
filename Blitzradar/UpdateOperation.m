//
//  UpdateOperation.m
//  Blitzradar
//
//  Created by jrk on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UpdateOperation.h"
#import "data.h"

@implementation UpdateOperation
@synthesize delegate;
@synthesize data;
- (void) main 
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	data = getCurrentData();
	

	[delegate performSelectorOnMainThread: @selector(updateOperationDidFinish:) withObject: self waitUntilDone: YES];

	
	
	[pool drain];
}

@end
