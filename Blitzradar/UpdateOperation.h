//
//  UpdateOperation.h
//  Blitzradar
//
//  Created by jrk on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UpdateOperation : NSOperation {
	id delegate;
	NSArray *data;
}

@property (assign) id delegate;
@property (readonly) NSArray *data;

@end
