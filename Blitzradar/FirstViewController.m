//
//  FirstViewController.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#include "utils.h"
#import "data.h"
#include "bounds.h"
@implementation FirstViewController
@synthesize imageView;
@synthesize scrollView;
@synthesize activityView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[imageView setImage: [UIImage imageNamed: cfg_imageName()]];
	CGRect sz = [imageView frame];
	sz.size = [[UIImage imageNamed: cfg_imageName()] size];

	[imageView setFrame: sz];
	[scrollView setContentSize: sz.size];

	
	[self refresh: self];
	
	if (imageView.frame.size.height >= imageView.frame.size.width)
		[scrollView setMinimumZoomScale: scrollView.frame.size.height / imageView.frame.size.height];
	else 
		[scrollView setMinimumZoomScale: scrollView.frame.size.width / imageView.frame.size.width];

	
	[scrollView setZoomScale:scrollView.minimumZoomScale];
	
	NSTimer *t = [NSTimer scheduledTimerWithTimeInterval: 60.0
												   target: self
												 selector:@selector(refresh:)
												 userInfo: nil
												  repeats: YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
}

CGPoint loc_to_map(Location *loc)
{
	double min_lon = g_LAND.lon_min;
	double max_lon = g_LAND.lon_max;
	double lon = ([loc lon] - min_lon);
	double deg_dist = fabs(max_lon - min_lon);
	double img_w = g_LAND.px_w;
	double convf = img_w/deg_dist;
	double x = lon * convf;

	double min_lat = g_LAND.lat_min;
	double max_lat = g_LAND.lat_max;
	double lat = ([loc lat] - min_lat);
	deg_dist = fabs(max_lat - min_lat);
	double img_h = g_LAND.px_h;
	convf = img_h/deg_dist;
	double y = img_h - lat * convf;

	return CGPointMake(x, y);
}



#pragma mark - handler
- (IBAction) refresh: (id) sender
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
	[[self activityView] startAnimating];
	NSArray *data = getCurrentData();
	
	UIImage *img = [[UIImage alloc] initWithContentsOfFile: cfg_imagePath()];

	UIGraphicsBeginImageContext([img size]); 
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	{
		//draw map image
		[img drawAtPoint:CGPointZero];

		//draw "%i Blitze texte"
		UIGraphicsPushContext(context); 
		{
			NSString *s = [NSString stringWithFormat: @"%i Blitze", [data count]];

			CGContextSetLineWidth(context, 6.0 );
			
			CGContextSetTextDrawingMode(context, kCGTextStroke);
			CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
			[s drawAtPoint: CGPointZero 
				  withFont: [UIFont fontWithName:@"Helvetica-Bold" size:72.0]
			 ];
			
			CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
			CGContextSetTextDrawingMode(context, kCGTextFill);
			[s drawAtPoint: CGPointZero 
				  withFont: [UIFont fontWithName:@"Helvetica-Bold" size:72.0]
			 ];
			
		} 
		UIGraphicsPopContext();

		//draw red dots @ blitz location
		CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.3);
		for (Location *loc in data) {
			CGPoint p = loc_to_map(loc);
			
			NSLog(@"lat: %f, lon: %f", [loc lat], [loc lon]);
			NSLog(@"x: %f, y: %f", p.x, p.y);
			
			float radius = 12.0;
			CGRect leftOval = {p.x - radius/2, p.y - radius/2, radius, radius};
			CGContextAddEllipseInRect(context, leftOval);
			CGContextFillPath(context);
		}

	}
	UIGraphicsPopContext();
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext();
	[img release];
	[imageView setImage: outputImage];


	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: NO];
	[[self activityView] stopAnimating];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return [self imageView];
}

- (CGRect)centeredFrameForScrollView:(UIScrollView *)scroll andUIView:(UIView *)rView {
	CGSize boundsSize = scroll.bounds.size;
	CGRect frameToCenter = rView.frame;
	// center horizontally
	if (frameToCenter.size.width < boundsSize.width) {
		frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
	}
	else {
		frameToCenter.origin.x = 0;
	}
	// center vertically
	if (frameToCenter.size.height < boundsSize.height) {
		frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
	}
	else {
		frameToCenter.origin.y = 0;
	}
	return frameToCenter;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
	[self imageView].frame = [self centeredFrameForScrollView: [self scrollView] andUIView: [self imageView]];
}

@end
