//
//  ViewController.m
//  zad3iOS
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];
    locationManager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc] init];
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(motion == UIEventSubtypeMotionShake){
        [self showShakeDetectedAlert];
    }
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

-(IBAction) showShakeDetectedAlert {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Shake gesture detected" message:@"Do you want to change color?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if([[_label text] isEqualToString:@"Jasne tło"]) {
            [_label setText:@"Ciemne tło"];
            self.view.backgroundColor = [UIColor colorWithRed:0.23 green:0.21 blue:0.21 alpha:1.0];

        } else {
            [_label setText:@"Jasne tło"];
            self.view.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        }
    }];
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"Background color didn't changed.");
    }];
    
    [controller addAction:yesButton];
    [controller addAction:noButton];
    [self presentViewController:controller animated:YES completion:nil];
}

-(IBAction) tapGesture:(UITapGestureRecognizer *) sender{
    _gestureLabel.text = @"Tap detected";
}

-(IBAction) pinchGesture:(UIPinchGestureRecognizer *) sender{
    _gestureLabel.text = @"Pinch detected";
}

-(IBAction) swipeGesture:(UITapGestureRecognizer *) sender{
    _gestureLabel.text = @"Swipe detected";
}

-(IBAction) longPressGesture:(UILongPressGestureRecognizer *) sender{
    _gestureLabel.text = @"Long press detected";
}

-(void)getCurrentLocation:(id)sender{
    locationManager.delegate = self;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to get localization" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *ac) {
        [self.view setBackgroundColor: UIColor.blueColor];
    }];
    
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    
    if(location != nil) {
        _latitudeText.text = [NSString stringWithFormat:@"%.8f", location.coordinate.latitude];
        _longtitudeText.text = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
    }
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark*> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            self.addressText.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}
@end
