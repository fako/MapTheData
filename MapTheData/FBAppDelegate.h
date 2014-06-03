//
//  FBAppDelegate.h
//  MapTheData
//
//  Created by Fako Berkers on 6/2/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FBAppDelegate : NSObject <UIApplicationDelegate>
{
    
}

//@private
//    NSManagedObjectContext *managedObjectContext;
//    NSManagedObjectModel *managedObjectModel;
//    NSPersistentStoreCoordinator *persistentStoreCoordinator;
//}


@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
