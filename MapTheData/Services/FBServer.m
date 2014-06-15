//
//  FBServer.m
//  MapTheData
//
//  Created by Fako Berkers on 6/13/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//
#import <RestKit/RestKit.h>

#import "FBServer.h"
#import "FBModels.h"


@implementation FBServer

#pragma mark - Init, setters and getters

+ (instancetype)sharedServer
{
    
    static FBServer *server;
    
    @synchronized(self) {
        
        if(!server) {
            server = [self new];
        }

    }
    
    return server;
}

- (void)setBaseUrl:(NSString *)baseUrl
{
    if(!_baseUrl || ![_baseUrl isEqualToString:baseUrl]) {
        
        [self setupRestKitForBaseUrl:baseUrl];
        
    } // TODO: else warning here?
}

- (NSString*)pathForModel:(Class)model withAppendix:(NSString*)appendix
{
    return [[self pathForModel:model] stringByAppendingString:appendix];
}

- (NSString*)pathForModel:(Class)model
{
    NSString *modelPath = [FBModels pathFromModel:model];
    return [NSString stringWithFormat:@"%@%@", self.basePath, modelPath];
}

#pragma mark - Server calls

- (void)requestObjectsForModel:(Class)model
{
    NSAssert(self.restKitObjectManager, @"RestKit doesn't seem to be setup.");
    
    if([self.delegate respondsToSelector:@selector(willStartRequest)]) {
        [self.delegate performSelector:@selector(willStartRequest)];
    }
    
    [self.restKitObjectManager addResponseDescriptor:[self responseDescriptorForModel:model]];
    [self.restKitObjectManager getObjectsAtPath:[self pathForModel:model]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if(self.delegate) {
                                                      if([self.delegate respondsToSelector:@selector(didSucceedToLoadModels)]) {
                                                          [self.delegate performSelector:@selector(didSucceedToLoadModels)];
                                                      }
                                                      if([self.delegate respondsToSelector:@selector(didFinishRequest)]) {
                                                          [self.delegate performSelector:@selector(didFinishRequest)];
                                                      }
                                                  }
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  if(self.delegate) {
                                                      if([self.delegate respondsToSelector:@selector(didFailToLoadModels)]) {
                                                          [self.delegate performSelector:@selector(didFailToLoadModels)];
                                                      }
                                                      if([self.delegate respondsToSelector:@selector(didFinishRequest)]) {
                                                          [self.delegate performSelector:@selector(didFinishRequest)];
                                                      }
                                                  }
                                              }];
}

#pragma mark - RestKit helpers

/**
 * We do some RestKit magic, a library for fetching JSON responses
 * More info: http://restkit.org
 */
- (void)setupRestKitForBaseUrl:(NSString*)baseUrl {
    
    // CoreData stuff
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:[AppDelegate persistentStoreCoordinator]];
    [managedObjectStore createManagedObjectContexts];
    
    // RestKit object manager
    self.restKitObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:baseUrl]];
    self.restKitObjectManager.managedObjectStore = managedObjectStore;
    
    [self.restKitObjectManager setRequestSerializationMIMEType:RKMIMETypeJSON]; // not the default :(
    
}

// TODO: comment about mappings
- (RKEntityMapping*)entityMappingForModel:(Class)model {
    
    NSAssert(self.restKitObjectManager, @"RestKit doesn't seem to be setup.");
    
    RKEntityMapping* mapping = [RKEntityMapping mappingForEntityForName:[FBModels entityNameFromClass:model]
                                                   inManagedObjectStore:self.restKitObjectManager.managedObjectStore
    ];
    [mapping addAttributeMappingsFromDictionary:[FBModels mappingForModel:model]];
    mapping.identificationAttributes = [FBModels identificationAttributesForModel:model];
    
    return mapping;
}

- (RKResponseDescriptor*)responseDescriptorForModel:(Class)model
{
    NSAssert(self.restKitObjectManager, @"RestKit doesn't seem to be setup.");
    
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self entityMappingForModel:model]
                                                                                    method:RKRequestMethodAny
                                                                               pathPattern:nil
                                                                                   keyPath:[FBModels entityKeyPathFromModel:model]
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
    ];
    return descriptor;
}



@end
