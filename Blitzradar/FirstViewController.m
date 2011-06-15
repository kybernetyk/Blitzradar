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
#import "UpdateOperation.h"
@implementation FirstViewController
@synthesize imageView;
@synthesize scrollView;
@synthesize activityView;
@synthesize statusItem;
@synthesize progress;

- (IBAction) hartgeldFuerDeineMutter: (id) sender
{
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	[defs setInteger: ![defs integerForKey: @"imgmode"] forKey: @"imgmode"];
	[defs synchronize];
	[self refresh: self];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[imageView setImage: [UIImage imageNamed: cfg_imageName()]];
	CGRect sz = [imageView frame];
	sz.size = [[UIImage imageNamed: cfg_imageName()] size];

	[imageView setFrame: sz];
	[scrollView setContentSize: sz.size];

	

/*	if (imageView.frame.size.height >= imageView.frame.size.width)
		[scrollView setMinimumZoomScale: scrollView.frame.size.height / imageView.frame.size.height];
	else 
		[scrollView setMinimumZoomScale: scrollView.frame.size.width / imageView.frame.size.width];
*/
	
		[scrollView setMinimumZoomScale: scrollView.frame.size.width / imageView.frame.size.width];
	[scrollView setZoomScale:scrollView.minimumZoomScale];
	cnt = 0;
	t = [NSTimer scheduledTimerWithTimeInterval: 1.0
												   target: self
												 selector:@selector(refreshTimer:)
												 userInfo: nil
												  repeats: YES];
	
	q = [[NSOperationQueue alloc] init];
	[q setMaxConcurrentOperationCount: 1];
	
		[self refresh: self];
}

- (void) refreshTimer:(NSTimer*) timer
{
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	if (![defs boolForKey: @"aktu"])
		return;
	
	cnt++;
	if (cnt == 60) {
		cnt = 0;
		[self refresh: self];
	}
	float prgrs = (1.0/60.0 * (float)cnt);
	NSLog(@"prgrs: %f", prgrs);
	[progress setProgress: prgrs];
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
	[q release];
	q = nil;
	[t invalidate];
	[self setImageView: nil];
	[self setScrollView: nil];
	[self setActivityView: nil];
	[self setStatusItem: nil];
	[self setProgress: nil];
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
	cnt = 0; //next automated refresh in 1 min
	float prgrs = (1.0/60.0 * (float)cnt);
	NSLog(@"prgrs: %f", prgrs);
	[progress setProgress: prgrs];

	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: YES];
	[[self activityView] startAnimating];
	[statusItem setTitle: @"Aktualisiere ..."];
	UpdateOperation *op = [[[UpdateOperation alloc] init] autorelease];
	[op setDelegate: self];
	[q addOperation: op];
}

- (void)updateOperationDidFinish: (UpdateOperation *) op
{
	NSArray *data = [op data];
	UIImage *img = [[UIImage alloc] initWithContentsOfFile: cfg_imagePath()];
	
	UIGraphicsBeginImageContext([img size]); 
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	{
		//draw map image
		[img drawAtPoint:CGPointZero];
#if 0
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
#endif
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
	
//	NSDate *now = [NSDate date];
//	NSString *dstr = [now desc

//	NSDateFormatter *inFormat = [[[NSDateFormatter alloc] init] autorelease];
//	[inFormat setDateFormat:@"HH:mm"];
//	NSString *dstr = [inFormat stringFromDate: now];

	NSString *dstr = [[op metadata] objectAtIndex: 1];
	NSString *s = [NSString stringWithFormat: @"%i Blitze @ %@", [data count], dstr];
	
	[statusItem setTitle: s];
	
	cnt = 0; //next automated refresh in 1 min
	float prgrs = (1.0/60.0 * (float)cnt);
	NSLog(@"prgrs: %f", prgrs);
	[progress setProgress: prgrs];


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
