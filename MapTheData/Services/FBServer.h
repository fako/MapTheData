//
//  FBServer.h
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FBServerDelegate.h"

@class FBServerDelegate;
@class FBLocation;


@interface FBServer : NSObject

@property(nonatomic, strong) NSString *baseUrl;
@property(nonatomic, strong) NSString *basePath;
@property(nonatomic, strong) RKObjectManager *restKitObjectManager;
@property(nonatomic, strong) id<FBServerDelegate> delegate;

+ (instancetype)sharedServer;
- (void)requestObjectsForModel:(Class)model;

- (RKEntityMapping*)entityMappingForModel:(Class)model;
- (RKResponseDescriptor*)responseDescriptorForModel:(Class)model;

@end
