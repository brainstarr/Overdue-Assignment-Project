//
//  DetailTaskViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"
#import "EditTaskViewController.h"

@interface DetailTaskViewController : UIViewController

@property (strong, nonatomic) TaskObject *task;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UILabel *detailViewTaskTitle;
@property (strong, nonatomic) IBOutlet UILabel *detailViewTaskDate;

@property (strong, nonatomic) IBOutlet UILabel *detailTextView;

@end
