//
//  PatientPrescription.m
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PatientPrescription.h"
#import "TabBarController.h"
#import "AddPrescription.h"
#import "PrescriptionEditor.h"
#import <Parse/Parse.h>

@interface PatientPrescription ()

@end

@implementation PatientPrescription

@synthesize patientUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self retrieveFromParse];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self retrieveFromParse];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate = self;

    TabBarController *tabBar = (TabBarController *)self.tabBarController;
    self.patientUsername = tabBar.patientUsername;
    
    [self retrieveFromParse];
    
    
    UILongPressGestureRecognizer *lpHandler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    lpHandler.minimumPressDuration = .5; //seconds
    [tableView addGestureRecognizer:lpHandler];
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self viewDidLoad];
}

- (void) retrieveFromParse{
    
    
    NSString *patientName = self.patientUsername;
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"Prescriptions"];
    
    [retrievePatientNames whereKey:@"patientUsername" equalTo:patientName];
    
    [retrievePatientNames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            mainArray = [[NSArray alloc]initWithArray:objects];
        }
        [tableView reloadData];
    }];
    
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
}

-(void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:p];
    
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    NSString *drugName = [tempObject objectForKey:@"drugName"];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Remove" message:drugName delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {

    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        alertView.tag = indexPath.row;

        [alertView show];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    PFObject *drugs = [mainArray objectAtIndex:alertView.tag];
    NSString *currentUserName = self.patientUsername;
    NSString *drugName = [drugs objectForKey:@"drugName"];
    
    if(buttonIndex == 1){
        
        PFQuery *retrieveDrug = [PFQuery queryWithClassName:@"Drugs"];
        
        [retrieveDrug whereKey:@"drugName" equalTo:drugName];
        
        
        [retrieveDrug getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(!error){
                [object removeObject:currentUserName forKey:@"assignedPatients"];
                [object saveInBackground];
                [tableView reloadData];
                [self viewDidLoad];
            }
        }];
        
        PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];
        
        [retrievePrescription whereKey:@"drugName" equalTo:drugName];
        
        
        [retrievePrescription getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            if(!error){
                [object deleteInBackground];
                [object saveInBackground];
                [tableView reloadData];
                [self viewDidLoad];
            }
        }];

    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempObject objectForKey:@"drugName"];
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addPrescription"]) {
        AddPrescription *destView = segue.destinationViewController;
        destView.patientUsername = self.patientUsername;
    }
    if ([segue.identifier isEqualToString:@"editPrescription"]) {
        NSIndexPath *path = [tableView indexPathForSelectedRow];
        PFObject *drugs = [mainArray objectAtIndex:path.row];
        NSString *drugNameString = [drugs objectForKey:@"drugName"];
        PrescriptionEditor *destView = segue.destinationViewController;

        destView.drugName = drugNameString;
        destView.patientUsername = self.patientUsername;
        
    }
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
