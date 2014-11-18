//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set color used for text
    ////UIColor *color = [UIColor colorWithRed:90.0f/255.0f green:90.0f/255.0f blue:120.0f/255.0f alpha:1.0];
    UIColor *fieldColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:125.0f/255.0f];
    UIColor *fieldColorActive = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:255.0f/255.0f];
    UIColor *forgotPasswordColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:200.0f/255.0f];
    
    // Set background image and title
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"PillBugLogo.jpg"]]];
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PillBugTitle.jpg"]]];
    ////[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    ////[self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PillbugLogoBR.png"]]];
    
    
    // Set buttons appearance
    [self.logInView.usernameField setBackground:[UIImage imageNamed:@"PillBugField2.jpg"]];
    [self.logInView.passwordField setBackground:[UIImage imageNamed:@"PillBugField2.jpg"]];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"PillBugLoginButtonLarge.jpg"] forState:UIControlStateNormal];
    
    ////[self.logInView.usernameField setBackground:[UIImage imageNamed:@"TextFieldBox.png"]];
    ////[self.logInView.passwordField setBackground:[UIImage imageNamed:@"TextFieldBox.png"]];
    ////[self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"LoginButton.png"] forState:UIControlStateNormal];
    ////[self.logInView.passwordForgottenButton setImage:[UIImage imageNamed:@"ForgotPassword"] forState:UIControlStateNormal];

    
    // Set field text
    ////[self.logInView.logInButton setTitle:@"Login" forState:UIControlStateNormal];
    self.logInView.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: fieldColor}];
    self.logInView.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: fieldColor}];
    [self.logInView.logInButton setTitle:@"" forState: UIControlStateNormal];
    
    
    // Set field text size
    self.logInView.logInButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.logInView.usernameField setFont:[UIFont systemFontOfSize:14.0f]];
    [self.logInView.passwordField setFont:[UIFont systemFontOfSize:14.0f]];
    
    
    // Set field text color
    [self.logInView.passwordForgottenButton setTitleColor:forgotPasswordColor forState:UIControlStateNormal];
    
    [self.logInView.logInButton setTitleColor:fieldColorActive forState:UIControlStateNormal];
    [self.logInView.usernameField setTextColor:fieldColorActive];
    [self.logInView.passwordField setTextColor:fieldColorActive];

    
    self.logInView.usernameField.textAlignment = NSTextAlignmentCenter;
    self.logInView.passwordField.textAlignment = NSTextAlignmentCenter;
    
    

    
    
    [self.logInView addSubview:self.fieldsBackground];
    [self.logInView sendSubviewToBack:self.fieldsBackground];
    
    // Remove text shadow
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 1.0f;
    layer.cornerRadius = 8;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 1.0f;
    layer.cornerRadius = 8;
    
    
    
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.textAlignment =NSTextAlignmentCenter;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""];
    return YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    [self.logInView.logo setFrame:CGRectMake(0.7f, 0.0f, 319.3f, 170.0f)];
    [self.logInView.usernameField setFrame:CGRectMake(99.0f, 206.0f, 124.0f, 22.0f)];
    [self.logInView.passwordField setFrame:CGRectMake(97.0f, 282.0f, 123.0f, 21.0f)];
    [self.logInView.logInButton setFrame:CGRectMake(75.0f, 378.0f, 175.0f, 69.0f)];
    [self.logInView.passwordForgottenButton setFrame:CGRectMake(95.0f,450.0f, 140.0f, 20.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
