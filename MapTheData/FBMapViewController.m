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
#import "FBTableViewCell.h"

#import "FBLocation.h"
#import "FBUser.h"

static NSString *kCellIdentifier = @"Cell";
static const NSUInteger MAP_PADDING = 60;


@implementation FBMapViewController

@synthesize viewLocation;
@dynamic viewMapRect;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [FBUser sharedUser].delegate = self; // redirects new permissions to this ViewController
    [self updateMap:animated];
}

#pragma mark - MapRect getters and helpers

- (MKMapRect)mapRectFromCoordinates:(CLLocationCoordinate2D)coordinates
{
    MKMapPoint point = MKMapPointForCoordinate(coordinates);
    return MKMapRectMake(point.x, point.y, 0, 0);
}

- (MKMapRect)viewMapRect
{
    MKMapRect rect = MKMapRectNull;
    
    if([FBUser sharedUser].isSharingLocation && self.viewLocation) {
        
        MKMapRect userRect = [self mapRectFromCoordinates:[FBUser sharedUser].coordinates];
        MKMapRect locationRect = [self mapRectFromCoordinates:[self.viewLocation coordinates:self]];
        return MKMapRectUnion(userRect, locationRect);
        
    } else if (self.viewLocation) {
        
        return [self mapRectFromCoordinates:[self.viewLocation coordinates:self]];
        
    } else if ([FBUser sharedUser].isSharingLocation) {
        
        return [self mapRectFromCoordinates:[FBUser sharedUser].coordinates];
        
    }
    return rect; // a sain default here would be nice :)
    
}

#pragma mark - MapView helpers

- (void)updateAnnotationsUsingLocation:(FBLocation*)location {
    
    if(self.viewAnnotation) {
        [self.map removeAnnotation:self.viewAnnotation];
    }
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = [location coordinates:self];
    annotation.title = location.name;
    
    [self.map addAnnotation:annotation];
    self.viewAnnotation = annotation;
    
}

- (void)updateMapForLocation:(FBLocation*)location animated:(BOOL)animated
{
    [self updateAnnotationsUsingLocation:location];
    self.viewLocation = location; // viewMapRect will now be adjusted to include this location
    [self updateMap:animated];
}

- (void)updateMap:(BOOL)animated {
    
    [self.map setVisibleMapRect:self.viewMapRect // the getter merges annotation and user location or shows either one
                    edgePadding:UIEdgeInsetsMake(MAP_PADDING, MAP_PADDING, MAP_PADDING, MAP_PADDING)
                       animated:animated];
}



#pragma mark - Search bar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [FBLocation searchFor:searchText delegate:self];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchDisplayController setActive:NO animated:YES];
    [self updateMapForLocation:self.searchResults[0] animated:YES];
}

#pragma mark - Search table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"FBTableViewCell" bundle:[NSBundle mainBundle]];
    [tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    FBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    FBLocation *location = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = location.name;
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchDisplayController setActive:NO animated:NO];
    [self updateMapForLocation:self.searchResults[indexPath.row] animated:YES];
}

#pragma mark - FBDatabase delegate methods

- (void)didSucceedToFetchModelsFromDatabase:(NSArray *)fetched
{
    self.searchResults = fetched;
}

#pragma mark - FBGeodata delegate methods

- (void)willStartGeoLookup
{
    NSLog(@"Starting lookup");
}

- (void)didFinishGeoLookup:(CLLocationCoordinate2D)coordinates
{
    NSLog(@"Finished lookup");
    self.viewLocation.lat = [NSNumber numberWithDouble:coordinates.latitude];
    self.viewLocation.lng = [NSNumber numberWithDouble:coordinates.longitude];
    
    NSError *error = nil;
    [[AppDelegate managedObjectContext] save:&error];
    if(error) {
        NSLog(@"Silent fail for geocoder address save");
    }
    
    [self updateMapForLocation:self.viewLocation animated:YES];
}

- (void)didFailGeoLookup
{
    NSLog(@"Silent fail for geocoder address lookup");
}

- (void)didReceivePermissionForUserLocation
{
    NSLog(@"Did receive user location permission");
    [self updateMap:YES];
}

@end
