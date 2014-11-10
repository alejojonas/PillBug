//
//  DoctorHome.m
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "DoctorHome.h"

@interface DoctorHome ()

@end

@implementation DoctorHome


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [self retrieveFromParse];    
}

- (void) retrieveFromParse{
    NSString *currentUserName = [[PFUser currentUser]username];
        
    NSString *predicateString = [NSString stringWithFormat:@"'%@' IN assignedDoctors", currentUserName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"ClinicPatients" predicate:predicate];
    
    [retrievePatientNames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            mainArray = [[NSArray alloc]initWithArray:objects];
        }
        [tableView reloadData];
    }];
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [mainArray objectAtIndex:indexPath.row];
    return cell;*/
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempObject objectForKey:@"patientName"];
    return cell;
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

- (IBAction)logOutBtn:(id)sender {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
