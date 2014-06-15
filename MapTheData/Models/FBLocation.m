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

#pragma mark - Database logic

+ (BOOL)locationsExistInDatabase:(id<FBDatabaseDelegate>)delegate
{
    FBDatabase *database = [FBDatabase sharedDatabase];
    database.delegate = delegate;
    return [database rowsDoExistInDatabaseForModel:[self class]];
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


