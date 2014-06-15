//
//  FBServerDelegate.h
//  MapTheData
//
//  Created by Fako Berkers on 6/14/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FBServerDelegate <NSObject>

- (void)willStartLoadFromServer;
- (void)didFinishLoadFromServer;
- (void)didFailToLoadModelsFromServer;
- (void)didSucceedToLoadModelsFromServer;

@end
