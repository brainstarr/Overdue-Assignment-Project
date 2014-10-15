//
//  TaskObject.h
//  Overdue Task Project
//
//  Created by Brian Starr on 10/15/14.
//  Copyright (c) 2014 Brian Starr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskObject : NSObject

@property (strong, nonatomic) NSString *taskName;
@property (strong, nonatomic) NSString *taskDescription;
@property (strong, nonatomic) NSDate *taskDate;
@property (nonatomic) BOOL isCompleted;

-(id)initWithData:(NSDictionary *)data;

@end
