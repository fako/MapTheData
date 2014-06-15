//
//  FBModels.m
//  MapTheData
//
//  Created by Fako Berkers on 6/15/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//


#import "FBModels.h"

@implementation FBModels

#pragma mark - Manual NSDictionaries with necessary info

+ (NSDictionary*)mappingForModel:(Class)model
{
    static NSDictionary *mappings;
    if(!mappings) {
        mappings = @{
            @"Location": @{
                @"name": @"name",
                @"secondaryName": @"secondaryName",
                @"type": @"type",
                @"typeNumber": @"typeNumber",
                @"lat": @"lat",
                @"lng": @"lng"
            }
        };
    }
    
    return mappings[[FBModels entityNameFromClass:model]];
}
+ (NSArray*)identificationAttributesForModel:(Class)model
{
    static NSDictionary *idAttributes;
    if(!idAttributes) {
        idAttributes = @{
            @"Location": @[@"name"]
        };
    }
    return idAttributes[[FBModels entityNameFromClass:model]];
}

#pragma mark - Convenience methods

/**
 * Return entity name based on class
 *
 * Strips 'FB' from entity name and returns that
 */
+ (NSString*)entityNameFromClass:(Class)klass {
    return [NSStringFromClass(klass) substringFromIndex:2];
}

+ (NSString*)entityKeyPathFromModel:(Class)model
{
    return [FBModels entityKeyPathFromEntityName:[FBModels entityNameFromClass:model]];
}

+ (NSString*)pathFromModel:(Class)model
{
    return [FBModels pathFromEntityName:[FBModels entityNameFromClass:model]];
}

#pragma mark - Generator functions

+ (NSString*)entityKeyPathFromEntityName:(NSString*)name
{
    return [name.lowercaseString stringByAppendingString:@"s"];
}

+ (NSString*)pathFromEntityName:(NSString*)name
{
    return [[FBModels entityKeyPathFromEntityName:name] stringByAppendingString:@"/"];
}







@end
