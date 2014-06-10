//
//  FBViewController.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FBViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource>

@property(nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end
