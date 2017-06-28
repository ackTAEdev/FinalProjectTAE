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
    
    //Screenshot and save image into a file
    [self screenShotAndSaveSculptImage];
    
}


# pragma mark - sculptMoveCounter
/** TODO
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


#pragma  - mark takeScreenShotofSculpt

/** TODO
 Method: takeScreenShotofSculpt
 
 Description
 - Takes a ScreenShot of the Sculpt in the Window
 */

- (UIImage*)takeScreenShotofSculpt {
    
    //Init UIImage
    UIImage *screenShotSculpt = [[UIImage alloc] initWithData:<#(nonnull NSData *)#> ];
    
    //Return UIIMage
    return screenShotSculpt;
    
}


#pragma  - mark createDirectoryAndFile
/**
 Method: createDirectoryAndFile
 
 Description
 - Helper Method
 - Creates and initiliazes a directory and File
 */
-(void)createDirectoryAndFile {
    //Init fileManager
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    //Init destination
    NSString *destination = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ImageDirectory"];
    
    //Init error
    NSError *error;
    
    //Create Directory with error checking
    [fileManager createDirectoryAtPath:destination withIntermediateDirectories:YES attributes:nil error:&error];
    
    //Error Checking Block
    if(!error) {
        
        //Create image file path
        NSString *imageFilePath = [destination stringByAppendingPathComponent:@"sculptImage.png"];
        
        //Create Image File
        [fileManager createFileAtPath:imageFilePath contents:nil attributes:nil];
        
        //Get the sculpted image
        UIImage *imageSculpt = [self takeScreenShotofSculpt];
        
        //Convert UIImage object into NSData formatted according to PNG spec
        NSData *imageData = UIImagePNGRepresentation(imageSculpt);
        
        //Write Image to the File
        [imageData writeToFile:imageFilePath atomically:YES];
        
        
    } else {
        //Print Error message if Directory failed
        NSLog(@"Error: %@", [error localizedDescription]);
    }//End of Else Loop
    
}


#pragma  - mark screenShotAndSaveSculptImage

/**
 Method: screenShotAndSaveSculptImages
 
 Description
 - Helper Method
 - Takes screenshot of sculpt
 - Saves screenshot into file
 
 */
-(void)screenShotAndSaveSculptImage{
    //Screen of sculpt
    [self takeScreenShotofSculpt];
    //Saves sculpt image into a file
    [self createDirectoryAndFile];
}


@end
