//
//  PrescriptionEditor.m
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PrescriptionEditor.h"

@interface PrescriptionEditor ()

@end

@implementation PrescriptionEditor

@synthesize sunday;
@synthesize monday;
@synthesize tuesday;
@synthesize wednesday;
@synthesize thursday;
@synthesize friday;
@synthesize saturday;
@synthesize dayArray;


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
    
    self.hourText.delegate = self;
    self.minText.delegate = self;
    
    self.hourText.keyboardType = UIKeyboardTypeDecimalPad;
    self.minText.keyboardType = UIKeyboardTypeDecimalPad;
    

    
    PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];
    
    [retrievePrescription whereKey:@"patientUsername" equalTo:self.patientUsername];
    
    [retrievePrescription whereKey:@"drugName" equalTo:self.drugName];
    
    
    
    
    [retrievePrescription getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error){
            dayArray = [object objectForKey:@"days"];
            timeArray = [object objectForKey:@"times"];
            [sunday setSelected:[[dayArray objectAtIndex:0]boolValue]];
            [monday setSelected:[[dayArray objectAtIndex:1]boolValue]];
            [tuesday setSelected:[[dayArray objectAtIndex:2]boolValue]];
            [wednesday setSelected:[[dayArray objectAtIndex:3]boolValue]];
            [thursday setSelected:[[dayArray objectAtIndex:4]boolValue]];
            [friday setSelected:[[dayArray objectAtIndex:5]boolValue]];
            [saturday setSelected:[[dayArray objectAtIndex:6]boolValue]];

            [tableView reloadData];
        }
    }];
    

    
    // Do any additional setup after loading the view.
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeCell"];
    NSString *hour;
    NSString *min;
    
    
    
    NSString *timeString = [NSString stringWithFormat:@"%@",[timeArray objectAtIndex:indexPath.row] ];
    
    if(timeString.length < 4){
        hour = [timeString substringWithRange:NSMakeRange(0,1)];
        min = [timeString substringWithRange:NSMakeRange(1,2)];
    } else {
        hour = [timeString substringWithRange:NSMakeRange(0,2)];
        min = [timeString substringWithRange:NSMakeRange(2,2)];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", hour, min];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [timeArray count];
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.hourText resignFirstResponder];
    [self.minText resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField){
        [textField resignFirstResponder];
    }
    return NO;
}

- (IBAction)backBtn:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Any changes made will not be saved" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Cancel", nil];
    
    [alertView show];
    

    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 
    
    if(buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
       
    }
    

}

- (IBAction)sundayBtn:(id)sender {
    if(self.sunday.selected == NO){
        [self.sunday setSelected:YES];
    } else {
        [self.sunday setSelected:NO];
    }
}

- (IBAction)mondayBtn:(id)sender {
    if(self.monday.selected == NO){
        [self.monday setSelected:YES];
    } else {
        [self.monday setSelected:NO];
    }
}

- (IBAction)tuesdayBtn:(id)sender {
    if(self.tuesday.selected == NO){
        [self.tuesday setSelected:YES];
    } else {
        [self.tuesday setSelected:NO];
    }
}

- (IBAction)wednesdayBtn:(id)sender {
    if(self.wednesday.selected == NO){
        [self.wednesday setSelected:YES];
    } else {
        [self.wednesday setSelected:NO];
    }
}

- (IBAction)thursdayBtn:(id)sender {
    if(self.thursday.selected == NO){
        [self.thursday setSelected:YES];
    } else {
        [self.thursday setSelected:NO];
    }
}

- (IBAction)fridayBtn:(id)sender {
    if(self.friday.selected == NO){
        [self.friday setSelected:YES];
    } else {
        [self.friday setSelected:NO];
    }
}

- (IBAction)saturdayBtn:(id)sender {
    if(self.saturday.selected == NO){
        [self.saturday setSelected:YES];
    } else {
        [self.saturday setSelected:NO];
    }
}

- (IBAction)saveBtn:(id)sender {
    
    //save the days
    
    PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];
    
    [retrievePrescription whereKey:@"patientUsername" equalTo:self.patientUsername];
    
    [retrievePrescription whereKey:@"drugName" equalTo:self.drugName];
    
    
    [retrievePrescription getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error){
            [object setObject: @[ @(sunday.selected), @(monday.selected), @(tuesday.selected), @(wednesday.selected), @(thursday.selected), @(friday.selected), @(saturday.selected) ]forKey:@"days"];
            
            
            [object saveInBackground];
        }
    }];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}




- (IBAction)addBtn:(id)sender {
}
@end
