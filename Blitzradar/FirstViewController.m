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
	NSLog(@"did load");
    [super viewDidLoad];
	
	[imageView setImage: [UIImage imageNamed: cfg_imageName()]];
	NSLog(@"iv: %@", imageView);
	NSLog(@"in: %@", cfg_imageName());
	NSLog(@"sv.frame: %@", [NSValue valueWithCGRect: [scrollView frame]]);

	[self refresh: self];
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
	NSLog(@"path: %@", cfg_imagePath());
	NSLog(@"img: %@", img);
	NSLog(@"img size: %@", [NSValue valueWithCGSize: [img size]]);
	
	
	CGRect sz = [imageView frame];
	sz.size = [img size];
	[imageView setFrame: sz];
//	sz.size.height -= 71;
	[scrollView setContentSize: sz.size];

	NSLog(@"iv.frame: %@", [NSValue valueWithCGRect: [imageView frame]]);
	NSLog(@"sv.frame: %@", [NSValue valueWithCGRect: [scrollView frame]]);
	NSLog(@"sv.csize: %@", [NSValue valueWithCGSize: [scrollView contentSize]]);
	
	UIGraphicsBeginImageContext([img size]); 
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
	int lat = [img size].width/2;
	int lon = [img size].height/2;
	int radius = 50;
	
	/* Put any sort of drawing code here */
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
}

@end
