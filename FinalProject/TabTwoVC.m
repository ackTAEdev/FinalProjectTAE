//
//  TabTwoVC.m
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "TabTwoVC.h"
#import "AppDelegate.h"
#import "SculptObject+CoreDataClass.h"


@interface TabTwoVC ()

@end

@implementation TabTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //Fetch Data to Store into VC Label
    [self fetchDataFromCoreData];
    
    //Read Image from File to load into UI View
    [self setupPreviewSculptImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 Method: fetchDataFromCoreData
 
 Description
 - Fetch Data from CoreData file
 - Retrive sculpted stroke count
 - Assignment of count to the field value of sculptMovesLabelView
 */
#pragma  - mark fetchDataFromCoreData

-(void)fetchDataFromCoreData{
    
    //1. Get a refernecne to the app delegate
    AppDelegate *appD = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    //2. Create a local reference to the context
    NSManagedObjectContext *context = [appD.persistentContainer viewContext];
    
    //3. Create fetch request the Contact entity
    NSFetchRequest *fetch = [SculptObject fetchRequest];

    //4. Create a predicate for the search
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sculptMoves"];
    
    //5. Set the predicate the search
    [fetch setPredicate:predicate];
    
    //6. Fetch the items
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetch error:&error];

    //7a. Set the message if no items are found
    if ([objects count] ==0) {
        self.sculptMovesLabelView.text = @"No matches found";
    } else {
        
        //7b. Create a mutable string with the details of the contacts found
        NSMutableString *string = [NSMutableString string];
        
        for (SculptObject *foundObject in objects) {
            [string appendFormat:@"SculptMoves: %f", foundObject.sculptMoves];
        }//End of For Loop
        
        //8. Assign value to the text
        self.sculptMovesLabelView.text = string;
    }//End of If Loop
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



/**
 Method: shareFacebookAction
 
 Description
 - Post Sculpted Image to Facebook

 @param sender
 */
#pragma  - mark shareFacebookAction

- (IBAction)shareFacebookAction:(id)sender {

    //Check if Facebook is ready to post information
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        //Device is able to send a Facebook Message

        //Init Facebook Message Controller
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //Init Image to be Posted
        UIImage *postImage = _sculptUIImage;
        
        //Init Text to be Posted
        NSString *postText = @"Check out my new Sculpt!";

        //Set Text
        [composeController setInitialText:postText];
        
        //Set Image
        [composeController addImage:postImage];
        
        //Assign composeController to presentVC
        [self presentViewController:composeController animated:YES completion:nil];
        
        
    }

}


/**
 Method - shareEmailAction
 
 Description:
 - Sends Sculpted image into an Email

 @param sender  User Clicked Email Button
 */
#pragma  - mark shareEmailAction

- (IBAction)shareEmailAction:(id)sender {
    
    //Call  Helper Method specifiying Mail Activity
    [self launchWithActivities:@[UIActivityTypeMail]];
}



/**
 Description
 - Helper method to init activity view controller
 - Setups email to accept an NSArray
 - NSArray contains sculpted image and a message.

 @param activities activities Mail Actvity
 */
#pragma  - mark launchWithActivities

-(void)launchWithActivities:(nullable NSArray *) activities {
    
    //Create String to be Posted in Email
    NSString *postText = @"I've just created a Sculpt!";
    
    //Init NSArray to Send into initWithActivityItems
    NSArray *activityItems = @[postText, _sculptUIImage];
    
    //Init activity View Controller with activities & NSArray
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems: activityItems applicationActivities:activities];
    
    //Set the Activitiy View Controller
    [self presentViewController:actVC animated:YES completion:nil];
    
}

/**
 Method - scheduleSculptTimeAction
 
 Description:
 - Schedules an EventKit to Load a Time to Sculpt

 @param sender  User Clicked Scedule Button
 */
#pragma  - mark scheduleSculptTimeAction

- (IBAction)scheduleSculptTimeAction:(id)sender {
    
    
}


#pragma  - mark readDataFromFile

/**
 Method: readDataFromFile
 
 Description
 - Reads from Directory to find an Image
 - Returns a sculpted image

 @return return UIImage of Sculpt
 */
-(UIImage*)readDataFromFile{
    
    //Get the File Location & File Name
    
    //Init destination
    NSString *destination = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ImageDirectory"];
    
    //Init image file path
    NSString *imageFileName = @"sculptImage.png";
    
    //Init Handle on File
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:[destination stringByAppendingPathComponent:imageFileName]];
    
    //Read the Data
    NSData *fileData = [fileHandle readDataToEndOfFile];
    
    //Convert data into UIImage
    UIImage *imageLoaded = [[UIImage alloc] initWithData:fileData];
    
    return imageLoaded;
}


#pragma  - mark setupPreviewSculptImage
/**
 Method: setupPreviewSculptImage
 
 Description
 - Sets the UIImage to the Sculpted Image
 - Calls a helper method that reads the image from a file
 */

-(void)setupPreviewSculptImage{
    
 _sculptUIImage = [self readDataFromFile];
    
}


@end
