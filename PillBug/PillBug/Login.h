	//
//  ViewController.h
//  PillBug
//
//  Created by Kay Lab on 11/7/14.
//  Copyright (c) 2014 Team10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/PFLogInViewController.h>

@interface Login : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;


@end
