
#import "RoutesController.h"


@implementation RoutesController

- (void)getRoutesByRouteID:(NSString *)stopId andToken:(NSString *)token WithSuccess:(void (^)(NSArray<RouteModel*>* routes))complete failure:(void (^)(NSError *error))failure{
    
    [APIClient.shared getRoutesByRouteID:stopId andToken:token WithSuccess:^(NSArray<RouteDataModel *> * _Nonnull routes) {
      
        NSMutableArray<RouteModel*>* routeList = [NSMutableArray new];

        for (int i=0; i<routes.count; i++) {
            RouteDataModel *routeDataModel  = (RouteDataModel* )routes[i];
            RouteModel *rModel              = [RouteModel new];
            rModel.HasDisruption            = routeDataModel.HasDisruption;
            rModel.PredictedArrivalDateTime = [self getDateFromJSON:routeDataModel.PredictedArrivalDateTime];
            rModel.RouteNo                  = routeDataModel.RouteNo;
            rModel.VehicleNo                = routeDataModel.VehicleNo;
            [routeList addObject:rModel];
        }
        
        complete(routeList);
    } failure:^(NSError * _Nonnull error) {
        failure(error);    
    }];
    
}
          
- (void)getTokenWithSuccess:(void (^)(BOOL success, id result))complete
                    failure:(void (^)(NSError *error))failure{
    
    [APIClient.shared getTokenWithSuccess:^(BOOL success, id  _Nonnull result) {
        complete (YES, result);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

- (NSString *)getDateFromJSON:(NSString *)dateString{
    // Expect date in this format "/Date(1268123281843)/"
    unsigned long startPos = [dateString rangeOfString:@"("].location + 1;
    unsigned long endPos = [dateString rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos,endPos-startPos);
    unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];

    NSTimeInterval interval = milliseconds/1000;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//    NSLog(@"%@", [formatter stringFromDate:date]);
    return [formatter stringFromDate:date];
 //   return [NSDate dateWithTimeIntervalSince1970:interval];
    
}
@end
