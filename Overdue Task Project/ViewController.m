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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists)
    {
        TaskObject *taskObject = [self taskObjectForDictionary:dictionary];
        [self.tasks addObject:taskObject];
    }
}

#pragma mark - segue method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:nil];
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
}


#pragma mark - add task view controller delegate

-(void)didCreateTask:(TaskObject *)task
{
    [self.tasks addObject:task];
    
    //NSLog(@"%@", task.taskName);
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    
    if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - helper methods

-(NSDictionary *)taskObjectAsPropertyList:(TaskObject *)taskObject
{
    NSDictionary *dictionary = @{TITLE : taskObject.taskName, DESCRIPTION : taskObject.taskDescription, DATE : taskObject.taskDate, COMPLETION : @(taskObject.isCompleted)};
    
    return dictionary;
}

-(NSMutableArray *)tasks
{
    if (!_tasks){
        _tasks = [[NSMutableArray alloc]init];
    }
    
    return _tasks;
}

-(TaskObject *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    TaskObject *task = [[TaskObject alloc]initWithData:dictionary];
    
    return task;
}

//-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
//{
//    if ([date timeIntervalSince1970] > [toDate timeIntervalSince1970]) {
//        return YES;
//    }
//    else{
//        return NO;
//    }
//}

#pragma Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Cell configuration
    TaskObject *task = self.tasks[indexPath.row];
    cell.textLabel.text = task.taskName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:@"MM-dd-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:task.taskDate];
    cell.detailTextLabel.text = stringFromDate;
    
    if ([task.taskDate timeIntervalSince1970] < [[NSDate date] timeIntervalSince1970])
    {
        cell.backgroundColor = [UIColor redColor];
    }
    else {
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell; 
}


@end
