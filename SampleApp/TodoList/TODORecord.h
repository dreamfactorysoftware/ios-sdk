//
//  TODORecord.h
//  TodoList
//
//  Created by Sachin Soni on 2/28/14.
//  Copyright (c) 2014 sachin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TODORecord : NSObject

@property(nonatomic,retain)NSNumber *record_Id;
@property(nonatomic,retain)NSString *record_Task;
@property(nonatomic,retain)NSString *record_Complete;

@end
