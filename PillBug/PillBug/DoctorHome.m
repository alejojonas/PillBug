//
//  DoctorHome.m
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "DoctorHome.h"
#import "TabBarController.h"

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

    [self retrieveFromParse];
  
    
    UILongPressGestureRecognizer *lpHandler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandler:)];
    lpHandler.minimumPressDuration = .5; //seconds
    [tableView addGestureRecognizer:lpHandler];
    
}

- (void) retrieveFromParse{
    NSString *currentUser = [[PFUser currentUser]username];
        
    NSString *predicateString = [NSString stringWithFormat:@"'%@' IN assignedDoctors", currentUser];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    
    PFQuery *retrievePatientNames = [PFQuery queryWithClassName:@"ClinicPatients" predicate:predicate];
    
    [retrievePatientNames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            mainArray = [[NSArray alloc]initWithArray:objects];
            [tableView reloadData];

        }
    }];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}



- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self viewDidLoad];
}

-(void)longPressHandler:(UILongPressGestureRecognizer *)gestureRecognizer
{
    CGPoint p = [gestureRecognizer locationInView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:p];
    
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    NSString *patientName = [tempObject objectForKey:@"patientName"];
    
      UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Remove" message:patientName delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {

    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
        alertView.tag = indexPath.row;
        [alertView show];

    }
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
                [object removeObject:currentUserName forKey:@"assignedDoctors"];
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
    cell.textLabel.text = [tempObject objectForKey:@"patientName"];
    return cell;
}

/*- (void) tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell.layer setCornerRadius:7.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:.5f];
    [cell.layer setBorderColor:[[UIColor grayColor]CGColor]];
}

- (CGFloat) tableView:(UITableView *) tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView: (UITableView *) tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return  headerView;
} */

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"selectCell"]){
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        
        PFObject *patient = [mainArray objectAtIndex:indexPath.row];
        NSString *getPatientUsername = [patient objectForKey:@"username"];
        
        TabBarController *tabBar = [segue destinationViewController];
        [tabBar setPatientUsername:getPatientUsername];
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

- (IBAction)logOutBtn:(id)sender {
    
    
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
