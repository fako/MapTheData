//
//  FBModels.h
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//
//  A little ackward service. I couldn't get CoreData and RestKit to behave without somekind of metadata outside of the Entity classes :(


#import <Foundation/Foundation.h>

@interface FBModels : NSObject

+ (NSString*)entityNameFromClass:(Class)klass;

+ (NSDictionary*)mappingForModel:(Class)model;
+ (NSArray*)identificationAttributesForModel:(Class)model;

+ (NSString*)entityKeyPathFromModel:(Class)model;
+ (NSString*)pathFromModel:(Class)model;

+ (NSString*)entityKeyPathFromEntityName:(NSString*)name;
+ (NSString*)pathFromEntityName:(NSString*)name;


@end
