//
//  PrescriptionInfo.h
//  PillBug
//
//  Created by Kay Lab on 11/9/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PrescriptionInfo : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property NSString* drugName;
@property (weak, nonatomic) IBOutlet UILabel *prescriptionNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sunday;
@property (weak, nonatomic) IBOutlet UIButton *monday;
@property (weak, nonatomic) IBOutlet UIButton *tuesday;
@property (weak, nonatomic) IBOutlet UIButton *wednesday;
@property (weak, nonatomic) IBOutlet UIButton *thursday;
@property (weak, nonatomic) IBOutlet UIButton *friday;
@property (weak, nonatomic) IBOutlet UIButton *saturday;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dosage;
@property (weak, nonatomic) IBOutlet UILabel *presriberLabel;

@property NSArray *dayArray;
@property NSArray *timeArray;

@end
