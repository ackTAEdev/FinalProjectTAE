//
//  TabTwoVC.m
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "TabTwoVC.h"
#import "AppDelegate.h"
#import "SculptObject+CoreDataClass.h"


@interface TabTwoVC ()

@end

@implementation TabTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //Fetch Data to Store into VC Label
    [self fetchDataFromCoreData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchDataFromCoreData{
    
    //1. Get a refernecne to the app delegate
    AppDelegate *appD = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    //2. Create a local reference to the context
    NSManagedObjectContext *context = [appD.persistentContainer viewContext];
    
    //3. Create fetch request the Contact entity
    NSFetchRequest *fetch = [SculptObject fetchRequest];

    //4. Create a predicate for the search
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sculptMoves"];
    
    //5. Set the predicate the search
    [fetch setPredicate:predicate];
    
    //6. Fetch the items
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:fetch error:&error];

    //7a. Set the message if no items are found
    if ([objects count] ==0) {
        self.sculptMovesLabelView.text = @"No matches found";
    } else {
        
        //7b. Create a mutable string with the details of the contacts found
        NSMutableString *string = [NSMutableString string];
        
        for (SculptObject *foundObject in objects) {
            [string appendFormat:@"SculptMoves: %f", foundObject.sculptMoves];
        }//End of For Loop
        
        self.sculptMovesLabelView.text = string;
    }//End of If Loop
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareFacebookAction:(id)sender {
}

- (IBAction)shareEmailAction:(id)sender {
}

- (IBAction)scheduleSculptTimeAction:(id)sender {
}
@end
