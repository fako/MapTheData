//
//  FBLocation.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 Fako Berkers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBLocation : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* secondaryName;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* typeNumber;
@property (nonatomic, copy) NSNumber* lat;
@property (nonatomic, copy) NSNumber* lng;


@end
