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
@interface GLKView(Touch)
@end
@implementation GLKView(Touch)
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
#pragma -mark touchesMoved
/**
 Method: touchesMoved
 - Sculpts Model
 
 Description
 - Moves Cursor
 
 @param touches <#touches description#>
 @param event <#event description#>
 */
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //Init Touch Point
    CGPoint touch_point = [[touches anyObject] locationInView:self];
    
    //Assign
    touch_point = CGPointMake(touch_point.x, 480-touch_point.y); //Or you can put touch_point.y = 480-touch_point.y
    
    //PassTouchPointToSculpt
    [self sculptTouchAtPoint:touch_point.x :touch_point.y];
    
}

- (void) sculptTouchAtPoint:(float )xcord :(float) ycord
{
    
    //OpenGL Sculpt Setup
    
    //Transform delta to coordinate on model
    
    //Line Tracing
    
    
    
}



@end
@implementation SculptGLKVC


-(instancetype)initWithGLKView: (GLKView*)glkViewParam {
    
    self = [super init];
    
    if(self) {
        //Init With GLKView
        _glkView = glkViewParam;
        _glkView.userInteractionEnabled = YES;
    }
    
    return self;
}


#pragma -mark viewDidLoad
/**
 Method: viewDidLoad
 
 Description:
 - Performs methods after loading.
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Create GLKView
    GLKView *glkView = (GLKView *)self.view;
    
    //Create context
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //Set Context to GLKView
    [glkView setContext:context];
    
    //Set Colour Format to GLKView
    glkView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    //Set EAGL Context
    [EAGLContext setCurrentContext:context];
    
    //Call Custom Method
    [self setup];
}

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
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *imageScreenShot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //Return UIIMage
    return imageScreenShot;
    
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



/**
 Method: changeBackgroundColorToUserSetting
 
 Description
 - Helper Method
 - Reads User Defaults
 - Assigns Color accordingly
 
 @return savedVal
 -     If savedVal = 0 : Assume Keep Background Color
 -     Else if SavedVal !0 : Assume Change Background Color
 
 */
#pragma -mark getUserSettingForBackgroundColor
-(NSInteger)getUserSettingForBackgroundColor{
    
    //Init NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Fetch User Setting Value
    NSInteger savedVal = [[defaults valueForKey:@"enabled_preferences"] integerValue];
    
    //Return Value
    return savedVal;
    
}


#pragma mark -Overriden glkView
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClear(GL_COLOR_BUFFER_BIT);
    
    
    //Draw a triangle
    
    float *triangle = (float *)malloc(sizeof(float) * 6);
    triangle[0] = 0.0;
    triangle[2] = 1.0;
    triangle[3] = 0.0;
    triangle[4] = 0.0;
    triangle[5] = -1.0;
    
    
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, triangle);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
}



#pragma mark -Custom Setup Method

- (void) setup{
    //Clear Window
    glClearColor(0.0, 1.0, 0.0, 1.0);
    
    //Create and Compile Vertex Shader
    GLuint vertexShaderCopy = [self vertexShaderSetup];
    
    //Create and Compile Fragment Shader
    GLuint fragmentShaderCopy = [self fragmentShaderSetup];
    
    //Link shaders into a program
    GLuint program = glCreateProgram();
    
    //Attach VERTEX Shader to prgraom
    glAttachShader(program, vertexShaderCopy);
    
    //Attach FRAGMENT Shaders
    glAttachShader(program, fragmentShaderCopy);
    
    //Bind
    
    const GLchar *pos = [@"position" UTF8String];
    
    glBindAttribLocation(program, 0, pos);
    
    //Link Program to glkView
    glLinkProgram(program);
    
    /*LINK ERROR CHECKING*/
    GLint programLinkStatus = GL_FALSE;
    glGetProgramiv(program, GL_LINK_STATUS, &programLinkStatus);
    if(programLinkStatus == GL_FALSE){
        
        GLint programLogLength = 0;
        glGetProgramiv(program, GL_INFO_LOG_LENGTH, &programLogLength);
        
        GLchar linkLog = programLogLength;
        glGetProgramInfoLog(program, programLogLength, nil, &linkLog);
        
        NSString *linkLogString = [NSString stringWithUTF8String:&linkLog];
        
        NSLog(@"ERROR: LINK COMPILE FAILED: %@", linkLogString );
    }
    
    //Use Program for each
    glUseProgram(program);
    
    glEnableVertexAttribArray(0);
}

