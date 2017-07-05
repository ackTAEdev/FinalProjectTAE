//
//  SculptGLKVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>


@interface SculptGLKVC : GLKViewController


/*Fields*/

//Float to hold number of sculpts moves made
@property (nonatomic) float sculptMovesCount;

//Init of GLKView
@property  GLKView *glkView;

/*Methods*/

-(instancetype)initWithGLKView: (GLKView*) glkViewParam;

//ViewDidLoad
-(void)viewDidLoad;

//UI Touch Methods
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

//Sculpting Method
- (void) sculptTouchAtPoint:(float )xcord :(float) ycord;


//Helper Method to store sculptMoveCount
-(void)sculptMoveCounter;

//Helper Method to save Data
-(void)saveDataToCoreData;

//Method to take ScreenShotPhoto
-(UIImage*)takeScreenShotofSculpt;



@end
