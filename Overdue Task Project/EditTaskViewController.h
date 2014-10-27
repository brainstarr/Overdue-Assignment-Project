//
//  EditTaskViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"

@protocol EditTaskViewControllerDelegate <NSObject>

@required

-(void)didUpdateTask:(TaskObject *)updatedTask;

@end

@interface EditTaskViewController : UIViewController

@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) TaskObject *task;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITextField *editTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *editDescriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *editTaskDatePicker;

@end
