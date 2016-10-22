//
//  BaiDuMap_drawRoute.m
//  IOVS
//
//  Created by 齐云 on 2016/10/11.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "BaiDuMap_drawRoute.h"

@interface BaiDuMap_drawRoute()<BMKRouteSearchDelegate>
/**
 *  路径
 */
@property (nonatomic, strong) BMKRouteSearch *routeSearch;

@property (nonatomic, strong) BMKMapView *_mapView;

@end

@implementation BaiDuMap_drawRoute

-(instancetype)initWithMap:(BMKMapView *)mapView {
    if (self == [super init]) {
        self._mapView = mapView;
    }
    return self;
}



-(void)routePlaning:(CLLocationCoordinate2D)originCoor distrubution:(CLLocationCoordinate2D)distrubutionCoor {

    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = originCoor;
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    end.pt = distrubutionCoor;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc] init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [self.routeSearch drivingSearch:drivingRouteSearchOption];
    if(flag) {
        NSLog(@"驾驶路线检索发送成功");
    } else {
        NSLog(@"驾驶路线检索发送失败");
    }
    
}

#pragma mark - BMKRouteSearchDelegate
//返回驾乘路线
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error{
    NSArray* array = [NSArray arrayWithArray:self._mapView.annotations];
    [self._mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:self._mapView.overlays];
    [self._mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.planRoute) {
            self.planRoute();
        }
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
//                CollectAnnotation* item = [[CollectAnnotation alloc]init];
//                item.coordinate = plan.starting.location;
//                item.title = @"起点";
//                item.type = 0;
//                [self._mapView addAnnotation:item]; // 添加起点标注
            }else if(i==size-1){
                CollectAnnotation* item = [[CollectAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self._mapView addAnnotation:item]; // 添加起点标注
            }
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                CollectAnnotation* item = [[CollectAnnotation alloc]init];
                item = [[CollectAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [self._mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint temppoints[planPointCounts];
        //        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [self._mapView addOverlay:polyLine]; // 添加路线overlay
        //        delete []temppoints;
        //        temppoints[planPointCounts];
        
        [self mapView:self._mapView FitPolyLine:polyLine];
    }
    
    
}


//地图根据polyline缩放
-(void)mapView:(BMKMapView *)mapView FitPolyLine:(BMKPolyline *)polyLine{
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [mapView setVisibleMapRect:rect];
    mapView.zoomLevel = mapView.zoomLevel - 0.5;
}



-(BMKRouteSearch *)routeSearch{
    if (_routeSearch == nil) {
        _routeSearch = [[BMKRouteSearch alloc]init];
        _routeSearch.delegate = self;
    }
    return _routeSearch;
}




@end
