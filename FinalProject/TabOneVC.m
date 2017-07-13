//
//  TabOneVC.m
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "TabOneVC.h"
#import "AppDelegate.h"
#import "CustomGlkView.h"
#import "SculptObject+CoreDataClass.h"

@interface TabOneVC ()<GLKViewControllerDelegate>
@property (strong) EAGLContext *glContext;
@property (weak, nonatomic) IBOutlet UIView *container;


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
    
    //Init Context
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //Init GLKView
    self.glkView = [[CustomGlkView alloc] initWithFrame:self.container.bounds context:self.glContext];
    
    //Set Delegate
    self.glkView.delegate = self;
    
    //Init Container to Add SubView
    [self.container addSubview:self.glkView];
    
    //Set glkView
    [self.glkView setNeedsDisplay];
    
    //Fetch, Parse, Store, Retrieve & Set OpenGLVersion
    [self setupWebServiceWikipediaOpenGLVersion];
    
    //Init edges
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //Init edge behavours
    self.extendedLayoutIncludesOpaqueBars = NO;
}


#pragma -mark viewDidDisappear
/**
 Description
 
 - Take Screenshot
 - Save Image to File
 
 @param animated animated description
 */
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //Take Screenshot
        UIImage *screenshot =  [self captureScreen];
        
        //Save image into File
        [self imageToFile: screenshot];
    });
    
    
    
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
//
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



#pragma -mark imageToFile
/**
 Method: imageToFile
 
 Description:
 
 - Save Image to File
 
 @param image <#image description#>
 */
- (void) imageToFile: (UIImage*) image {
    
    //Init Directory
     NSString *destination = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ImageDirectory"];
    
    //Init image file path
    NSString *imageFileName = @"sculptImage.png";
    
    //Init Handle on File
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:[destination stringByAppendingPathComponent:imageFileName]];
    
    //Init Data
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];

    
    //Write Image to File
    [fileHandle writeData:imageData];
    
}


#pragma -mark captureScreen
/**
 Method: captureScreen
 
 Description:
 
 - Takes a screenshot of the window
 
 @return return image
 */
- (UIImage*) captureScreen {
    
    //Init Window
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    //Init Rect
    CGRect rect = [keyWindow bounds];
    
    //Set UIGraphic
    UIGraphicsBeginImageContext(rect.size);
    
    //Init Context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set Context for Layer
    [keyWindow.layer renderInContext:context];
    
    //Set Hierachy
    [self.glkView drawViewHierarchyInRect:self.glkView.frame afterScreenUpdates:YES];
    
    //Set Image
    UIImage *image = [UIImage imageNamed:@"sculptImage.png"];

    //Set Image to Screen Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //Close Context
    UIGraphicsEndImageContext();
    
    //Return Image
    return image;
}


#pragma  - mark setupWebServiceWikipediaOpenGLVersion
/**
 
 Description
 - Fetch, Parse, & Set OpenGL Version Number from Wikipedia
 - Store, & Fetch OpenGLVersion from CoreData
 - Assign Label Values
 */
-(bool)setupWebServiceWikipediaOpenGLVersion{
    
    //Init Test Flag
    int testFlag = 1;
    
    //Flag Util for Err Checking
    if(testFlag == 1){
        
        //Init URL  with OpenGL using mediaWiki API
        NSString *urlWikiOpenGL = @"https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=json&titles=OpenGL&rvsection=0";
        
        //Init Wikipedia Manager with Singleton Class
        _wikiManager = [WikipediaManager sharedManager];
        
        
        id fetchedNumber = ^(float number){
            
            NSLog(@"Value: %f", number);
            
            //Add to the Asynchron Queue
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //Store Data into CoreData
                [self saveDataToCoreData:number];
                
                //Fetch Data from CoreData
                [self fetchDataFromCoreData];
                
            });
            
        };
        
        //Init DataTask by Fetching Data
        _openGLVersionNumber = [_wikiManager fetchDataFromSite:urlWikiOpenGL :fetchedNumber];
        
      
        
        //Return True if Successful
        return true;
    }//End of If Block
    else {
        
        //Return False if program end
        return false;
    }//End of Else Block
}

/**
 Method: fetchDataFromCoreData
 
 Description
 - Fetch Data from CoreData file
 - Retrive OpenGL Version Number
 - Assignment of OpenGL Version Number to the field value of openGLVersionLabel
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
        
        //Return True if Successful
        return true;
        
    }//End of If Block
    else {
        
        //Return False if program end
        return false;
    }//End of Else Block
    
}

# pragma mark - saveDataToCoreData
/**
 Method: saveDataToCoreData
 
 Description:
 - Save OpenGLVersion to the CoreData
 
 */
-(bool)saveDataToCoreData:(float) number{
    
    //Init Test Flag
    int testFlag = 1;
    
    //Flag Util for Err Checking
    if(testFlag == 1){
        
        
        
        //TODO Tasks to Store Data into CoreData
        //1. Get a reference the app delegate
        AppDelegate *appD = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        //2. Create a local reference to the context
        NSManagedObjectContext *context = [appD.persistentContainer viewContext];
        
        //3. Create an object in the content
        SculptObject *newSculptObject = [[SculptObject alloc] initWithContext:context];
        
        //4. Set the values
        [newSculptObject setOpenGLVersion:number];
        
        //Return True if Successful
        return true;
        
    }//End of If Block
    else {
        
        //Return False if program end
        return false;
    }//End of Else Block
}


@end
