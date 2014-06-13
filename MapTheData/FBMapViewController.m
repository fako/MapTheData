//
//  FBViewController.m
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//


#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

#import "FBMapViewController.h"
#import "FBLocation.h"
#import "FBTableViewCell.h"

static NSString *kCellIdentifier = @"Cell";

@implementation FBMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    //self.locManager.desiredAccuracy = kCLLocationAccuracyBest;
    //self.locManager.distanceFilter = 10.0;
    self.locationManager.purpose = @"So I can stalk you.";
    [self.locationManager startUpdatingLocation];
    
    //self.map.showsUserLocation = YES;
    //self.map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

-(void)viewDidAppear:(BOOL)animated {
    
    
    //self.map.showsUserLocation = YES;
    
    
    
    FBLocation *location = [self quickFetchLocation];
    
    if([location.lat doubleValue] == 0 && [location.lng doubleValue] == 0) {
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder geocodeAddressString:location.name completionHandler:^(NSArray *placemarks, NSError *error) {
            NSLog(@"Completion block");
            if(error) {
                NSLog(@"Oepsie");
            } else {
                NSLog(@"Success! :)");
                CLLocationCoordinate2D coordinate = ((CLPlacemark*)placemarks[0]).location.coordinate;
                NSLog(@"Lat: %f, Lng: %f", coordinate.latitude, coordinate.longitude);
            }
        }];
        
        
    }
    
    
    [self updateMapForLocation:location];
    
    
    
}

- (void)updateMapForLocation:(FBLocation*)location {
    
    NSLog(@"%@, %@, %@", location.name, location.lat, location.lng);
    
    CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake(location.lat.doubleValue, location.lng.doubleValue);
    //MKCoordinateSpan span = { 0.12, 0.12 };
    //MKCoordinateRegion region = { coordinates, span };
    CLLocationCoordinate2D userLocation = self.map.userLocation.location.coordinate;
    
    MKMapPoint locationPoint = MKMapPointForCoordinate(coordinates);
    MKMapPoint userPoint = MKMapPointForCoordinate(userLocation);
    MKMapRect locationRect = MKMapRectMake(locationPoint.x, locationPoint.y, 0, 0);
    MKMapRect userRect = MKMapRectMake(userPoint.x, userPoint.y, 0, 0);
    
    MKMapRect unitedRect = MKMapRectUnion(locationRect, userRect);
    //unitedRect = MKMapRectInset(unitedRect, 10.0, 10.0);
    
    //self.map.centerCoordinate = coordinates;
    //self.map.region =
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinates;
    annotation.title = location.name;
    
    [self.map addAnnotation:annotation];
    
    //MKCoordinateRegion viewRegion = MKCoordinateRegionForMapRect(unitedRect);
    
    //[self.map setRegion:viewRegion animated:NO];
    
    [self.map setVisibleMapRect:unitedRect
                    edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                       animated:NO];
}

- (FBLocation*)quickFetchLocation {
    
    NSManagedObjectContext *moc = [AppDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Location" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name like %@", @"Martenshoek"]; // valid = Eschmarke
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    if (array == nil)
    {
        NSLog(@"fail :(");
        // Deal with error...
    }
    return array[0];
    
}

- (void)userLocation {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSManagedObjectContext *moc = [AppDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Location" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name CONTAINS[c] %@", searchText];
    [request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    
    
    if (array == nil)
    {
        NSLog(@"fail :(");
        // Deal with error...
    }
    self.searchResults = array;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:@"FBTableViewCell" bundle:[NSBundle mainBundle]]
    forCellReuseIdentifier:@"Cell"
     ];
    //[tableView registerClass:[FBTableViewCell class] forCellReuseIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    FBLocation *location = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = location.name;
    
    return cell;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchDisplayController setActive:NO animated:YES];
    // TODO: perform request here to see if it is there
    NSLog(@"%@", searchBar.text);
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchDisplayController setActive:NO animated:YES];
    NSLog(@"%@", [self.searchResults[indexPath.row] name]);
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    NSLog(@"Getting user info now");
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    NSLog(@"Stopped user info now");
}
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    NSLog(@"I am delegate");
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"User location error");
}
- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    NSLog(@"Starting with user location: %hhd", mapView.userLocationVisible);
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"bingo!");
}

@end
