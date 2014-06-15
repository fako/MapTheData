//
//  FBTableViewCell.h
//  MapTheData
//
//  Created by Fako Berkers on 6/4/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBLocation;

@interface FBTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) FBLocation *location;


@end
