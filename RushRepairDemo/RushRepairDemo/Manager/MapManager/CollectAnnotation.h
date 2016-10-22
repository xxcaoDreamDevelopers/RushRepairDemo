//
//  CollectAnnotation.h
//  MPP
//
//  Created by UPBest_iOS_1 on 16/7/12.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface CollectAnnotation : BMKPointAnnotation
/**
 *  工单序号
 */
@property (nonatomic, assign) int taskNumber;

/**
 *  <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
 */
@property (nonatomic, assign) int type;

@property (nonatomic, assign) int degree;

/**
 *  设备类型 01 专变终端  02 I型集中器 03 II型集中器  04 采集器  05 电能表
 */
@property (nonatomic, assign) NSString* devType;

/**
 *  纬度
 */
@property (nonatomic, assign) double latitude;

/**
 *  经度
 */
@property (nonatomic, assign) double longitude;


/**
 *  工单状态
 */
@property (nonatomic, copy) NSString *state;

/**
 *  工单id
 */
@property (nonatomic, copy) NSString *taskId;

/**
 *  设备条码
 */
@property (nonatomic, copy) NSString *devBarCode;

/**
 *  终端条码
 */
@property (nonatomic, copy) NSString *terBarCode;


@end
