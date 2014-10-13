//
//  ViewController.m
//  Overdue Task Project
//
//  Created by Brian Starr on 10/11/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib. 
    NSLog(@"%@", self.textView.text );
    //NSLog(@"%@", USER_NAME);
    
    self.textView.delegate = self;
    NSMutableArray *myMutableArray = [@[@1, @"Hello", @"Goodbye"]mutableCopy];
    [myMutableArray insertObject:@"This should be first" atIndex:0];
    [myMutableArray removeObjectAtIndex:0];
    NSLog(@"%@", myMutableArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self.textView resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
}

- (IBAction)processDateButtonPressed:(UIButton *)sender
{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:@"mm-dd-yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:date];
    NSLog(@"%@", stringFromDate);
    NSLog(@"%@", [NSDate date]);
}
@end
