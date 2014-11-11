//
//  AddPrescription.m
//  PillBug
//
//  Created by Kay Lab on 11/10/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "AddPrescription.h"
#import "PatientPrescription.h"
#import "TabBarController.h";

@interface AddPrescription ()

@end

@implementation AddPrescription

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
    // Do any additional setup after loading the view.
    
    
    [self retrieveFromParse];
}

- (void) retrieveFromParse{
    NSString *currentUserName = self.patientUsername;
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"Drugs"];
    
    [retrievePatientNames whereKey:@"assignedPatients" notEqualTo:currentUserName];
    
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
    cell.textLabel.text = [tempObject objectForKey:@"drugName"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *drugs = [mainArray objectAtIndex:indexPath.row];
    NSString *drugName = [drugs objectForKey:@"drugName"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Add" message:drugName delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertView.tag = indexPath.row;
    [alertView show];
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    PFObject *drugs = [mainArray objectAtIndex:alertView.tag];
    NSString *currentUserName = self.patientUsername;
    NSString *drugName = [drugs objectForKey:@"drugName"];
    
    if(buttonIndex == 1){
        PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"Drugs"];
        
        [retrievePatientNames whereKey:@"drugName" equalTo:drugName];
        
        
        [retrievePatientNames getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(!error){
                [object addUniqueObject:currentUserName forKey:@"assignedPatients"];
                [object saveInBackground];
            }
        }];
        
        [tableView reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
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
