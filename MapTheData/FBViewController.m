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

//@dynamic searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    self.searchResults = array;
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSManagedObjectContext *moc = [AppDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Location" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    NSString *predicateText = nil;
    if(searchText.length > 3) {
        predicateText = [NSString stringWithFormat:@"%@", searchText];
    } else {
        predicateText = [NSString stringWithFormat:@"%@", searchText];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"name CONTAINS[c] %@", predicateText];
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

@end
