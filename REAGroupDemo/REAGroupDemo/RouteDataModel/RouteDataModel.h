
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RouteDataModel : NSObject


@property (nonatomic) NSString *HasDisruption;
@property (nonatomic) NSString *PredictedArrivalDateTime;
@property (nonatomic) NSString *RouteNo;
@property (nonatomic) NSString *VehicleNo;

+ (id)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
