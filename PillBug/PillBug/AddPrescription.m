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
