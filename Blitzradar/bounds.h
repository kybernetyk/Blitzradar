//
//  bounds.h
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#pragma once

struct bounds_t {
	double lat_min, lat_max;
	double lon_min, lon_max;
	
	double px_w, px_h;
	char img_name[255];
	char data_file[255];
	char metadata_file[255];
};

extern struct bounds_t g_bnds_poland;
extern struct bounds_t g_bnds_germany;
