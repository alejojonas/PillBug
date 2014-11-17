//
//  PatientHome.m
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PatientHome.h"
#import "Login.h"
#import "PrescriptionInfo.h"

//Patient Data currently hard coded in viewDidLoad. Each medicine must have a matching jpg
//ie if "Ibufrofen" in list of medicine, "Ibuprofen.jpg" must exist.
//

#define ToDoItemKey @"EVENTKEY1"
#define MessageTitleKey @"MSGKEY1"


@interface PatientHome (){
    NSArray *mainArray;
}


- (IBAction)buttonPressed:(id)sender;

@end

@implementation PatientHome

@synthesize tempDrugName;
@synthesize timeArray;
@synthesize dayArray;

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
    
    [self retrieveFromParse];
    
    
    
    ToDoItem * bob = [[ToDoItem alloc]init];
    [bob setDay:0];
    [bob setYear:0];
    [bob setMonth:0];
    [bob setHour:0];
    [bob setMinute:0];
    [bob setSecond:45];
    [bob setEventName:@"heeleleleleo"];
    
    //scheduleNotificationWithItem( bob, 1);
    
    
    PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];
    
    [retrievePrescription whereKey:@"patientUsername" equalTo:[[PFUser currentUser] username ]];
    
    

    
    [retrievePrescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for(int i = 0; i < [objects count]; i++){
                PFObject  *temp = [objects objectAtIndex:i];
                dayArray = [temp objectForKey:@"days"];
                timeArray =  [temp objectForKey:@"times"];
                Prescription * tempPrescription = [[Prescription alloc]init];
                [tempPrescription setDrugName:[temp objectForKey:@"drugName"]];
                [tempPrescription setDays:dayArray];
                
                NSMutableArray *tempHours = [[NSMutableArray alloc]init];
                NSMutableArray *tempMinutes = [[NSMutableArray alloc]init];
                
                for (int k = 0; k < [timeArray count]; k++) {
                    NSString *timeString = [NSString stringWithFormat:@"%@", [timeArray objectAtIndex:k]];
                    NSString *hour;
                    NSString *min;
                    
                    if(timeString.length < 4){
                        hour = [timeString substringWithRange:NSMakeRange(0,1)];
                        min = [timeString substringWithRange:NSMakeRange(1,2)];
                    } else {
                        hour = [timeString substringWithRange:NSMakeRange(0,2)];
                        min = [timeString substringWithRange:NSMakeRange(2,2)];
                    }
                    
                    int hourInt = [hour integerValue];
                    
                    [tempHours addObject:[NSNumber numberWithInt:hourInt]];
                    
                    int minInt = [min integerValue];
                    
                    [tempMinutes addObject:[NSNumber numberWithInt:minInt]];
                    
                }
    
                [tempPrescription setHours:tempHours];
                [tempPrescription setMinutes:tempMinutes];

            }
        }
    }];
    
    [self scheduleNotificationWithItem:bob interval:1];
    //second parameters is when says goes off
    
    
    
}

- (void) retrieveFromParse{
    NSString *currentUser = [[PFUser currentUser] username];
    
    PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];

    
    [retrievePrescription whereKey:@"patientUsername" equalTo:currentUser];
    
    [retrievePrescription findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
    
    PFObject *drugs = [mainArray objectAtIndex:indexPath.row];
    NSString *drugNameString = [drugs objectForKey:@"drugName"];
    self.tempDrugName = drugNameString;
    
    [self performSegueWithIdentifier:@"prescriptionDetail" sender:self];

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
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"prescriptionDetail"]) {
        PrescriptionInfo *destView = segue.destinationViewController;
        destView.drugName = self.tempDrugName;
    }
}

- (IBAction)LogOutBtn:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Logging out" message:@"You will no longer recieve doctor updates" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Cancel", nil];
    
    [alertView show];
    
   

}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(buttonIndex == 0){
        [PFUser logOut];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)scheduleNotificationWithItem:(ToDoItem *)item interval:(int)minutesBefore {
    
    
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:item.day];
    [dateComps setMonth:item.month];
    [dateComps setYear:item.year];
    [dateComps setHour:item.hour];
    [dateComps setMinute:item.minute];
    [dateComps setSecond: item.second];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = [itemDate dateByAddingTimeInterval:-(minutesBefore*60)];
    NSLog(@"fireDate is %@",localNotif.fireDate);
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                            item.eventName, minutesBefore];
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    // NSDictionary *infoDict = [NSDictionary dictionaryWithObject:item.eventName forKey:ToDoItemKey];
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:item.eventName,ToDoItemKey, @"Local Push received while running", MessageTitleKey, nil];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    NSLog(@"scheduledLocalNotifications are %@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
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
