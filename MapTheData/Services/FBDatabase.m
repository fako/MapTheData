//
//  FBDatabase.m
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import "FBDatabase.h"
#import "FBModels.h"

@implementation FBDatabase

#pragma mark - Inits

+ (instancetype)sharedDatabase
{
    static FBDatabase *database;
    @synchronized(self) {
        if(!database) {
            database = [self new];
        }
    }
    return database;
}

#pragma mark - CoreData database actions

- (void)executeRequest:(NSFetchRequest*)request
{
    NSAssert(self.delegate, @"Delegate has not been set for FBDatabase");
    
    if([self.delegate respondsToSelector:@selector(willStartDatabaseFetch)]) {
        [self.delegate performSelector:@selector(willStartDatabaseFetch)];
    }
    
    NSError *error;
    NSArray *results = [[AppDelegate managedObjectContext] executeFetchRequest:request error:&error];
    
    // Error and no result handling
    if (results == nil)
    {
        if([self.delegate respondsToSelector:@selector(didFailToFetchModelsFromDatabase)]) {
            [self.delegate performSelector:@selector(didFailToFetchModelsFromDatabase)];
        }
    } else if (results.count == 0) {
        if([self.delegate respondsToSelector:@selector(noModelsForFetchFromDatabase)]) {
            [self.delegate performSelector:@selector(noModelsForFetchFromDatabase)];
        }
    }
    
    // Passing results to delegate
    if([self.delegate respondsToSelector:@selector(didSucceedToFetchModelsFromDatabase:)]) {
        [self.delegate didSucceedToFetchModelsFromDatabase:results];
    }
    if([self.delegate respondsToSelector:@selector(didFinishDatabaseFetch)]) {
        [self.delegate performSelector:@selector(didFinishDatabaseFetch)];
    }
}

#pragma mark - Convenience functions
- (BOOL)rowsDoExistInDatabaseForModel:(Class)model
{
    NSFetchRequest *request = [self allRequestForModel:model sortAttribute:nil];
    NSError *error;
    NSArray *results = [[AppDelegate managedObjectContext] executeFetchRequest:request error:&error];
    return results.count > 0;
}

#pragma mark - CoreData FetchRequest getters for models

- (NSFetchRequest*)fetchRequestForModel:(Class)model
{
    NSEntityDescription *description = [NSEntityDescription entityForName:[FBModels entityNameFromClass:model]
                                                   inManagedObjectContext:[AppDelegate managedObjectContext]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:description];
    
    return request;
}

- (NSFetchRequest*)searchRequestForModel:(Class)model
                    usingSearchAttribute:(NSString*)attribute
                           andSearchTerm:(NSString*)term
{
    NSFetchRequest *request = [self fetchRequestForModel:model];
    
    NSString* predicateString = [[NSString stringWithFormat:@"%@ CONTAINS[c] ", attribute] stringByAppendingString:@"%@"]; // @"name CONTAINS[c] %@"
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString, term];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:attribute ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    return request;
}

- (NSFetchRequest*)allRequestForModel:(Class)model sortAttribute:(NSString*)attribute
{
    NSFetchRequest *request = [self fetchRequestForModel:model];
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    [request setPredicate:predicate];
    
    if(attribute) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:attribute ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    
    return request;
}

@end
