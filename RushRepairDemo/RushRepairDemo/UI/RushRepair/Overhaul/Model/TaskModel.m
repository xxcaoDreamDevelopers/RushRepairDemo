//
//  TaskModel.m
//  IOVS
//
//  Created by mac on 16/10/17.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskModel.h"

@implementation TaskModel


-(void)configDataArr:(NSDictionary *)dataDic {

    self.address = dataDic[@"address"];
    self.taskSource = [dataDic[@"taskSource"] integerValue];
    self.faultContent = dataDic[@"faultContent"];
    self.taskType = [dataDic[@"taskType"] integerValue];
    self.deviceType = [dataDic[@"deviceType"] integerValue];
    self.distributeTime = dataDic[@"distributeTime"];
    self.taskCycle = dataDic[@"taskCycle"];
    self.repairMan = dataDic[@"repairMan"];
    self.taskNumber = dataDic[@"taskNumber"];
    self.tourCycle = dataDic[@"tourCycle"];
    self.tourFrequence = dataDic[@"tourFrequence"];
    self.startTime = dataDic[@"startTime"];
    self.endTime = dataDic[@"endTime"];
    self.advice = dataDic[@"advice"];
    self.taskItemType = [dataDic[@"taskItemType"] integerValue];
    self.latitude = [dataDic[@"latitude"] doubleValue];
    self.longitude = [dataDic[@"longitude"] doubleValue];
    
}



@end
