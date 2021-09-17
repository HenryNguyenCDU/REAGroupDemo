
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn_clear;
@property (weak, nonatomic) IBOutlet UIButton *btn_load;

@property (weak, nonatomic) IBOutlet UITableView *RoutesTableView;
@end

