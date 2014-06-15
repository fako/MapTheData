//
//  FBDatabaseDelegate.h
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBDatabaseDelegate <NSObject>

- (void)willStartDatabaseFetch;
- (void)didFinishDatabaseFetch;
- (void)didFailToFetchModelsFromDatabase;
- (void)noModelsForFetchFromDatabase;
- (void)didSucceedToFetchModelsFromDatabase:(NSArray*)fetched;

@end
