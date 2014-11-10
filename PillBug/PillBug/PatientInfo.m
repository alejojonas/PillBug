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
    NSLog(@"patientInfo");
    TabBarController *tabBar = (TabBarController *)self.tabBarController;
    self.patientUsername = tabBar.patientUsername;
    
    PFQuery *query = [PFQuery queryWithClassName:@"ClinicPatients"];
    [query whereKey:@"username" equalTo:self.patientUsername];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *name = [object objectForKey:@"patientName"];
        self.nameLabel.text = name;
        NSString *dob = [object objectForKey:@"dateOfBirth"];
        self.dobLabel.text = dob;
        NSString *phoneNumber = [object objectForKey:@"phoneNumber"];
        self.numberLabel.text = phoneNumber;
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
