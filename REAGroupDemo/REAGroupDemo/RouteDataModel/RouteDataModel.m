
#import "RouteDataModel.h"

@interface RouteDataModel()

@end

@implementation RouteDataModel

static NSString *kHasDisruption = @"HasDisruption";
static NSString *kPredictedArrivalDateTim = @"PredictedArrivalDateTime";
static NSString *kRouteNo = @"RouteNo";
static NSString *kVehicleNo = @"VehicleNo";


+ (id)initWithDictionary:(NSDictionary *)dictionary {
    
    RouteDataModel *route = [[RouteDataModel alloc] init];

    if (self) {
        
        if (dictionary[kHasDisruption] != [NSNull null]) {
            route.HasDisruption = [NSString stringWithFormat:@"%@", dictionary[kHasDisruption]];
        }

        if (dictionary[kPredictedArrivalDateTim] != [NSNull null]) {
            route.PredictedArrivalDateTime =   [NSString stringWithFormat:@"%@", dictionary[kPredictedArrivalDateTim]];
        }
        if (dictionary[kRouteNo] != [NSNull null]) {
            route.RouteNo =  [NSString stringWithFormat:@"%@", dictionary[kRouteNo]];
        }
        if (dictionary[kVehicleNo] != [NSNull null]) {
            route.VehicleNo = [NSString stringWithFormat:@"%@", dictionary[kVehicleNo]];
        }
        

    }

    return route;
}

@end
