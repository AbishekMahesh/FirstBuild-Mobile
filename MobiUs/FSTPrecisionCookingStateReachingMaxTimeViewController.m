//
//  FSTPrecisionCookingStateReachingMaxTimeViewController.m
//  
//
//  Created by John Nolan on 8/6/15.
//
//

#import "FSTPrecisionCookingStateReachingMaxTimeViewController.h"
#import "FSTPrecisionCookingStateReachingMaxTimeLayer.h"

@interface FSTPrecisionCookingStateReachingMaxTimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *italicTimeLabel;

@end

@implementation FSTPrecisionCookingStateReachingMaxTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView.progressLayer = [[FSTPrecisionCookingStateReachingMaxTimeLayer alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatePercent {
    [super updatePercent];
    self.progressView.progressLayer.percent = [self calculatePercent:self.elapsedTime toTime:self.targetTime];
}

-(void) updateLabels {
    [super updateLabels];
    
    UIFont* smallFont = [UIFont fontWithName:@"FSEmeric-Regular" size:22.0];
    NSDictionary* smallFontDict = [NSDictionary dictionaryWithObject:smallFont forKey:NSFontAttributeName];
    
    UIFont* boldFont = [UIFont fontWithName:@"FSEmeric-SemiBold" size:24.0];
    NSDictionary* boldFontDict = [NSDictionary dictionaryWithObject:boldFont forKey:NSFontAttributeName];
    
    UIFont* italicFont = [UIFont fontWithName:@"FSEmeric-CoreItalic" size:24.0];
    NSDictionary* italicFontDict = [NSDictionary dictionaryWithObject:italicFont forKey:NSFontAttributeName];
    
    NSMutableAttributedString* maxTimeNotice = [[NSMutableAttributedString alloc] initWithString:@"Food can stay in until" attributes:italicFontDict]; // string reporting the date food should be taken out

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate* timeComplete;
    
    double timeRemaining = self.targetTime - self.elapsedTime; // the min time required (set through a delegate method) minus the elapsed time to find when the stage will end
    //int hour = timeRemaining / 60;
    //int minutes = fmod(timeRemaining, 60.0);
    
    timeComplete = [[NSDate date] dateByAddingTimeInterval:timeRemaining*60];
    [dateFormatter setDateFormat:@"hh:mm a"];
    [maxTimeNotice appendAttributedString:[[NSAttributedString alloc] initWithString: [dateFormatter stringFromDate:timeComplete] attributes:boldFontDict]];
    
    [self.italicTimeLabel setAttributedText:maxTimeNotice];
    
    double currentTemperature = self.currentTemp;
    NSMutableAttributedString *currentTempString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%0.0f %@", currentTemperature, @"\u00b0 F"] attributes: smallFontDict]; // with degrees fareinheit appended
    [self.currentTempLabel setAttributedText:currentTempString];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
