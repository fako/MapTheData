//
//  FBViewController.h
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FBServerDelegate.h"
#import "FBDatabaseDelegate.h"

@interface FBViewController : UIViewController <FBServerDelegate, FBDatabaseDelegate>

@end
