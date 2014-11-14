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

    NSLog(drugName);
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"Drugs"];
    [query whereKey:@"drugName" equalTo:drugName];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *name = [object objectForKey:@"drugName"];
        self.prescriptionNameLabel.text = name;
        NSString *catagory = [object objectForKey:@"drugCatagory"];
        self.drugCategoryLabel.text = catagory;
        
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
