//
//  FBDatabase.h
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "FBDatabaseDelegate.h"

@interface FBDatabase : NSObject

@property(nonatomic, strong) id<FBDatabaseDelegate> delegate;

+ (instancetype)sharedDatabase;

- (void)executeRequest:(NSFetchRequest*)request;
- (BOOL)rowsDoExistInDatabaseForModel:(Class)model;

- (NSFetchRequest*)fetchRequestForModel:(Class)model;
- (NSFetchRequest*)searchRequestForModel:(Class)model usingSearchAttribute:(NSString*)attribute andSearchTerm:(NSString*)term;

@end
