//
//  TaskObject.m
//  Overdue Task Project
//
//  Created by Brian Starr on 10/15/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import "TaskObject.h"

@implementation TaskObject

-(id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self){
        self.taskName = data[TITLE];
        self.taskDescription = data[DESCRIPTION];
        self.taskDate = data[DATE];
        self.isCompleted = [data[COMPLETION] boolValue];
    }
    
    return self;
    
}

-(id)init{
    self = [self initWithData:nil];
    return self;
}


@end
