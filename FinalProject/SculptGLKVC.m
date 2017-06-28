//
//  SculptGLKVC.m
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "SculptGLKVC.h"
#import "AppDelegate.h"
#import "SculptObject+CoreDataClass.h"

@implementation SculptGLKVC


# pragma mark - viewDidDisappear
/**
 Method: viewWillDisappear
 
 Description:
 - Save data before closing the ViewController

 */
-(void)viewWillDisappear:(BOOL)animated{
    
    //Save Data to CoreData
    [self saveDataToCoreData];
}


# pragma mark - sculptMoveCounter
/**
 Method: sculptMoveCounter
 
 Description:
 - Count number of sculpts user applies to the View
 */
-(void)sculptMoveCounter{
    
    // Assign Float Count to the Local Field
    //_sculptMovesCount  =
}


# pragma mark - saveDataToCoreData
/**
 Method: saveDataToCoreData
 
 Description:
 - Save sculptMoveCount to the CoreData
 
 */
-(void)saveDataToCoreData{
    
    //TODO Tasks to Store Data into CoreData
    //1. Get a reference the app delegate
    AppDelegate *appD = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    //2. Create a local reference to the context
    NSManagedObjectContext *context = [appD.persistentContainer viewContext];
    
    //3. Create an object in the content
    SculptObject *newSculptObject = [[SculptObject alloc] initWithContext:context];
    
    //4. Set the values
    [newSculptObject setSculptMoves:_sculptMovesCount];
}


@end
