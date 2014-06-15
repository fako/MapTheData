//
//  FBGeodata.h
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "FBGeodataDelegate.h"

@interface FBGeodata : NSObject <CLLocationManagerDelegate>

+ (instancetype)sharedGeodata;

@property(strong, nonatomic) CLLocationManager *locationManager;
@property(strong, nonatomic) CLGeocoder *geocoder;
@property(strong, nonatomic) id<FBGeodataDelegate> delegate;

- (void)coordinatesFromAddressString:(NSString*)address;

@end
