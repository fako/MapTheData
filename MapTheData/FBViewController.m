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

// TODO: implement Activity Indicator here

- (void)willStartRequest
{
    NSLog(@"Starting request");
}

- (void)didFinishRequest
{
    NSLog(@"Finished request");
}

- (void)didFailToLoadModels
{
    NSLog(@"Model retrieval failed");
}

- (void)didSucceedToLoadModels
{
    NSLog(@"Model retrieval succeeded");
}

@end
