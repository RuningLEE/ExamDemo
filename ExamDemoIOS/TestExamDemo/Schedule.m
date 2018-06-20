//
//  Schedule.m
//  ExamDemo
//
//  Created by George She on 2018/6/8.
//  Copyright © 2018年 CMRead. All rights reserved.
//

#import "Schedule.h"
#import "ReturnCodeKeys.h"
#import "ServeNode.h"
#import "TaskInfo.h"

@interface Schedule()

@property (nonatomic, copy) NSMutableArray *nodeArray;//
@property (nonatomic, copy) NSMutableArray *taskArray;//
@property (nonatomic, assign) int maxCount;//最大并发

@end
@implementation Schedule
-(int)clean{
    _nodeArray = [NSMutableArray new];
    _taskArray = [NSMutableArray new];
    _maxCount = 50;

    return kE001;
}

-(int)registerNode:(int)nodeId{
   
    if(nodeId <=0)
    {
        return kE004;
    }
    for(int i =0;i<_nodeArray.count;i++)
    {
        ServeNode *node = _nodeArray[i];
        if(nodeId == node.nodeId)
        {
            return kE005;
        }
        
    }
    
    ServeNode *renode = [[ServeNode alloc]init];
    renode.nodeId = nodeId;
    [_nodeArray addObject:renode];
    return kE003;
}

-(int)unregisterNode:(int)nodeId{
    if(nodeId <=0)
    {
        return kE004;
    }
    NSMutableArray *nodeIdArray = [NSMutableArray new];
    for(int i = 0;i<_nodeArray.count;i++)
    {
        int tempt;
        NSString *string = [NSString string];
        tempt = [_nodeArray[i] nodeId];
        string = [NSString stringWithFormat:@"%d",tempt];
        [nodeIdArray addObject:string];
    }
    NSString *strNode = [NSString stringWithFormat:@"%d",nodeId];
    if(![nodeIdArray containsObject:strNode])
    {
        return kE007;
    }
    [_nodeArray removeAllObjects];
    
    return kE006;
}

-(int)addTask:(int)taskId withConsumption:(int)consumption{
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    if(taskId <=0)
    {
        return kE009;
    }
    for (int i =0 ; i< _taskArray.count; i++) {
        TaskInfo *task = _taskArray[i];
        if(taskId == task.taskId)
        {
            return kE010;
        }
    }
    
    TaskInfo *newTask = [[TaskInfo alloc]init];
    newTask.taskId = taskId;
    [_taskArray addObject:newTask];
    return kE008;

}

-(int)deleteTask:(int)taskId{
    
    if(taskId <= 0)
    {
        return kE009;
    }
    
    NSMutableArray *nodeIdArray = [NSMutableArray new];
    for(int i = 0;i<_taskArray.count;i++)
    {
        int tempt;
        NSString *string = [NSString string];
        tempt = [_taskArray[i] taskId];
        string = [NSString stringWithFormat:@"%d",tempt];
        [nodeIdArray addObject:string];
    }
    NSString *strNode = [NSString stringWithFormat:@"%d",taskId];
    if(![nodeIdArray containsObject:strNode])
    {
        return kE012;
    }
    [_taskArray removeAllObjects];
    return kE011;
}

-(int)scheduleTask:(int)threshold{
    return kE013;
}

-(int)queryTaskStatus:(NSMutableArray<TaskInfo *> *)tasks{
    if([tasks isEqual:[NSNull null]])
    {
        return kE016;
    }
    return kE015;
}
@end
