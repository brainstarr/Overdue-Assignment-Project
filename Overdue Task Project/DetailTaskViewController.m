//
//  DetailTaskViewController.m
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.detailViewTaskTitle.text = self.task.taskName;
    self.detailTextView.text = self.task.taskDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"mm-dd-yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.task.taskDate];
    
    self.detailViewTaskDate.text = stringFromDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditVC" sender:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
