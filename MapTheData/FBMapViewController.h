//
//  FBViewController.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "FBViewController.h"
#import "FBGeodataDelegate.h"

@class FBLocation;

@interface FBMapViewController : FBViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, FBGeodataDelegate>

@property(nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (nonatomic, strong) FBLocation *viewLocation;
@property (nonatomic, assign) MKMapRect viewMapRect;
@property (nonatomic, strong) MKPointAnnotation *viewAnnotation;


@end
