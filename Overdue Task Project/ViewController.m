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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didCreateTask:(TaskObject *)task
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray *)tasks
{
    if (!_tasks){
        _tasks = [[NSMutableArray alloc]init];
    }
    
    return _tasks;
}

@end
