//
//  ViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/11/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, addTaskViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *tasks;

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender;

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;

@end

