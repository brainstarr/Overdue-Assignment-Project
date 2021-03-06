//
//  EditTaskViewController.m
//  Overdue Task Project
//
//  Created by Brian Starr on 10/13/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.editTitleTextField.text = self.task.taskName;
    self.editDescriptionTextField.text = self.task.taskDescription;
    self.editTaskDatePicker.date = self.task.taskDate;
    
    self.editTitleTextField.delegate = self;
    self.editDescriptionTextField.delegate = self;
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

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    [self updateTask];
    [self.delegate didUpdateTask];
}


#pragma Helper Methods
-(void)updateTask
{
    self.task.taskName = self.editTitleTextField.text;
    self.task.taskDescription = self.editDescriptionTextField.text;
    self.task.taskDate = self.editTaskDatePicker.date;
}

#pragma mark - UITextfield/UITextView Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.editTitleTextField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self.editDescriptionTextField resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
