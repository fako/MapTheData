//
//  FBLocation.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

#import "FBServerDelegate.h"
#import "FBDatabaseDelegate.h"
#import "FBGeodataDelegate.h"

@interface FBLocation : NSManagedObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* secondaryName;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSNumber* typeNumber;
@property (nonatomic, copy) NSNumber* lat;
@property (nonatomic, copy) NSNumber* lng;

+ (void)loadFromServer:(id<FBServerDelegate>)delegate;
+ (BOOL)locationsExistInDatabase;

+ (void)searchFor:(NSString*)term delegate:(id<FBDatabaseDelegate>)delegate;

- (CLLocationCoordinate2D)coordinates:(id<FBGeodataDelegate>)delegate;

@end
