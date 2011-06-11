//
//  data.h
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject {
	double lat;
	double lon;
}

@property (readwrite, assign) double lat;
@property (readwrite, assign) double lon;

@end


extern NSArray *getCurrentData(void);
extern NSArray *getMetaData(void);

