//
//  PrescriptionInfo.m
//  PillBug
//
//  Created by Kay Lab on 11/9/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import "PrescriptionInfo.h"

@interface PrescriptionInfo ()

@end

@implementation PrescriptionInfo

@synthesize drugName;
@synthesize prescriptionNameLabel;
@synthesize drugCategoryLabel;

@synthesize sunday;
@synthesize monday;
@synthesize tuesday;
@synthesize wednesday;
@synthesize thursday;
@synthesize friday;
@synthesize saturday;
@synthesize dayArray;
@synthesize timeArray;

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
    
    sunday.enabled = NO;
    monday.enabled = NO;
    tuesday.enabled = NO;
    wednesday.enabled = NO;
    thursday.enabled = NO;
    friday.enabled = NO;
    saturday.enabled = NO;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Drugs"];
    [query whereKey:@"drugName" equalTo:drugName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *name = [object objectForKey:@"drugName"];
        self.prescriptionNameLabel.text = name;
        NSString *catagory = [object objectForKey:@"drugCatagory"];
        self.drugCategoryLabel.text = catagory;
        
    }];
    
    
    PFQuery *retrievePrescription = [PFQuery queryWithClassName:@"Prescriptions"];
    
    [retrievePrescription whereKey:@"patientUsername" equalTo:[[PFUser currentUser] username ]];
    
    [retrievePrescription whereKey:@"drugName" equalTo:drugName];
    
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
            
            NSMutableString *results = [NSMutableString stringWithString:@""];
            
            for(int i = 0 ; i < [timeArray count]; i++){
                NSString *temp = [NSString stringWithFormat:@"%@ ", timeArray[i]];
                NSLog(temp);
                [results appendString:temp];
                
            }
            NSLog(results);
            self.timeLabel.text = results;
        }
    }];
    
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

- (IBAction)BackBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
