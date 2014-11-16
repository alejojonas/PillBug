//
//  PatientHome.h
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFLogInViewController.h>
#import <Parse/Parse.h>


@interface PatientHome : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
- (IBAction)LogOutBtn:(id)sender;

@property (nonatomic, strong) NSString *tempDrugName;
- (IBAction)buttonPressed:(id)sender;

@end

@interface ToDoItem : NSObject {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    NSString *eventName;
}

@property (nonatomic, readwrite) NSInteger year;
@property (nonatomic, readwrite) NSInteger month;
@property (nonatomic, readwrite) NSInteger day;
@property (nonatomic, readwrite) NSInteger hour;
@property (nonatomic, readwrite) NSInteger minute;
@property (nonatomic, readwrite) NSInteger second;
@property (nonatomic, copy) NSString *eventName;

@end

@implementation ToDoItem
@synthesize year, month, day, hour, minute, second, eventName;
@end