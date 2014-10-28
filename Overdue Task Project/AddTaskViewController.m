//
//  AddTaskViewController.m
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addTaskTextField.delegate = self;
    self.addTaskNameField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(TaskObject *)returnNewTaskObject
{
    TaskObject *task = [[TaskObject alloc]init];
    task.taskName = self.addTaskNameField.text;
    task.taskDescription = self.addTaskTextField.text;
    task.taskDate = self.addTaskDatePicker.date;
    task.isCompleted = NO;
    
    return task;
}

- (IBAction)addTaskButtonPressed:(UIButton *)sender {
    [self.delegate didCreateTask:[self returnNewTaskObject]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    [self.delegate didCancel];
}

#pragma mark - UITextfield/UITextView Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.addTaskNameField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self.addTaskTextField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
