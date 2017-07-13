//
//  TabOneVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import "WikipediaManager.h"
#import "GLView.h"


@interface TabOneVC : UIViewController

/*Outlets*/

@property  GLView *glView;

@property (weak, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) IBOutlet UILabel *appNameLabelView;

@property (strong, nonatomic) IBOutlet UILabel *openGLVersionLabel;

@property (nonatomic)  float openGLVersionNumber;

@property (strong, nonatomic)  WikipediaManager *wikiManager;


/*Methods*/

-(bool)setupWebServiceWikipediaOpenGLVersion;

-(bool)fetchDataFromCoreData;

-(bool)saveDataToCoreData;


@end
