//
//  TabOneVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SculptGLKVC.h"

@interface TabOneVC : UIViewController 

/*Outlets*/

@property (strong, nonatomic) IBOutlet UILabel *appNameLabelView;

@property (strong, nonatomic) IBOutlet SculptGLKVC *glkView;

@property (strong, nonatomic) IBOutlet UILabel *openGLVersionLabel;


@end
