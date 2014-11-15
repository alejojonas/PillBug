//
//  PrescriptionEditor.h
//  PillBug
//
//  Created by Kay Lab on 11/8/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PrescriptionEditor : UIViewController <UITabBarDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
    NSArray * timeArray;

}

- (IBAction)backBtn:(id)sender;

- (IBAction)sundayBtn:(id)sender;
- (IBAction)mondayBtn:(id)sender;
- (IBAction)tuesdayBtn:(id)sender;
- (IBAction)wednesdayBtn:(id)sender;
- (IBAction)thursdayBtn:(id)sender;
- (IBAction)fridayBtn:(id)sender;
- (IBAction)saturdayBtn:(id)sender;

- (IBAction)saveBtn:(id)sender;

@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *patientUsername;
@property (nonatomic, strong) NSArray *dayArray;


@property (weak, nonatomic) IBOutlet UIButton *sunday;
@property (weak, nonatomic) IBOutlet UIButton *monday;
@property (weak, nonatomic) IBOutlet UIButton *tuesday;
@property (weak, nonatomic) IBOutlet UIButton *wednesday;
@property (weak, nonatomic) IBOutlet UIButton *thursday;
@property (weak, nonatomic) IBOutlet UIButton *friday;
@property (weak, nonatomic) IBOutlet UIButton *saturday;


@end
