
#define KNorth @"4055"
#define KSouth @"4155"

#define kNorthLabel @"North"
#define kSouthLabel @"South"

#import "ViewController.h"
#import "RoutesController.h"
#import "ItemsCell.h"
#import "RouteModel.h"
#import "MBProgressHUD.h"


@interface ViewController ()

@end

NSArray *NorthRoutes;
NSArray *SouthRoutes;
NSDictionary   *tableViewData;
NSArray        *keys;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup tableview
    
    [ self.RoutesTableView registerNib:[UINib nibWithNibName:[ItemsCell identifier] bundle:nil] forCellReuseIdentifier:[ItemsCell identifier]];
    self.RoutesTableView.delegate   = self;
    self.RoutesTableView.dataSource = self;
    self.RoutesTableView.estimatedRowHeight = 50;
    self.RoutesTableView.rowHeight = UITableViewAutomaticDimension;
    keys = @[kNorthLabel, kSouthLabel];
    [self loadData];
    
    //auto reload after 5mins
    [NSTimer scheduledTimerWithTimeInterval:300.0 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    
    RoutesController *rController = [RoutesController new];
    __weak typeof(self) weak_self = self;
    //
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"Loading routes...";
    //

    [rController getTokenWithSuccess:^(BOOL success, id  _Nonnull result) {
        NSString *token = result;
        [rController getRoutesByRouteID:KNorth andToken:token WithSuccess:^(NSArray<RouteModel *> * _Nonnull routes) {
            //list of North Routes
            NorthRoutes = routes;
            [rController getRoutesByRouteID:KSouth andToken:token WithSuccess:^(NSArray<RouteModel *> * _Nonnull routes) {
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    //list of South Routes
                    SouthRoutes = routes;
                    tableViewData = @{@"North": NorthRoutes,  @"South": SouthRoutes};
                    [hud hideAnimated:YES];
                    [weak_self.RoutesTableView reloadData];
                });
            } failure:^(NSError * _Nonnull error) {
                [hud hideAnimated:YES];
                NSLog(@"%@",[error localizedDescription]);
            }];
            
        } failure:^(NSError * _Nonnull error) {
            [hud hideAnimated:YES];
            NSLog(@"%@",[error localizedDescription]);
        }];

    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
    
}
//tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section ==0) return NorthRoutes.count;
    return SouthRoutes.count;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *headerTitle = keys[section];
   
    return headerTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemsCell *cell = (ItemsCell *)[tableView dequeueReusableCellWithIdentifier:[ItemsCell identifier]];
    if (cell) {
        NSString *key = keys[indexPath.section];
        NSArray *models = [NSArray new];
        models = (NSArray *)[tableViewData objectForKey:key];
        RouteModel *model = [RouteModel new];
        model = (RouteModel*)models[indexPath.row];
        [cell updateWithItem:model.PredictedArrivalDateTime :model.RouteNo];
            return cell;
    }

    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (IBAction)Clear:(id)sender {
    NorthRoutes = [NSArray new];
    SouthRoutes = [NSArray new];
    
    tableViewData = @{@"North": NorthRoutes,  @"South": SouthRoutes};
    [self.RoutesTableView reloadData];
}

- (IBAction)reLoad:(id)sender {
    
    [self loadData];
}


@end
