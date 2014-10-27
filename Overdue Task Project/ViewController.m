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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - segue method

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]])
    {
        DetailTaskViewController *detailVC = segue.destinationViewController;
        
        NSIndexPath *path = sender;
        
        TaskObject *selectedTask = self.tasks[path.row];
        
        detailVC.task = selectedTask;
        detailVC.delegate = self;
    }
}

- (IBAction)addTaskBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskVC" sender:nil];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailVC" sender:indexPath];
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
    if (self.tableView.editing == YES) [self.tableView setEditing:NO];
    else [self.tableView setEditing:YES];
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

#pragma mark - DetailVC Delegate Methods

-(void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
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

-(void)updateCompletionOfTask:(TaskObject *)task forIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_OBJECTS_KEY]mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) return YES;
    else return NO;
}

-(void)saveTasks
{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    for (int x = 0; x < [self.tasks count]; x++) {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:self.tasks[x]]];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

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
    [formatter setDateStyle:@"mm-dd-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:task.taskDate];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverdue = [self isDateGreaterThanDate:[NSDate date] and:task.taskDate];
    
    if (task.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverdue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskObject *task = self.tasks[indexPath.row];
    
    [self updateCompletionOfTask:task forIndexPath:indexPath];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [self.tasks removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskData = [[NSMutableArray alloc]init];
        
        for (TaskObject *task in self.tasks){
            [newTaskData addObject:[self taskObjectAsPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:newTaskData forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    TaskObject *taskObject = self.tasks[sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:taskObject atIndex:sourceIndexPath.row];
    [self saveTasks];
}


@end






