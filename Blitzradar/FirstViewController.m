//
//  FirstViewController.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#include "utils.h"

@implementation FirstViewController
@synthesize imageView;
@synthesize scrollView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[imageView setImage: [UIImage imageNamed: cfg_imageName()]];

	[self refresh: self];
	
	[scrollView setZoomScale:scrollView.minimumZoomScale];
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

#pragma mark - handler
- (IBAction) refresh: (id) sender
{
	UIImage *img = [[UIImage alloc] initWithContentsOfFile: cfg_imagePath()];
	
	CGRect sz = [imageView frame];
	sz.size = [img size];
	[imageView setFrame: sz];
	[scrollView setContentSize: sz.size];

	UIGraphicsBeginImageContext([img size]); 
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	int lat = [img size].width/2;
	int lon = [img size].height/2;
	int radius = 50;
	
	[img drawAtPoint:CGPointZero];
	
	CGRect leftOval = {lat- radius/2, lon - radius/2, radius, radius};
	CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
	CGContextAddEllipseInRect(context, leftOval);
	CGContextFillPath(context);
	
	UIGraphicsPopContext();
	UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext(); 
	UIGraphicsEndImageContext();
	[img release];
	[imageView setImage: outputImage];

	if (imageView.frame.size.height >= imageView.frame.size.width)
		[scrollView setMinimumZoomScale: scrollView.frame.size.height / imageView.frame.size.height];
	else 
		[scrollView setMinimumZoomScale: scrollView.frame.size.width / imageView.frame.size.width];

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
