//
//  FBViewController.m
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "FBViewController.h"
#import <RestKit/RestKit.h>

#import "FBLocation.h"

@interface FBViewController ()

@end

@implementation FBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    RKObjectMapping* locationMapping = [RKObjectMapping mappingForClass:[FBLocation class]];
    [locationMapping addAttributeMappingsFromDictionary:@{
                                                          @"name": @"name",
                                                          @"secondaryName": @"secondaryName",
                                                          @"type": @"type",
                                                          @"typeNumber": @"typeNumber",
                                                          @"lat": @"lat",
                                                          @"lng": @"lng"
                                                         }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:locationMapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:@"locations"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
                                                ];

    
    NSString *baseUrl = @"http://still-atoll-8938.herokuapp.com";
    
    RKObjectManager *restKitObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseUrl]];
    [restKitObjectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [restKitObjectManager addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/locations/stations"
                                           parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                NSLog(@"Succes! :)");
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                NSLog(@"Fail :(");
                                            }];
    
}

@end
