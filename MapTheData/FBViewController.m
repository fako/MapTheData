//
//  FBViewController.m
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//


#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>

#import "FBViewController.h"
#import "FBLocation.h"
#import "FBTableViewCell.h"

static NSString *kCellIdentifier = @"Cell";

@implementation FBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBLocation *location = [self quickFetchLocation];
    
    NSLog(@"%@", location.name);
    
    
}

- (FBLocation*)quickFetchLocation {
    
    NSManagedObjectContext *moc = [AppDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Location" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name like %@", @"G*"];
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

@end
