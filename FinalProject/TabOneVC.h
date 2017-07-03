//
//  TabOneVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SculptGLKVC.h"
#import "WikipediaManager.h"


@interface TabOneVC : UIViewController 

/*Outlets*/

@property (strong, nonatomic) IBOutlet GLKView *glkView;



@property (strong, nonatomic) IBOutlet UILabel *appNameLabelView;

@property (strong, nonatomic) IBOutlet UILabel *openGLVersionLabel;

@property (nonatomic)  float openGLVersionNumber;

@property (strong, nonatomic)  WikipediaManager *wikiManager;


/*Methods*/

-(bool)setupWebServiceWikipediaOpenGLVersion;

-(bool)fetchDataFromCoreData;

-(bool)saveDataToCoreData;


@end
