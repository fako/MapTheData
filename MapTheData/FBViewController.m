//
//  FBViewController.m
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import "FBViewController.h"

@interface FBViewController ()
@end

@implementation FBViewController

#pragma mark - Helpers

// TODO: implement Activity Indicator here

#pragma mark - Server delegate methods

- (void)willStartLoadFromServer
{
    NSLog(@"Starting request");
}

- (void)didFinishLoadFromServer
{
    NSLog(@"Finished request");
}

- (void)didFailToLoadModelsFromServer
{
    NSLog(@"Model retrieval failed");
}

- (void)didSucceedToLoadModelsFromServer
{
    NSLog(@"Model retrieval succeeded");
}

#pragma mark - Database delegate methods

- (void)willStartDatabaseFetch {
    NSLog(@"Starting query");
}

- (void)didFinishDatabaseFetch {
    NSLog(@"Finished query");
}

- (void)didFailToFetchModelsFromDatabase {
    NSLog(@"Model query failed");
}

- (void)noModelsForFetchFromDatabase {
    NSLog(@"No results returned by query");
}

- (void)didSucceedToFetchModelsFromDatabase:(NSArray*)fetched {
    NSLog(@"Model query succeeded");
}

@end
