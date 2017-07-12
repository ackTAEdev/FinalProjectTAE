//
//  AppDelegate.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
//#import "TabBarRootVC.h"
#import "TabOneVC.h"
#import "TabTwoVC.h"
#import "SculptGLKVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

//Setups View Controllers of TabBarVC, TabOne, TabTwo
-(void) tabBarVCSetup;

@end

