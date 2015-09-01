//
//  FSTEditRecipeViewController.m
//  FirstBuild
//
//  Created by John Nolan on 8/13/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTSavedEditRecipeViewController.h"
#import "FSTSavedMultiStageRecipeController.h"
#import "FSTSavedRecipeTabBarController.h"
#import "FSTSavedRecipeIngredientsViewController.h"
#import "FSTSavedRecipeInstructionsViewController.h"
#import "FSTSavedRecipeSettingsViewController.h"
#import "FSTSavedRecipeTabBarController.h"
#import "FSTStageSettingsViewController.h"
#import "FSTStageTableContainerViewController.h"
#import "FSTSavedRecipeViewController.h"
#import "FSTSousVideRecipe.h"

@interface FSTSavedEditRecipeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageEditor;

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *stageView;

@end

@implementation FSTSavedEditRecipeViewController
{
    FSTSavedRecipeManager* recipeManager;
    
    // some crucial data objects in the children
    FSTStagePickerManager* childPickerManager;
    
    
}

typedef enum variableSelections {
    MIN_TIME,
    MAX_TIME,
    TEMPERATURE,
    NONE
} VariableSelection;
// keeps track of the open picker views

VariableSelection _selection;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    recipeManager = [FSTSavedRecipeManager sharedInstance];
    [self.nameField setDelegate:self];
    [self registerKeyboardNotifications];
    /*if ([self.activeRecipe isKindOfClass:[FSTSousVideRecipe class]]) { //TODO: add a Multi Stage Recipe class
        ((FSTSavedRecipeTabBarController*)self.childViewControllers[0]).is_multi_stage = NO; // sous vide has min and max time, no stages
    } else {
        ((FSTSavedRecipeTabBarController*)self.childViewControllers[0]).is_multi_stage = YES;
    // how do I get the tab bar to load the right view controller after this? this sets after viewDidLoad in tab bar
    }*/ // the child will check the variable on its parent
}


#pragma mark - keyboard events
- (void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // DEALLOC these?
}

- (void)keyboardWasShown:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets editScrollInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = editScrollInsets;
    self.scrollView.scrollIndicatorInsets = editScrollInsets;
    
    CGRect sRect = self.view.frame;
    sRect.size.height -= kbSize.height;
    CGPoint scrollOffset;
    if ([self.nameField isFirstResponder]) {
        
        scrollOffset = CGPointMake(0.0, kbSize.height - self.nameField.frame.origin.y/2);
            // the vertical distance between the keyboard and the nameField origin. (buffer it a bit so the namefield is just above.
    } else {
        // check if child is within the bounds
        CGRect childFrame =((UIViewController*)[self.childViewControllers objectAtIndex:0]).view.frame;
//        if (!CGRectContainsPoint(sRect, childFrame.origin)) {
            scrollOffset = CGPointMake(0.0, kbSize.height ); // move it up as far as the keyboard went
//        }
        
    }
    [self.scrollView setContentOffset:scrollOffset animated:YES];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    UIEdgeInsets scrollInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

