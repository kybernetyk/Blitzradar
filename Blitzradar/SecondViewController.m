//
//  SecondViewController.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

//- (void)viewDidAppear:(BOOL)animated
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear: animated];
	
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	BOOL pro_e = [defs boolForKey: @"pro_e"];
	float pro_1 = [defs floatForKey: @"pro_1"];
	float pro_2 = [defs floatForKey: @"pro_2"];
	float pro_3 = [defs floatForKey: @"pro_3"];
	
	if (!pro_e) {
		for (id view in [[self view] subviews]) {
			if ([view tag] > 0 && [view tag] < 10)
				[view setEnabled: NO];
		}
		[(UISwitch*)[[self view] viewWithTag: 11] setOn: NO];
		return;		
	}
	[(UISlider*)[[self view] viewWithTag: 3] setValue: pro_1];
	[(UISlider*)[[self view] viewWithTag: 4] setValue: pro_2];
	[(UISlider*)[[self view] viewWithTag: 5] setValue: pro_3];
}
- (void)viewWillDisappear:(BOOL)animated
{
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];

	float pro_1 = [(UISlider*)[[self view] viewWithTag: 3] value];
	float pro_2 = [(UISlider*)[[self view] viewWithTag: 4] value];
	float pro_3 = [(UISlider*)[[self view] viewWithTag: 5] value];
	
	[defs setFloat: pro_1 forKey: @"pro_1"];
	[defs setFloat: pro_2 forKey: @"pro_2"];
	[defs setFloat: pro_3 forKey: @"pro_3"];
	[defs synchronize];
}

- (IBAction) proChanged: (id) sender 
{
	if ([sender isOn]) {
		for (id view in [[self view] subviews]) {
			if ([view tag] > 0 && [view tag] < 10)
				[view setEnabled: YES];
		}
	} else {
		for (id view in [[self view] subviews]) {
			if ([view tag] > 0 && [view tag] < 10)
				[view setEnabled: NO];
		}
	}
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	[defs setBool: [sender isOn] forKey: @"pro_e"];
	[defs synchronize];
}

- (IBAction) sliderChanges: (id) sender
{
	float val = [(UISlider*)sender value];
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	NSString *key = nil;
	switch ([sender tag]) {
		case 3:
			key = @"pro_1";
			break;
		case 4:
			key = @"pro_2";
			break;
		case 5:
			key = @"pro_3";	
			break;
	}
	[defs setFloat: val forKey: key];
	[defs synchronize];
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

@end
