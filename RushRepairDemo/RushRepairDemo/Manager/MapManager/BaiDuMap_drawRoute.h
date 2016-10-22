//
//  BaiDuMap_drawRoute.h
//  IOVS
//
//  Created by 齐云 on 2016/10/11.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "CollectAnnotation.h"


@interface BaiDuMap_drawRoute : NSObject

-(instancetype)initWithMap:(BMKMapView *)mapView;


-(void)routePlaning:(CLLocationCoordinate2D)originCoor distrubution:(CLLocationCoordinate2D)distrubutionCoor;


@property (nonatomic, copy) void(^planRoute)();


@end
