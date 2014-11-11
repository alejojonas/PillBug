//
//  AddPrescription.h
//  PillBug
//
//  Created by Kay Lab on 11/10/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Parse/PFLogInViewController.h>

@interface AddPrescription : UIViewController <UITabBarDelegate, UITableViewDataSource, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>{
    IBOutlet UITableView *tableView;
    
    NSArray * mainArray;
}
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSString *patientUsername;


@end

