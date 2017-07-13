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
#import <AddressBook/AddressBook.h>
#import <EventKit/EventKit.h>

@interface TabTwoVC ()

@end

@implementation TabTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //Fetch Data to Store into VC Label
    [self fetchDataFromCoreData];
    
    //Read Image from File to load into UI View
    [self setupPreviewSculptImage];
    
    //Init edges
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Init edge behavours
    self.extendedLayoutIncludesOpaqueBars = NO;
    
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

-(bool)fetchDataFromCoreData{
    
    //Init Test Flag
    int testFlag = 1;
    
    //Flag Util for Err Checking
    if(testFlag == 1){
    
    //1. Get a refernecne to the app delegate
    AppDelegate *appD = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    //2. Create a local reference to the context
    NSManagedObjectContext *context = [appD.persistentContainer viewContext];
    
    //3. Create fetch request the Contact entity
    NSFetchRequest *fetch = [SculptObject fetchRequest];

    //4. Fetch the items
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetch error:&error];

    //5a. Set the message if no items are found
    if ([objects count] ==0) {
        self.sculptMovesLabelView.text = @"No matches found";
    } else {
        
        //5b. Create a mutable string with the details of the contacts found
        NSMutableString *string = [NSMutableString string];
        
        for (SculptObject *foundObject in objects) {
            [string appendFormat:@"SculptMoves: %f", foundObject.sculptMoves];
        }//End of For Loop
        
        //6. Assign value to the text
        self.sculptMovesLabelView.text = string;
    }//End of If Loop
        
        //Return True if Successful
        return true;
        
    }//End of If Block
    else {
        
        //Return False if program end
        return false;
    }//End of Else Block
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma  - mark flipImageAction

/**
 Method: flipImageAction
 
 Description
 - Flips image
 - Implements new iOS 9 UIImage method
 - This is to view the image from a nmirrored angle for creative assessment of artistic merit.


 @param sender description
 */
- (IBAction)flipImageAction:(id)sender {
    
    //Flips Image
   UIImage *img = [_sculptUIImage imageFlippedForRightToLeftLayoutDirection];
    
    //Set Image to ImageView
    [_sculptImageView setImage:img];
    
}


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
#pragma - mark launchWithActivities

-(bool)launchWithActivities:(nullable NSArray *) activities {
    
    //Init Test Flag
    int testFlag = 1;
    
    //Flag Util for Err Checking
    if(testFlag == 1){
    
    //Create String to be Posted in Email
    NSString *postText = @"I've just created a Sculpt!";
    
    //Init NSArray to Send into initWithActivityItems
    NSArray *activityItems = @[postText, _sculptUIImage];
    
    //Init activity View Controller with activities & NSArray
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems: activityItems applicationActivities:activities];
    
    //Set the Activitiy View Controller
    [self presentViewController:actVC animated:YES completion:nil];
        
        //Return True if Successful
        return true;
        
    }//End of If Block
    else {
        
        //Return False if program end
        return false;
    }//End of Else Block
    
}

/**
 Method - scheduleSculptTimeAction
 
 Description:
 - Schedules an EventKit to Load a Time to Sculpt

 @param sender  User Clicked Scedule Button
 */
#pragma  - mark scheduleSculptTimeAction

- (IBAction)scheduleSculptTimeAction:(id)sender {
    
    //Init EventStore Item
    EKEventStore *store = [EKEventStore new];
    
    //Request Access To Entity
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        //Error Checking
        if (!granted) {
            
            //Error Log
            NSLog(@"Permission not granted by user to set EventKit to Calender");
            
            //Default Return
            return;
        
        }
        
        //Init EKEvent Item
        EKEvent *event = [EKEvent eventWithEventStore:store];
        
        //Set Title
        event.title = @"Event Title";
        //Set StartDate
        event.startDate = [NSDate date]; //today
        //Set EndDate
        event.endDate = [event.startDate dateByAddingTimeInterval:60*60];  //set 1 hour meeting
        //Set Calender
        event.calendar = [store defaultCalendarForNewEvents];
        
        //Error Checking
        NSError *err = nil;
        
        //Save Event into the EventStore
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        
    }];//End of Block
    
}


#pragma -mark addressBookEmailCheckAction
/**
 Method:
 -
 Description:
- Gets Emails from Addressbook
 - Sets the emails to the view label
 
 @param sender sender description
 */
- (IBAction)addressBookEmailCheckAction:(id)sender {
    
    //Fetch & Set Emails from AddressBook
    [self addressBookFetcher];
    
    
}

-(UIImage*)readDataFromFileDemoDay{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DummyScreenshot" ofType:@"png"];
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    
    return image;

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
    
    //UIImage  *img = [self readDataFromFile];
    
    //FOR PRESENTATION DEMO AS METHOD HAS BUG THAT REMAINS (13.07.17)
   UIImage  *img = [self readDataFromFileDemoDay];
    
    _sculptUIImage = img;

    [_sculptImageView setImage:_sculptUIImage];

}



# pragma - mark addressBookFetcher
/**
 Method: addressBookFetcher
 
 Description
 - Gets Contacts from AddressBook
 - Gets Email addresses
 */
- (void)addressBookFetcher {
    //Error Check for Privaledge
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied || ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){

        //Init AlertView
        UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot get contacts" message: @"You must give the app permission to read the contacts first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        //Present AlertView
        [cantAddContactAlert show];
    
        //Check for Privalege
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        //Get Emails
        [self getEmails];
    } else {

        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    //4
                    UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot get contacts" message: @"You must give the app permission to read the contacts first." delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
                    [cantAddContactAlert show];
                    return;
                }

                [self getEmails];
                
            });
        });
    }
}



#pragma -mark getEmails
/**
 Method: getEmails
 Description:
 - Helper Method
 - Gets all the emails from the addressBook

 @return emails Emails from AddressBook
 */
-(NSArray *)getEmails
{
    NSMutableArray *emails = [NSMutableArray array];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    for (id record in allContacts)
    {
        ABRecordRef person = (__bridge ABRecordRef)record;
        ABMultiValueRef emailProperty = ABRecordCopyValue(person, kABPersonEmailProperty) ;
        NSArray *personEmails = (__bridge_transfer NSArray *)ABMultiValueCopyArrayOfAllValues(emailProperty);
        [emails addObjectsFromArray:personEmails];
        CFRelease(person);
        CFRelease(emailProperty);
    }
    CFRelease(addressBookRef) ;
    for (NSString *email in emails)
    {
        _emailView.text = email;
    }
    
    return emails;
}

@end
