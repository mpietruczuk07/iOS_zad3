//
//  ViewController.h
//  zad3iOS
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, weak) IBOutlet UILabel *gestureLabel;

-(IBAction) tapGesture:(UITapGestureRecognizer *) sender;
-(IBAction) pinchGesture:(UIPinchGestureRecognizer *) sender;
-(IBAction) longPressGesture:(UILongPressGestureRecognizer *) sender;

-(IBAction) swipeGesture:(UISwipeActionsConfiguration *) sender;

@property (weak, nonatomic) IBOutlet UILabel *latitudeText;

@property (weak, nonatomic) IBOutlet UILabel *longtitudeText;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

-(IBAction)getCurrentLocation:(id)sender;




@end

