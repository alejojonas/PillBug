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

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 CGRect frame = self.addPatient.frame;
 frame.origin.y = self.navBar.frame.size.height + self.tableView.frame.size.height + self.searchBar.frame.size.height;
 self.addPatient.frame = frame;
 
 [self.view bringSubviewToFront:self.addPatient];
 }*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self retrieveFromParse];

    // Do any additional setup after loading the view.
    
    //mainArray = [[NSArray alloc] initWithObjects:@"patient 1", @"patient 2", @"patient 3", @"patient 4", @"patient 5", nil];
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
