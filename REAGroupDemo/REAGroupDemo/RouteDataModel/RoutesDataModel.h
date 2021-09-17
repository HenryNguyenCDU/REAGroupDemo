
#import <Foundation/Foundation.h>
#import "RouteDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoutesDataModel : NSObject


@property (nonatomic) NSArray<RouteDataModel*> *routes;

+ (id)initWithDictionary:(NSMutableDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
