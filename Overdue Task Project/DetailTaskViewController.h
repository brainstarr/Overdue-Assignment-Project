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

@protocol DetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (weak, nonatomic) id <DetailTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) TaskObject *task;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UILabel *detailViewTaskTitle;
@property (strong, nonatomic) IBOutlet UILabel *detailViewTaskDate;

@property (strong, nonatomic) IBOutlet UILabel *detailTextView;

@end
