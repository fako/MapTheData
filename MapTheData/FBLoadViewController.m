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
#import "FBServer.h"
#import "FBLocation.h"

@implementation FBLoadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *baseUrl = @"http://still-atoll-8938.herokuapp.com";
    NSString *basePath = @"/api/";
    
    [FBServer sharedServer].baseUrl = baseUrl; // TODO: move this to FBViewController or category?
    [FBServer sharedServer].basePath = basePath;
    [FBServer sharedServer].delegate = self;
    [[FBServer sharedServer] requestObjectsForModel:[FBLocation class]];
}

- (void)ready
{
    [self performSegueWithIdentifier:@"ReadySegue" sender:self];
}

- (void)didFailToLoadModels {
    [super didFailToLoadModels];
    // TODO: see if we have anything in db and continue if we do
}

- (void)didSucceedToLoadModels {
    [super didSucceedToLoadModels];
    [self ready];
}
@end
