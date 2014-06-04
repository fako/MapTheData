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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerNib:[UINib nibWithNibName:@"FBTableViewCell" bundle:[NSBundle mainBundle]]
    forCellReuseIdentifier:@"Cell"
     ];
    //[tableView registerClass:[FBTableViewCell class] forCellReuseIdentifier:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    //MKMapItem *mapItem = [self.places objectAtIndex:indexPath.row];
    cell.textLabel.text = @"test";//mapItem.name;
    
    return cell;
}

@end