- (void)viewWillAppear:(BOOL)animated { // perhaps view did load? I want view did load in the child to have called. Could just have an ingredients setter if it does not work
    [super viewWillAppear:animated];
    // set the recipe image (either taken from the camera or initialized in the recipe object), same as the activeRecipePhoto, which only changes when the imageEditor finishes
    [self.imageEditor setImage:self.activeRecipe.photo.image];
    // set the name if it is in the recipe
    [self.nameField setText:self.activeRecipe.friendlyName];
    FSTSavedRecipeTabBarController* recipeTBC = [self.childViewControllers objectAtIndex:0];
    recipeTBC.delegate = self;
    
    for (UIViewController* vc in recipeTBC.viewControllers) {
        if ([vc isKindOfClass:[FSTSavedRecipeIngredientsViewController class]])
        {
            ((FSTSavedRecipeIngredientsViewController*)vc).ingredients = self.activeRecipe.ingredients; // set the ingredients property for when it loads
            // ingredients view should be the first one in the array (set it before it is visible)
        } else if ([vc isKindOfClass:[FSTSavedRecipeInstructionsViewController class]]) {
            ((FSTSavedRecipeInstructionsViewController*)vc).instructions = self.activeRecipe.note; // this can be set later in view did load
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - image editing
- (IBAction)imageEditorTapped:(id)sender {
    UIImagePickerController* mealImagePicker = [[UIImagePickerController alloc] init];
    mealImagePicker.delegate = self;
    mealImagePicker.allowsEditing = YES;
    mealImagePicker.sourceType = UIImagePickerControllerCameraDeviceFront; // change this mode to let users select an image from the library
    
    [self presentViewController:mealImagePicker animated:YES completion:NULL];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage* imageTaken = info[UIImagePickerControllerEditedImage];
    //self.imageEditor.image = imageTaken;
    [self.activeRecipe.photo setImage:imageTaken];
    // sets when save button pressed
    //self.imageEditor.image = imageTaken;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.view layoutIfNeeded]; // constraints seem to be off
   // self.scrollView.contentSize = CGSizeMake(self.stageView.frame.size.width, self.scrollView.contentSize.height);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - text field and view delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.activeRecipe.friendlyName = [NSMutableString stringWithString:textField.text];
    return YES; // might want to scroll to different positions depending on the delegate
}

#pragma mark - save button

- (IBAction)saveButtonTapped:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
        self.activeRecipe.friendlyName = [NSMutableString stringWithString:self.nameField.text];
    FSTSavedRecipeTabBarController* recipeTBC = (FSTSavedRecipeTabBarController*)self.childViewControllers[0];
    self.activeRecipe.ingredients = ((FSTSavedRecipeIngredientsViewController*)recipeTBC.viewControllers[0]).ingredients;
    self.activeRecipe.note = ((FSTSavedRecipeInstructionsViewController*)recipeTBC.viewControllers[1]).instructions;
    //[self.activeRecipe.photo setImage:self.imageEditor.image];
    // the image editor already has a pointer to the active recipe, do not reverse that
    // for some reason the image clears
    if (childPickerManager) {
        // child PickerManager was set, so the setting might have changed (otherwise these values did not change or were not set)
        [self.activeRecipe addStage];
        ((FSTParagonCookingStage*)self.activeRecipe.paragonCookingStages[0]).cookTimeMinimum = [childPickerManager minMinutesChosen];
        ((FSTParagonCookingStage*)self.activeRecipe.paragonCookingStages[0]).cookTimeMaximum = [childPickerManager maxMinutesChosen];
        ((FSTParagonCookingStage*)self.activeRecipe.paragonCookingStages[0]).targetTemperature = [childPickerManager temperatureChosen];
    }
    // TODO: work out the session / recipe issue
    // get all the session variables from the pickers, then save it
    if ([self.activeRecipe.paragonCookingStages count] > 0 && self.activeRecipe.friendlyName.length > 0) {
        // this is safe to write to the paragon
        [recipeManager saveRecipe:self.activeRecipe];
        for (UIViewController* vc in [self.navigationController viewControllers]) {
            if ([vc isKindOfClass:[FSTSavedRecipeViewController class]]) {
                // the table container two vc's back
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    } else if ([self.activeRecipe.paragonCookingStages count] == 0){
        // needs cooking settings
        UIAlertView* settingsAlert = [[UIAlertView alloc] initWithTitle:@"Settings Required" message:@"A functional recipe requires at least one cooking stage" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [settingsAlert show];
    } else if (self.activeRecipe.friendlyName.length == 0) {
        // needs cooking settings
        UIAlertView* settingsAlert = [[UIAlertView alloc] initWithTitle:@"Name Required" message:@"The recipes cannot save without a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [settingsAlert show];
    }
}

#pragma mark - UITabBarControllerDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
   if ([viewController isKindOfClass:[FSTSavedRecipeSettingsViewController class]])
    {
        childPickerManager = ((FSTSavedRecipeSettingsViewController*)viewController).pickerManager;
        if ([self.activeRecipe.paragonCookingStages count] > 0) {
            // there is at least some stage set
            FSTParagonCookingStage* firstStage = self.activeRecipe.paragonCookingStages[0];
            // select the times in the child
            [childPickerManager selectMinMinutes:firstStage.cookTimeMinimum withMaxMinutes:firstStage.cookTimeMaximum];
            // select the temperature in the last picker
            [childPickerManager selectTemperature:firstStage.targetTemperature];
        }
    } else if ([viewController isKindOfClass:[FSTStageTableContainerViewController class]]) {
        ((FSTStageTableViewController*)viewController.childViewControllers[0]).delegate = self; //need to know which stage was selected in the table (table is now imbedded) // child view controller needs to be set within view did load, the the delegate
        ((FSTStageTableViewController*)viewController.childViewControllers[0]).stageCount = self.activeRecipe.paragonCookingStages.count; // number of stages that appear in the table
    } // get the picker manager for quick access from the
    
}

#pragma mark - FSTStageTableViewControllerDelegate

-(void)editStageAtIndex:(NSInteger)index {
    FSTParagonCookingStage* selectedStage;
    if (index < self.activeRecipe.paragonCookingStages.count) {
        selectedStage = self.activeRecipe.paragonCookingStages[index];
    } else {
        selectedStage = [self.activeRecipe addStage]; // add a new stage and reference it for editing
    }
    [self performSegueWithIdentifier:@"stageSettingsSegue" sender:selectedStage]; // pass the stage for editing in the coming view controller
    
}

-(void)deleteStageAtIndex:(NSInteger)index {
    [self.activeRecipe.paragonCookingStages removeObjectAtIndex:index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"stageSettingsSegue"]) {
        ((FSTStageSettingsViewController*)segue.destinationViewController).activeStage = (FSTParagonCookingStage*)sender; // some stage must have been set before the segue
    } else if ([segue.identifier isEqualToString:@"tabBarSegue"]) {
        ((FSTSavedRecipeTabBarController*)segue.destinationViewController).is_multi_stage = self.is_multi_stage;
    }
}

@end