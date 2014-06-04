//
//  FBLoadViewController.m
//  MapTheData
//
//  Created by Fako Berkers on 6/3/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

#import "FBLoadViewController.h"

@implementation FBLoadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSString *baseUrl = @"http://still-atoll-8938.herokuapp.com";
    
    RKObjectManager *restKitObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseUrl]];
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:[AppDelegate persistentStoreCoordinator]];
    
    [managedObjectStore createManagedObjectContexts];
    
    restKitObjectManager.managedObjectStore = managedObjectStore;
    
    
    RKEntityMapping* locationMapping = [RKEntityMapping mappingForEntityForName:@"Location" inManagedObjectStore:managedObjectStore];
    [locationMapping addAttributeMappingsFromDictionary:@{
                                                          @"name": @"name",
                                                          @"secondaryName": @"secondaryName",
                                                          @"type": @"type",
                                                          @"typeNumber": @"typeNumber",
                                                          @"lat": @"lat",
                                                          @"lng": @"lng"
                                                          }];
    locationMapping.identificationAttributes = @[@"name"];
    
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:locationMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"locations"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                                ];
    
    
    
    
    
    
    
    [restKitObjectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [restKitObjectManager addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/locations/stations"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSLog(@"Succes! :)");
                                                  [self performSegueWithIdentifier:@"ReadySegue" sender:self];
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"Fail :(");
                                              }];
    
}


@end
