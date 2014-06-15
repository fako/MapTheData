//
//  FBGeodata.m
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import "FBGeodata.h"

@implementation FBGeodata

+ (instancetype)sharedGeodata
{
    static FBGeodata *geodata;
    @synchronized(self) {
        if(!geodata) {
            
            geodata = [self new];
            
            geodata.locationManager = [[CLLocationManager alloc] init];
            geodata.locationManager.delegate = geodata;
            [geodata.locationManager startUpdatingLocation]; // maybe should detach the detection of location from init, to time permission question optimaly
            
            geodata.geocoder = [[CLGeocoder alloc] init];
        }
    }
    return geodata;
}

#pragma mark - Geo-encode methods

- (void)coordinatesFromAddressString:(NSString*)address {
    
    NSAssert(self.delegate, @"Delegate has not been set for FBGeodata");
    
    if([self.delegate respondsToSelector:@selector(willStartGeoLookup)]) {
        [self.delegate performSelector:@selector(willStartGeoLookup)];
    }

    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(error) {
            if([self.delegate respondsToSelector:@selector(didFailGeoLookup)]) {
                [self.delegate performSelector:@selector(didFailGeoLookup)];
            }
        } else {
            CLLocationCoordinate2D coordinate = ((CLPlacemark*)placemarks[0]).location.coordinate;
            if([self.delegate respondsToSelector:@selector(didFinishGeoLookup:)]) {
                [self.delegate didFinishGeoLookup:coordinate];
            }
        }
        
    }];
    
}

#pragma mark - CLLocationManager delegate methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorized && self.delegate && [self.delegate respondsToSelector:@selector(didReceivePermissionForUserLocation)]) {
        [self.delegate didReceivePermissionForUserLocation];
    }
}

@end
