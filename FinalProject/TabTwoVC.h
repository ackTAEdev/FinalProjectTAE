//
//  TabTwoVC.h
//  FinalProject
//
//  Created by Akshay C Khanna on 28/06/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface TabTwoVC : UIViewController

/*Outlets*/
@property (strong, nonatomic) IBOutlet UIImageView *sculptImageView;

@property (strong, nonatomic) IBOutlet UILabel *sculptMovesLabelView;

@property (strong, nonatomic) UIImage *sculptUIImage;


/*Actions*/

- (IBAction)shareFacebookAction:(id)sender;

- (IBAction)shareEmailAction:(id)sender;

- (IBAction)scheduleSculptTimeAction:(id)sender;

/*Methods*/

-(void)saveImageToFile;

@end
