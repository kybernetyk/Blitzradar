//
//  data.h
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject {
@public
	int lat;
	int lon;
}
@end

extern NSArray *getCurrentData(void);

