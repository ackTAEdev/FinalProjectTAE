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


#pragma  - mark setupWebServiceWikipediaOpenGLVersion
/**
 
 Description
 - Fetch, Parse, & Set OpenGL Version Number from Wikipedia
 - Store, & Fetch OpenGLVersion from CoreData
 - Assign Label Values
 */
-(void)setupWebServiceWikipediaOpenGLVersion{
    
    //Init URL with OpenGL using mediaWiki API
    NSString *urlWikiOpenGL = @"https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=jsonfm&titles=OpenGL&rvsection=0";
    
    //Init Wikipedia Manager with Singleton Class
    _wikiManager = [WikipediaManager sharedManager];
    
    //Init DataTask by Fetching Data
    _openGLVersionNumber = [_wikiManager fetchDataFromSite:urlWikiOpenGL];
    
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
    [newSculptObject setSculptMoves:_openGLVersionNumber];
}


@end
