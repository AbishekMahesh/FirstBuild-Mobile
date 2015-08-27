//
//  FSTStageSettingsViewController.m
//  FirstBuild
//
//  Created by John Nolan on 8/26/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTStageSettingsViewController.h"

@interface FSTStageSettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timePickerHeight;

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *tempPicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tempPickerHeight;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *speedPicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speedPickerHeight;

@property (weak, nonatomic) IBOutlet UISwitch *autoTransitionSwitch;

@property (weak, nonatomic) IBOutlet UITextView *directionsTextView;

@end

@implementation FSTStageSettingsViewController
{
    
    FSTStagePickerManager* pickerManager; // hopefully this will work fine just without the max time added in
    
}
//TODO rename
typedef enum stageVariableSelections {
    TIME,
    TEMP,
    SPEED,
    NONE
} StageVariableSelection;
// keeps track of the open picker views

StageVariableSelection _selection;

CGFloat const SEL_HEIGHT_S = 70;

- (void)viewDidLoad {
    [super viewDidLoad];
    pickerManager = [[FSTStagePickerManager alloc] init]; // just want this temporarily to initialize the data
    pickerManager.minPicker = self.timePicker;
    self.timePicker.delegate = pickerManager;
    self.timePicker.dataSource = pickerManager;
    pickerManager.tempPicker = self.tempPicker;
    self.tempPicker.delegate = pickerManager;
    self.tempPicker.dataSource = pickerManager;
    
    self.speedPicker.dataSource = self;
    self.speedPicker.delegate = self;
    pickerManager.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10; // this will always be the speed picker
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSNumber numberWithInt:row] stringValue]; // just need to number the rows 0 through 9
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.speedLabel setText:[[NSNumber numberWithInt:row] stringValue]]; // this is the only time we need to update the speed label
}

// manager delegate method
-(void)updateLabels {
    [self.timeLabel setText:(NSString*)[pickerManager minLabel]]; // there is no max time here
    [self.tempLabel setText:(NSString*)[pickerManager tempLabel]];
    
}

// top button pressed
- (IBAction)timeTapGesture:(id)sender {
    [self resetPickerHeights];
    if (_selection != TIME) { // only needs to run when a change should be made
        // set selection to MIN_TIME now that the new min picker is about to show
        _selection = TIME;
        self.timePickerHeight.constant = SEL_HEIGHT_S;
    } else {
        _selection = NONE;
    }// if it was MIN_TIME it should close, then change to NONE
    [UIView animateWithDuration:0.7 animations:^(void) {
        [self.view layoutIfNeeded];//[self updateViewConstraints]; // should tell the view to update heights to zero when something moves
    }]; // animate reset and new height or just reset
    
}


- (IBAction)tempTapGesture:(id)sender {
    [self resetPickerHeights];
    if (_selection != TEMP) { // only needs to run when a change should be made
        _selection = TEMP;
        self.tempPickerHeight.constant = SEL_HEIGHT_S;
    } else {
        _selection = NONE;
    }
    [UIView animateWithDuration: 0.7 animations:^(void) {
        [self.view layoutIfNeeded];
        //[self updateViewConstraints]; // should tell the view to update heights to zero when something moves
    }];
}


- (IBAction)speedTapGesture:(id)sender {
    
    [self resetPickerHeights]; // always change picker heights to zero
    
    if (_selection != SPEED) {
        _selection = SPEED;
        self.tempPickerHeight.constant = SEL_HEIGHT_S;
    } else {
        _selection = NONE;
    }
    [UIView animateWithDuration:0.7 animations:^(void) {
        [self.view layoutIfNeeded];
        //[self updateViewConstraints]; // should tell the view to update heights to zero when something moves
    }];
}

- (void)resetPickerHeights { // might want to save the current indices as well, but it should remain the same
    // should animate if the selection
    self.timePickerHeight.constant = 0;
    self.speedPickerHeight.constant = 0;
    self.tempPickerHeight.constant = 0; // careful to reset the constants, not the pointers to the constraints
    // changes layout in a subsequent animation
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
