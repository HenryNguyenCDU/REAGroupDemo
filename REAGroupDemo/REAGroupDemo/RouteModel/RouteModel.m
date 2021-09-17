
#import "RouteModel.h"


@interface RouteModel()

@end

@implementation RouteModel

- (id)init{
    
    if (self = [super init]) {
        
        self.HasDisruption           = @"";
        self.PredictedArrivalDateTime   = @"";
        self.RouteNo    = @"";
        self.VehicleNo = @"";

    }
    return self;
}


@end
