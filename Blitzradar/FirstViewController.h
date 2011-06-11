//
//  FirstViewController.h
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {

}

@property (readwrite, retain) IBOutlet UIImageView *imageView;
@property (readwrite, retain) IBOutlet UIScrollView *scrollView;
@property (readwrite, retain) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction) refresh: (id) sender;

@end
