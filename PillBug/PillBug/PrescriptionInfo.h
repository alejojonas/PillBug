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
@property (weak, nonatomic) IBOutlet UILabel *drugCategoryLabel;

@end
