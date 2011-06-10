//
//  bounds.c
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "bounds.h"

struct bounds_t g_bnds_poland = {
	.lat_min =  48.799627,
	.lat_max = 55.055787,
	
	.lon_min = 13.31543,
	.lon_max = 24.2754,
	
	.px_w = 500.0,
	.px_h = 460.0,
	.img_name = "pl.jpg",
	.data_file = "aktkartepolengrau.jpg_out.txt",
};

struct bounds_t g_bnds_germany = {
	.lat_min = 47.212106,
	.lat_max = 55.253203,
	
	.lon_min = 5.0056,
	.lon_max = 15.5346,
	
	.px_w = 480.0,
	.px_h = 580.0,
	.img_name = "de.jpg",
	.data_file = "aktkartegergrau.jpg_out.txt",
};
