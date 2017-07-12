//
//  TabOneVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGlkView.h"
#import "WikipediaManager.h"


@interface TabOneVC : UIViewController <GLKViewDelegate>

/*Outlets*/

@property (strong, nonatomic) IBOutlet CustomGlkView *glkView;



@property (strong, nonatomic) IBOutlet UILabel *appNameLabelView;

@property (strong, nonatomic) IBOutlet UILabel *openGLVersionLabel;

@property (nonatomic)  float openGLVersionNumber;

@property (strong, nonatomic)  WikipediaManager *wikiManager;


/*Methods*/

-(bool)setupWebServiceWikipediaOpenGLVersion;

-(bool)fetchDataFromCoreData;

-(bool)saveDataToCoreData;


@end
