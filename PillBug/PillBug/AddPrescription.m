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
    
    self.searchBar.delegate = self;
    /*UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableviewbackgroundflip"]];
    tableView.backgroundView = backgroundImageView;
    tableView.backgroundView.contentMode = UIViewContentModeScaleAspectFit;*/
    [self retrieveFromParse];
}

- (void) retrieveFromParse{
    NSString *patientName = self.patientUsername;
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"Drugs"];
    
    [retrievePatientNames whereKey:@"assignedPatients" notEqualTo:patientName];
    
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
    NSString *patientName = self.patientUsername;
    NSString *drugName = [drugs objectForKey:@"drugName"];
    
    if(buttonIndex == 1){
        PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"Drugs"];
        
        [retrievePatientNames whereKey:@"drugName" equalTo:drugName];
        
        
        [retrievePatientNames getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(!error){
                [object addUniqueObject:patientName forKey:@"assignedPatients"];
                [object saveInBackground];
            }
        }];
        
        //add row to prescription class
        
        PFObject *newPrescription = [PFObject objectWithClassName:@"Prescriptions"];
        newPrescription[@"drugName"] = drugName;
        newPrescription[@"patientUsername"] = patientName;
        
        newPrescription[@"prescriberName"] = [[PFUser currentUser] username];
        
        [newPrescription addObjectsFromArray: @[ @(0), @(0), @(0), @(0), @(0), @(0), @(0) ]forKey:@"days"];
        
        [newPrescription addObjectsFromArray: @[]forKey:@"times"];
        
        newPrescription[@"updated"] = [NSNumber numberWithBool:NO];

        [newPrescription saveInBackground];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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
