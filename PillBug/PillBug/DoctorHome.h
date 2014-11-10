//
//  DoctorHome.h
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Parse/PFLogInViewController.h>

@interface DoctorHome : UIViewController <UITabBarDelegate, UITableViewDataSource, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>{
    IBOutlet UITableView *tableView;
    
    NSArray * mainArray;
}
- (IBAction)logOutBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *addPatient;

@end
