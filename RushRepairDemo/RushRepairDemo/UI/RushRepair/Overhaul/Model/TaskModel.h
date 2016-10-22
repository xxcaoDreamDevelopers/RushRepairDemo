//
//  TaskModel.h
//  IOVS
//
//  Created by mac on 16/10/17.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskModel : NSObject

/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 工单来源   
 */
@property (nonatomic, assign) NSInteger taskSource;

/**
 失败原因
 */
@property (nonatomic, copy) NSString *faultContent;

/**
 工单格式
 */
@property (nonatomic, assign) NSInteger taskType;

/**
 设备类型
 */
@property (nonatomic, assign) NSInteger deviceType;

/**
 派发时间
 */
@property (nonatomic, copy) NSString *distributeTime;

/**
 工单周期
 */
@property (nonatomic, copy) NSString *taskCycle;

/**
 报修人
 */
@property (nonatomic, copy) NSString *repairMan;

/**
 工单编号
 */
@property (nonatomic, copy) NSString *taskNumber;

/**
 巡视周期
 */
@property (nonatomic, copy) NSString *tourCycle;

/**
 巡视频率
 */
@property (nonatomic, copy) NSString *tourFrequence;

/**
 巡视周期开启时间
 */
@property (nonatomic, copy) NSString *startTime;

/**
 巡视周期结束原因
 */
@property (nonatomic, copy) NSString *endTime;

/**
 处理意见
 */
@property (nonatomic, copy) NSString *advice;

/**
 工单种类
 */
@property (nonatomic, assign) NSUInteger taskItemType;


/**
 纬度
 */
@property (nonatomic ,assign)double latitude;


/**
 经度
 */
@property (nonatomic ,assign)double longitude;




-(void)configDataArr:(NSDictionary *)dataDic;

@end
