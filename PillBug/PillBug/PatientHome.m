//
//  PatientHome.m
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PatientHome.h"
#import "Login.h"

//Patient Data currently hard coded in viewDidLoad. Each medicine must have a matching jpg
//ie if "Ibufrofen" in list of medicine, "Ibuprofen.jpg" must exist.
//

@interface PatientHome (){
   // NSArray *demoPatientData; //DATA CURRENTLY HARD CODE FILLED
    NSArray *mainArray;

}


- (IBAction)buttonPressed:(id)sender;

@end

@implementation PatientHome


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //demoPatientData= @[@"Ibuprofen", @"Tylenol", @"Advil",@"Ibuprofen",@"Tylenol",@"Advil"]; //HARD CODED PATIENT DATA
    
    [self retrieveFromParse];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) retrieveFromParse{
    NSString *currentUser = [[PFUser currentUser] username];
    
    NSString *predicateString = [NSString stringWithFormat:@"'%@' IN assignedPatients", currentUser];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
    
    PFQuery *retrieveDrugNames = [PFQuery queryWithClassName:@"Drugs" predicate:predicate];
    
    [retrieveDrugNames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            mainArray = [[NSArray alloc]initWithArray:objects];
        }
        [self.tableView reloadData];
    }];
}


- (NSString *)getImageFilename:(NSString *)demoPatientData
{
    //ALL PATIENT MEDICINE MUST HAVE MATCHING IMAGE FILE WITH SAME NAME + JPG
    NSString *imageFilename = [[demoPatientData capitalizedString]stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@".jpg"];

    return imageFilename;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
    PFObject  *tempObject = [mainArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [tempObject objectForKey:@"drugName"];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 0;
    return [demoPatientData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *pillName = [demoPatientData objectAtIndex:indexPath.row];
    cell.textLabel.text = pillName;
    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:pillName]];
    
    
    return cell;
}

 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)LogOutBtn:(id)sender {
    [PFUser logOut];    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)buttonPressed:(id)sender
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = @"Take your damn pills!";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = NSMinuteCalendarUnit;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    
}
@end
