//
//  FBUser.h
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "FBGeodataDelegate.h"

@interface FBUser : NSObject

@property(nonatomic, assign) BOOL isSharingLocation;
@property(nonatomic, strong) id<FBGeodataDelegate> delegate;

+ (instancetype)sharedUser;

- (CLLocationCoordinate2D)coordinates;

@end