#pragma mark -Fragment Shader Helper Method
-(GLuint)fragmentShaderSetup{
    
    /*Temp Strings*/
    NSString  *tempString1 = [NSString stringWithFormat:@" void main()"];
    NSString  *tempString2 = [NSString stringWithFormat:@"{"];
    NSString  *tempString3 = [NSString stringWithFormat:@"    gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);"];
    NSString  *tempString4 = [NSString stringWithFormat:@"}"];
    
    /*Concat Strings*/
    NSString *fragmentShaderSource = [NSString stringWithFormat:@"%@%@%@%@", tempString1, tempString2, tempString3, tempString4];
    
    /*Convert String to UTF8*/
    const char *fragmentShaderSourceUTF8 = [fragmentShaderSource UTF8String];
    
    //Init fragment shader
    GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    
    //Assign fragment shader
    glShaderSource(fragmentShader, 1, &fragmentShaderSourceUTF8, nil);
    
    //Compile fragment shader
    glCompileShader(fragmentShader);
    
    
    /*FRAGMENT ERROR CHECKING*/
    
    GLint fragmentShaderCompileStatus = GL_FALSE;
    
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &fragmentShaderCompileStatus);
    
    if(fragmentShaderCompileStatus == GL_FALSE) {
        
        GLint fragmentShaderLogLength = 0;
        
        glGetShaderiv(fragmentShader, GL_INFO_LOG_LENGTH, &fragmentShaderLogLength);
        
        GLchar fragmentShaderLog = fragmentShaderLogLength;
        
        glGetShaderInfoLog(fragmentShader, fragmentShaderLogLength, nil, &fragmentShaderLog);
        
        NSString *fragmentShaderlogString = [NSString stringWithUTF8String:&fragmentShaderLog];
        
        NSLog(@"ERROR: FRAGMENT SHADER COMPILE FAILED: %@", fragmentShaderlogString );
    }
    
    return fragmentShader;
}


#pragma mark -Vertex Shader Helper Method
-(GLuint)vertexShaderSetup{
    
    /*Temp Strings*/
    NSString  *tempString0 = [NSString stringWithFormat:@"attribute vec2 position;"];
    NSString  *tempString1 = [NSString stringWithFormat:@" void main()"];
    NSString  *tempString2 = [NSString stringWithFormat:@"{"];
    NSString  *tempString3 = [NSString stringWithFormat:@"    gl_Position = vec4(position.x, position.y, 0.0, 1.0);"];
    NSString  *tempString4 = [NSString stringWithFormat:@"}"];
    
    /*Concat Strings*/
    NSString *vertexShaderSource = [NSString stringWithFormat:@"%@%@%@%@%@", tempString0, tempString1, tempString2, tempString3, tempString4];
    
    /*Convert String to UTF8*/
    const char *vertexShaderSourceUTF8 = [vertexShaderSource UTF8String];
    
    //Init vertex shader
    GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
    
    //Assign vertex shader
    glShaderSource(vertexShader, 1, &vertexShaderSourceUTF8, nil);
    
    //Compile vertex shader
    glCompileShader(vertexShader);
    
    GLint vertexShaderCompileStatus = GL_FALSE;
    
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &vertexShaderCompileStatus);
    
    if(vertexShaderCompileStatus == GL_FALSE) {
        
        GLint vertexShaderLogLength = 0;
        
        glGetShaderiv(vertexShader, GL_INFO_LOG_LENGTH, &vertexShaderLogLength);
        
        GLchar vertexShaderLog = vertexShaderLogLength;
        
        glGetShaderInfoLog(vertexShader, vertexShaderLogLength, nil, &vertexShaderLog);
        
        NSString *vertexShaderlogString = [NSString stringWithUTF8String:&vertexShaderLog];
        
        NSLog(@"ERROR: VERTEX SHADER COMPILE FAILED: %@", vertexShaderlogString );
    }
    
    return vertexShader;
}


@end
