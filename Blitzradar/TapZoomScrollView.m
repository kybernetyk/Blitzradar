//
//  TapZoomScrollView.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TapZoomScrollView.h"


@implementation TapZoomScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
	UITouch *touch = [[event allTouches] anyObject]; 
	if ([touch tapCount] == 2) 
	{ 
		if(self.zoomScale > [self minimumZoomScale]) { 
			[self setZoomScale: [self minimumZoomScale] animated:YES]; 
		} else { 
			CGPoint p = [touch locationInView: self];
			p.x = -([self frame].size.width/2 - p.x);
			p.y = -([self frame].size.height/2 - p.y);
			
			
			[self setContentOffset: p animated: NO];
			[self setZoomScale: [self maximumZoomScale] animated: YES]; 
		} 
	} 
} 

@end
