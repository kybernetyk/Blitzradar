//
//  bounds.c
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "bounds.h"

struct bounds_t g_bnds_poland = {
	.lat_min =  493500,
	.lat_max = 550500,
	
	.lon_min = 133934,
	.lon_max = 242754,
	
	.px_w = 500,
	.px_h = 460,
	.img_name = "pl.jpg",
};

struct bounds_t g_bnds_germany = {
	.lat_min =  455000,
	.lat_max = 552000,
	
	.lon_min = 50756,
	.lon_max = 155346,
	
	.px_w = 480,
	.px_h = 580,
	.img_name = "de.jpg",
};
