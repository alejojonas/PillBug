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
    
    sunday.layer.borderWidth = .5f;
    sunday.layer.cornerRadius = 5;
    monday.layer.borderWidth = .5f;
    monday.layer.cornerRadius = 5;
    tuesday.layer.borderWidth = .5f;
    tuesday.layer.cornerRadius = 5;
    wednesday.layer.borderWidth = .5f;
    wednesday.layer.cornerRadius = 5;
    thursday.layer.borderWidth = .5f;
    thursday.layer.cornerRadius = 5;
    friday.layer.borderWidth = .5f;
    friday.layer.cornerRadius = 5;
    saturday.layer.borderWidth = .5f;
    saturday.layer.cornerRadius = 5;

    
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
            if(sunday.selected == true){
                [sunday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [sunday.titleLabel setTextColor:[UIColor whiteColor]];
            }
            [monday setSelected:[[dayArray objectAtIndex:1]boolValue]];
            if(monday.selected == true){
                [monday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [monday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            [tuesday setSelected:[[dayArray objectAtIndex:2]boolValue]];
            if(tuesday.selected == true){
                [tuesday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [tuesday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            [wednesday setSelected:[[dayArray objectAtIndex:3]boolValue]];
            if(wednesday.selected == true){
                [wednesday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [wednesday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            [thursday setSelected:[[dayArray objectAtIndex:4]boolValue]];
            if(thursday.selected == true){
                [thursday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [thursday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            [friday setSelected:[[dayArray objectAtIndex:5]boolValue]];
            if(friday.selected == true){
                [friday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [friday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            [saturday setSelected:[[dayArray objectAtIndex:6]boolValue]];
            if(saturday.selected == true){
                [saturday.layer setBackgroundColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
                [saturday.titleLabel setTextColor:[UIColor whiteColor]];

            }
            
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
