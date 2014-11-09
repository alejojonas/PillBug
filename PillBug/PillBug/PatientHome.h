//
//  PatientHome.h
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFLogInViewController.h>


@interface PatientHome : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
- (IBAction)LogOutBtn:(id)sender;


@end
