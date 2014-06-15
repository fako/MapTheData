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
#import "FBLocation.h"

@implementation FBLoadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [FBLocation loadFromServer:self]; // loads locations from server and informs this ViewController
}

- (void)ready
{
    [self performSegueWithIdentifier:@"ReadySegue" sender:self];
}

- (void)didFailToLoadModelsFromServer {
    [super didFailToLoadModelsFromServer];
    if([FBLocation locationsExistInDatabase]) {
        [self ready];
    } else {
        self.loadLabel.text = @"No connection :(";
    }
}

- (void)didSucceedToLoadModelsFromServer {
    [super didSucceedToLoadModelsFromServer];
    [self ready];
}

@end
