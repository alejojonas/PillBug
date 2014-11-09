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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

    
    
    
    mainArray = [[NSArray alloc] initWithObjects:@"one", @"two", @"three", nil];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [mainArray count];
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thisCell"];
    cell.textLabel.text = [mainArray objectAtIndex:indexPath.row];
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
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addPatient:(id)sender {
}

@end
