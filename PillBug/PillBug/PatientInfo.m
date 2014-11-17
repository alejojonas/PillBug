//
//  PatientInfo.m
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PatientInfo.h"
#import "TabBarController.h";

@interface PatientInfo ()

@end

@implementation PatientInfo

@synthesize patientUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TabBarController *tabBar = (TabBarController *)self.tabBarController;
    self.patientUsername = tabBar.patientUsername;
    
    PFQuery *query = [PFQuery queryWithClassName:@"ClinicPatients"];
    [query whereKey:@"username" equalTo:self.patientUsername];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *name = [object objectForKey:@"patientName"];
        self.nameLabel.text = name;
        [self.nameLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

        NSString *dob = [object objectForKey:@"dateOfBirth"];
        self.dobLabel.text = dob;
        [self.dobLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

        NSString *phoneNumber = [object objectForKey:@"phoneNumber"];
        self.numberLabel.text = phoneNumber;
        [self.numberLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

    }];
    
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
