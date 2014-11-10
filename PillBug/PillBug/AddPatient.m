//
//  AddPatient.m
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "AddPatient.h"
#import "TabBarController.h"

@interface AddPatient ()

@end

@implementation AddPatient


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
    // Do any additional setup after loading the view.
    [self retrieveFromParse];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (void) retrieveFromParse{
    NSString *currentUserName = [[PFUser currentUser]username];
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"ClinicPatients"];
    
    [retrievePatientNames whereKey:@"assignedDoctors" notEqualTo:currentUserName];
    
    [retrievePatientNames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            mainArray = [[NSArray alloc]initWithArray:objects];
        }
        [tableView reloadData];
    }];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempObject objectForKey:@"patientName"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *patient = [mainArray objectAtIndex:indexPath.row];
    NSString *patientName = [patient objectForKey:@"patientName"];

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Add" message:patientName delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertView.tag = indexPath.row;
    [alertView show];

}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    PFObject *patient = [mainArray objectAtIndex:alertView.tag];
    NSString *currentUserName = [[PFUser currentUser]username];
    NSString *patientName = [patient objectForKey:@"patientName"];
    
    if(buttonIndex == 1){
        PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"ClinicPatients"];
        
        [retrievePatientNames whereKey:@"patientName" equalTo:patientName];
        
        
        [retrievePatientNames getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(!error){
                [object addUniqueObject:currentUserName forKey:@"assignedDoctors"];
                [object saveInBackground];
            }
        }];
        
        [tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];

    }
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
