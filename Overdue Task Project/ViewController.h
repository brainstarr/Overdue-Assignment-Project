//
//  ViewController.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/11/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addTaskButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *reorderButton;

@end

