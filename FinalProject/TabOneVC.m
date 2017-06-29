//
//  TabOneVC.m
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "TabOneVC.h"
#import "AppDelegate.h"
#import "SculptObject+CoreDataClass.h"

@interface TabOneVC ()

@end

@implementation TabOneVC

# pragma mark - viewDidLoad
/**
 Method:viewDidLoad
 
 Description
 - Load the glkView
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Set viewDidLoad of glkView
    [_glkView viewDidLoad];
    
    //Fetch, Parse, Store, Retrieve & Set OpenGLVersion
    [self setupWebServiceWikipediaOpenGLVersion];
}


# pragma mark - didReceiveMemoryWarning

/**
 Method:didReceiveMemoryWarning
 
 Description
 - 
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma - mark fetchDataFromSite
/**
 Method: fetchDataFromSite
 
 Description
 - Helper Method
 - Fetches Data from a Website
 - Returns data
 
 @param websiteName Site to Fetch
 @return return value DataFeteched
 */
-(void)fetchDataFromSite:(NSString*) websiteName {
    
    //Init NSURL Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    //Init URL
    NSURL *url = [NSURL URLWithString:websiteName];
    
    //Error Checking
    id completionBlock = ^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
            //Return Log
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        NSError *jsonError = nil;
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Parsing Error: %@", jsonError.localizedDescription);
        }
        else {
            
            //Parse Data
            [self parseFetchedDataOpenGL:dictionary];
            
        }//End of Else Blcok
        
    };//End of Block
    
    //Init Data Task
    NSURLSessionTask *dataTask = [session dataTaskWithURL:url completionHandler:completionBlock];
    
    //Start dataTask
    [dataTask resume];
    
}

#pragma  - mark setupWebServiceWikipediaOpenGLVersion
/**
 
 Description
 - Fetch, Parse, & Set OpenGL Version Number from Wikipedia
 - Store, & Fetch OpenGLVersion from CoreData
 - Assign Label Values
 */
-(void)setupWebServiceWikipediaOpenGLVersion{
    
    //TODO: Make Asynchronous Call
    
    //Init URL with OpenGL using mediaWiki API
    NSString *urlWikiOpenGL = @"https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=jsonfm&titles=OpenGL&rvsection=0";
    
    //Init DataTask by Fetching Data
    [self fetchDataFromSite:urlWikiOpenGL];
    
   
    
    //Store Data into CoreData
    [self saveDataToCoreData];
    
    //Fetch Data from CoreData
    [self fetchDataFromCoreData];
    
}

/**
 Method: fetchDataFromCoreData
 
 Description
 - Fetch Data from CoreData file
 - Retrive OpenGL Version Number
 - Assignment of OpenGL Version Number to the field value of openGLVersionLabel
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"OpenGLVersion"];
    
    //5. Set the predicate the search
    [fetch setPredicate:predicate];
    
    //6. Fetch the items
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetch error:&error];
    
    //7a. Set the message if no items are found
    if ([objects count] ==0) {
        _openGLVersionLabel.text = @"OpenGL Version: 4.1";
    } else {
        
        //7b. Create a mutable string with the details of the contacts found
        NSMutableString *string = [NSMutableString string];
        
        for (SculptObject *foundObject in objects) {
            [string appendFormat:@"OpenGLVersion: %f", foundObject.openGLVersion];
        }//End of For Loop
        
        //8. Assign value to the text
        _openGLVersionLabel.text = string;
    }//End of If Loop
}

# pragma mark - saveDataToCoreData
/**
 Method: saveDataToCoreData
 
 Description:
 - Save OpenGLVersion to the CoreData
 
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
    //[newSculptObject setSculptMoves:_openGLVersionNumber];
}


#pragma  - mark parseFetchedDataOpenGL
/** TODO
 Method:parseFetchedDataOpenGL
 
 
 Description
 - Helper Method
 - Parse Data Task
 - Perform JSON Dictionary Key Value Searching
 - Perform String Parsing
 - Identitfy OpenGL Version
 
 - Help:  https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=jsonfm&titles=OpenGL&rvsection=0
 
 @param dict FetchedData
 @return  OpenGL Version
 */
-(float)parseFetchedDataOpenGL:(NSDictionary*) dict{
    
    //Init & Set ParseArrayNo_1
    NSMutableArray *parseArrayNo_1 = [dict valueForKey:@"query.pages.22497.revisions"];

    //Int & Set  Dict
    NSDictionary *tempDict = parseArrayNo_1[0];
    
    //Init & Set Another Array
    NSString *string = [tempDict valueForKey:@"*"];
    
    //Init Another Parse Array
    NSArray *parseArrayNo_2 = [string componentsSeparatedByString:@"\n"];
    
    //Init NSString
    NSString *matchedString = [[NSString alloc] init];
    
    //Init Searched String
    NSString *searchString = @"latest release version";
    
    //Search Array for String Match
    for (int i = 0; i < parseArrayNo_2.count; i++) {
        
        //Check if String Matches Intended String
        if(parseArrayNo_2[i] == searchString) {
            
            //Assign Value to MatchString
            matchedString =  parseArrayNo_2[i];
            
        }//End of If Loop
    }//End of For Loop

    //Parse Number from the String
    float number = [self numberFromString:matchedString];
    
    //Assign Number to Field
    _openGLVersionNumber = number;
    
    //Return the number
    return number;

}



/**
 Method:numberFromString
 
 Description:
 - Helper Method
 - Parses string to find a number
 
 @param passedString <#passedString description#>
 @return <#return value description#>
 */
-(float)numberFromString: (NSString*) passedString{
    
    //Init NSString
    NSString *numberString;
    
    //Init Scanner
    NSScanner *scanner = [NSScanner scannerWithString:passedString];
    
    //Init CharacterSet
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Throw away characters before the first number.
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    
    // Collect numbers.
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    
    // Get Result
    float number = [numberString floatValue];
    
    //Return Number
    return number;
}

@end
