//
//  FBUser.m
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import "FBUser.h"
#import "FBGeodata.h"

@implementation FBUser

@dynamic isSharingLocation;

#pragma mark - Inits

+ (instancetype)sharedUser
{
    static FBUser *user;
    @synchronized(self) {
        if(!user) {
            user = [self new];
        }
    }
    return user;
}

#pragma mark - Getters and setters

- (BOOL)isSharingLocation
{
    BOOL sharing = (BOOL)[FBGeodata sharedGeodata].locationManager.location; // location is nil if it is never shared
    if(!sharing) {
        [FBGeodata sharedGeodata].delegate = self.delegate; // if it comes in in the future the delegate will be informed
    }
    return sharing;
}

- (CLLocationCoordinate2D)coordinates {
    return [FBGeodata sharedGeodata].locationManager.location.coordinate;
}

@end
