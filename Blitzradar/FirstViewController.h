//
//  FirstViewController.h
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	NSOperationQueue *q;
	NSTimer *t;
	NSInteger cnt;
}

@property (readwrite, retain) IBOutlet UIImageView *imageView;
@property (readwrite, retain) IBOutlet UIScrollView *scrollView;
@property (readwrite, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (readwrite, retain) IBOutlet UIBarButtonItem *statusItem;
@property (readwrite, retain) IBOutlet UIProgressView *progress;

- (IBAction) refresh: (id) sender;
- (IBAction) hartgeldFuerDeineMutter: (id) sender;

@end
