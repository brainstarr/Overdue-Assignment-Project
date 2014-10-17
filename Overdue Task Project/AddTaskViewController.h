//
//  AddTaskViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"

@protocol addTaskViewControllerDelegate <NSObject>

@required

-(void)didCancel;
-(void)didCreateTask:(TaskObject *)task;

@end


@interface AddTaskViewController : UIViewController

@property (weak, nonatomic) id <addTaskViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITextField *addTaskNameField;
@property (strong, nonatomic) IBOutlet UITextView *addTaskTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDatePicker;

- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
