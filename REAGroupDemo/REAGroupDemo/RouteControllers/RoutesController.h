//

#import <Foundation/Foundation.h>
#import "APIClient.h"
#import "RoutesDataModel.h"
#import "RouteModel.h"
#import "RouteDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoutesController : NSObject


- (void)getRoutesByRouteID:(NSString *)stopId andToken:(NSString *)token WithSuccess:(void (^)(NSArray<RouteModel*>* routes))complete failure:(void (^)(NSError *error))failure;


- (void)getTokenWithSuccess:(void (^)(BOOL success, id result))complete
                 failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
