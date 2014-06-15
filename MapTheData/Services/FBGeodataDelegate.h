//
//  FBGeodataDelegate.h
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FBGeodataDelegate <NSObject>

- (void)willStartGeoLookup;
- (void)didFinishGeoLookup:(CLLocationCoordinate2D)coordinates;
- (void)didFailGeoLookup;
- (void)didReceivePermissionForUserLocation;

@end
