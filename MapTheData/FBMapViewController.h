//
//  FBViewController.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FBMapViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property(nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property(strong, nonatomic) CLLocationManager *locationManager;

@end
