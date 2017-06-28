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


//Float to hold number of sculpts moves made
@property (nonatomic) float sculptMovesCount;

//Helper Method to save Data
-(void)saveDataToCoreData;


@end
