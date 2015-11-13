//
//  FSTSavedDisplayRecipeViewController.m
//  FirstBuild
//
//  Created by John Nolan on 9/2/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTSavedDisplayRecipeViewController.h"
#import "FSTReadyToReachTemperatureViewController.h"
#import "FSTStageSettingsViewController.h"
#import "FSTSavedRecipeTabBarController.h"
#import "FSTStageSettingsViewController.h"
#import "FSTStageTableContainerViewController.h"

@interface FSTSavedDisplayRecipeViewController ()

@property UITabBarController* childTabController;

@end

@implementation FSTSavedDisplayRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageHolder.userInteractionEnabled = NO;
    self.nameField.userInteractionEnabled = NO;
    self.nameField.backgroundColor = [UIColor whiteColor];
    self.smallCamera.hidden = YES; // will never show up in this view
    if ([self.will_hide_cook boolValue]) {
        self.cookButton.hidden = true;
    }
    ((UIViewController*)self.childTabController.viewControllers[0]).view.userInteractionEnabled = NO; // do not yet users press the first view that loads // there are some layout issues as well, how to fix that?
} // is_multi_stage does not pass

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [super tabBarController:tabBarController didSelectViewController:viewController];
    if ([viewController isKindOfClass:[FSTStageTableContainerViewController class]]) {
        viewController.view.userInteractionEnabled = YES;
        // users can still select members of the table
    } else {
        viewController.view.userInteractionEnabled = NO;
    }
}
- (IBAction)cookButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"startSegue" sender:self];
}

// delegate method
- (BOOL)canEditStages {
    return NO;
    // the user cannot edit anything here
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"startSegue"]) {
        ((FSTReadyToReachTemperatureViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
        self.currentParagon.session.toBeRecipe = self.activeRecipe; // set the method?
        [self.currentParagon sendRecipeToCooktop:self.currentParagon.session.toBeRecipe];
    } else if ([segue.identifier isEqualToString:@"stageSettingsSegue"]) {
        ((FSTStageSettingsViewController*)segue.destinationViewController).activeStage = (FSTParagonCookingStage*)sender;
        ((FSTStageSettingsViewController*)segue.destinationViewController).can_edit = [NSNumber numberWithBool:NO];
    } else if ([segue.identifier isEqualToString:@"tabBarSegue"]) {
        ((FSTSavedRecipeTabBarController*)segue.destinationViewController).is_multi_stage = self.is_multi_stage;
        self.childTabController = (FSTSavedRecipeTabBarController*)segue.destinationViewController;
    }
} // TODO: set this up in storyboard


@end