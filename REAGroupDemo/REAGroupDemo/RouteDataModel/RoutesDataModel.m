
#import "RoutesDataModel.h"

@implementation RoutesDataModel


+ (id)initWithDictionary:(NSMutableDictionary*)dictionary {
    
    RoutesDataModel *routes = [[RoutesDataModel alloc] init];

        NSMutableDictionary *list = [dictionary valueForKey:@"responseObject"];

        NSMutableArray<RouteDataModel *>* arrayRoutes = [NSMutableArray array];

        for (NSDictionary *routeDictionary in list) {
            RouteDataModel *routeDataModel = [RouteDataModel initWithDictionary:routeDictionary];
            [arrayRoutes addObject:routeDataModel];
        }

    routes.routes = arrayRoutes;

    return routes;
}

@end
