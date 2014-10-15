//
//  EditTaskViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic) IBOutlet UITextField *editTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *editDescriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *editTaskDatePicker;

@end
