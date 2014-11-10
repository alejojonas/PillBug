//
//  PatientPrescription.h
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFLogInViewController.h>

@interface PatientPrescription : UIViewController <UITabBarDelegate, UITableViewDataSource, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>{
    IBOutlet UITableView *tableView;
    
    NSArray * mainArray;
}
- (IBAction)backBtn:(id)sender;

@property (nonatomic, strong) NSString *patientUsername;


@end
