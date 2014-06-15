//
//  FBLocation.m
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import "FBLocation.h"

#import "FBDatabase.h"
#import "FBServer.h"
#import "FBGeodata.h"
#import "FBGeodataDelegate.h"


@implementation FBLocation

@dynamic name;
@dynamic secondaryName;
@dynamic type;
@dynamic typeNumber;
@dynamic lat;
@dynamic lng;

#pragma mark - Server logic

+ (void)loadFromServer:(id<FBServerDelegate>)delegate
{
    FBServer *server = [FBServer sharedServer];
    
    NSString *baseUrl = @"http://still-atoll-8938.herokuapp.com";
    NSString *basePath = @"/api/";
    
    server.baseUrl = baseUrl;
    server.basePath = basePath;
    server.delegate = delegate;
    
    [server requestObjectsForModel:[self class]];
}

#pragma mark - Getters and setters

- (CLLocationCoordinate2D)coordinates:(id<FBGeodataDelegate>)delegate {
    if(!(self.lat.doubleValue == 0 && self.lng.doubleValue == 0)) {
        return CLLocationCoordinate2DMake(self.lat.doubleValue, self.lng.doubleValue);
    } else {
        FBGeodata *geodata = [FBGeodata sharedGeodata];
        geodata.delegate = delegate;
        [geodata coordinatesFromAddressString:self.name];
        return CLLocationCoordinate2DMake(0.0, 0.0); // needs some sane defaults here
    }
}

#pragma mark - Database logic

+ (BOOL)locationsExistInDatabase
{
    return [[FBDatabase sharedDatabase] rowsDoExistInDatabaseForModel:[self class]];
}

+ (void)searchFor:(NSString*)term delegate:(id<FBDatabaseDelegate>)delegate
{
    FBDatabase *database = [FBDatabase sharedDatabase];
    database.delegate = delegate;
    NSFetchRequest* request = [[FBDatabase sharedDatabase] searchRequestForModel:[self class]
                                                            usingSearchAttribute:@"name"
                                                                   andSearchTerm:term];
    [database executeRequest:request];
}

@end


