//
//  RegisterViewController.h
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFLogInViewController.h>

@interface RegisterViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

- (IBAction)patientBtn:(id)sender;
- (IBAction)doctorBtn:(id)sender;

@end
