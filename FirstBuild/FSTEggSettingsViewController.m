//
//  FSTEggSettingsViewController.m
//  FirstBuild
//
//  Created by Myles Caley on 12/17/15.
//  Copyright © 2015 FirstBuild. All rights reserved.
//

#import "FSTEggSettingsViewController.h"
#import "FSTEggWholeSousVideRecipe.h"
#import "MobiNavigationController.h"
#import "FSTRevealViewController.h"
#import "FSTReadyToReachTemperatureViewController.h"


@interface FSTEggSettingsViewController ()

@end

@implementation FSTEggSettingsViewController
{
    FSTEggWholeSousVideRecipe* _eggRecipe;
    IBOutlet UIPickerView *pickerView;
}

-(void)viewWillAppear:(BOOL)animated
{
    MobiNavigationController* controller = (MobiNavigationController*)self.navigationController;
    [controller setHeaderText:self.recipe.name withFrameRect:CGRectMake(0, 0, 120, 30)];
    self.continueTapGestureRecognizer.enabled = YES;
    [self.recipe addStage];
    [self getDataForDonenessIndex:3];
    _eggRecipe = [FSTEggWholeSousVideRecipe new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabels
{
    //temperature label
    UIFont *boldFont = [UIFont fontWithName:@"FSEmeric-SemiBold" size:17.0];
    NSDictionary *boldFontDict = [NSDictionary dictionaryWithObject: boldFont forKey:NSFontAttributeName];
    
    UIFont *labelFont = [UIFont fontWithName:@"FSEmeric-Thin" size:14.0];
    NSDictionary *labelFontDict = [NSDictionary dictionaryWithObject: labelFont forKey:NSFontAttributeName];

    FSTParagonCookingStage* stage = self.recipe.paragonCookingStages[0];
    
    // min time values
    
    NSNumber* hour = [NSNumber numberWithInt:[stage.cookTimeMinimum intValue]/60];
    NSNumber* minute = [NSNumber numberWithInt:[stage.cookTimeMinimum intValue]%60];
    
    // max time values
    NSNumber* maxHour = [NSNumber numberWithInt:[stage.cookTimeMaximum intValue]/60]  ;
    NSNumber* maxMinute = [NSNumber numberWithInt:[stage.cookTimeMaximum intValue]%60]   ;
    
    // min time labels
    NSMutableAttributedString *hourString = [[NSMutableAttributedString alloc] initWithString:[hour stringValue] attributes: boldFontDict];
    NSMutableAttributedString *minuteString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"%02ld",(long)[minute integerValue]] attributes: boldFontDict];
    NSMutableAttributedString *hourLabel = [[NSMutableAttributedString alloc] initWithString:@":" attributes: labelFontDict];
    
    // max time labels
    NSMutableAttributedString *maxHourString = [[NSMutableAttributedString alloc] initWithString:[maxHour stringValue] attributes: boldFontDict];
    NSMutableAttributedString *maxMinuteString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"%02ld",(long)[maxMinute integerValue]] attributes: boldFontDict];
    NSMutableAttributedString *maxHourLabel = [[NSMutableAttributedString alloc] initWithString:@":" attributes: labelFontDict];
    
    // temperature label
    NSMutableAttributedString *temperature = [[NSMutableAttributedString alloc] initWithString:[stage.targetTemperature stringValue] attributes: boldFontDict];
    NSMutableAttributedString *degreeString = [[NSMutableAttributedString alloc] initWithString:@"\u00b0" attributes:boldFontDict];
    NSMutableAttributedString *temperatureLabel = [[NSMutableAttributedString alloc] initWithString:@" F" attributes: boldFontDict];
    
    // create the strings
    [hourString appendAttributedString:hourLabel];
    [hourString appendAttributedString:minuteString];
    [maxHourString appendAttributedString:maxHourLabel];
    [maxHourString appendAttributedString:maxMinuteString];
    [temperature appendAttributedString:degreeString];
    [temperature appendAttributedString:temperatureLabel];
    
    // set the strings on the label
    [self.beefSettingsLabel setAttributedText:hourString];
    [self.maxBeefSettingsLabel setAttributedText:maxHourString]; // hour string with one additional hour
    [self.tempSettingsLabel setAttributedText:temperature];
}


- (IBAction)continueTapGesture:(id)sender {
    
    self.continueTapGestureRecognizer.enabled = NO;
    
    if (![self.currentParagon sendRecipeToCooktop:self.recipe])
    {
        self.continueTapGestureRecognizer.enabled = YES;
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[FSTReadyToReachTemperatureViewController class]])
    {
        ((FSTReadyToReachTemperatureViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
    }
}

- (IBAction)menuToggleTapped:(id)sender {
    [self.revealViewController rightRevealToggle:self.currentParagon];
}

#pragma mark - <FSTParagonDelegate>
- (void)cookConfigurationSet:(NSError *)error
{
    if (error)
    {
        self.continueTapGestureRecognizer.enabled = YES;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                 message:@"The cooktop must not currently be cooking. Try pressing the Stop button and changing to the Rapid or Gentle Precise cooking mode."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    [self performSegueWithIdentifier:@"seguePreheat" sender:self];
}

-(void)pendingRecipeCancelled
{
    self.continueTapGestureRecognizer.enabled = YES;
}

- (IBAction)donenessChanged:(id)sender
{
   [self getDataForDonenessIndex:((UISlider*)sender).value];
    
}

-(void)getDataForDonenessIndex: (uint8_t)index
{
    FSTParagonCookingStage* stage = self.recipe.paragonCookingStages[0];
    
    switch (index)
    {
        case 1:
            self.donenessLabel.text = @"raw (pasteurized)";
            stage.cookTimeMinimum = @80;
            stage.cookTimeMaximum = @120;
            stage.targetTemperature = @135;
            break;
        case 2:
            self.donenessLabel.text = @"slightly firm white, barely thickened yolk";
            stage.cookTimeMinimum = @40;
            stage.cookTimeMaximum = @60;
            stage.targetTemperature = @144;
            break;
        case 3:
            self.donenessLabel.text = @"mostly firm white, creamy yolk";
            stage.cookTimeMinimum = @40;
            stage.cookTimeMaximum = @60;
            stage.targetTemperature = @148;
            break;
        case 4:
            self.donenessLabel.text = @"firm white, runny yolk";
            stage.cookTimeMinimum = @13;
            stage.cookTimeMaximum = @15;
            stage.targetTemperature = @167;
            break;
        case 5:
            self.donenessLabel.text = @"firm white, firm yolk";
            stage.cookTimeMinimum = @45;
            stage.cookTimeMaximum = @60;
            stage.targetTemperature = @165;
            break;
        
    }
    [self updateLabels];
}


@end
