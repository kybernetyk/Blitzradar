//
//  utils.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "utils.h"
#import "bounds.h"

NSString *cfg_imageName()
{
	NSString *ret = [NSString stringWithFormat: @"%s", g_LAND.img_name];
	return ret;
}

NSString *cfg_imagePath()
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *ret = [bundle pathForResource: cfg_imageName() ofType: nil];
	return ret;
}