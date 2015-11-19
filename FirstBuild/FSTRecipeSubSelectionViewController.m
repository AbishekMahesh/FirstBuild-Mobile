//
//  FSTRecipeSubSelectionViewController.m
//  FirstBuild
//
//  Created by Myles Caley on 5/12/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTRecipeSubSelectionViewController.h"
#import "FSTRecipes.h"
#import "FSTSousVideRecipes.h"
#import "FSTBeefSousVideRecipe.h"
#import "FSTBeefSousVideRecipes.h"
#import "FSTBeefSteakSousVideRecipe.h"
#import "FSTBeefSousVideSteakRecipes.h"
#import "FSTBeefSteakTenderSousVideRecipe.h"
#import "FSTBeefSettingsViewController.h"
#import "MobiNavigationController.h"
#import "FSTCustomCookSettingsViewController.h"
#import "FSTRevealViewController.h"
#import "FSTSavedRecipeViewController.h"
#import "FSTCandyRecipe.h"
#import "FSTCandyRecipes.h"


@interface FSTRecipeSubSelectionViewController ()

@end

@implementation FSTRecipeSubSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.childViewControllers[0] isKindOfClass:[FSTRecipeTableViewController class]])
    {
        ((FSTRecipeTableViewController*) self.childViewControllers[0]).delegate = self;
    }
    
    MobiNavigationController* navigation = (MobiNavigationController*)self.navigationController;
    if (self.recipe)
    {
        NSString* headerText = [self.recipe.name uppercaseString];
        [navigation setHeaderText:headerText withFrameRect:CGRectMake(0, 0, 120, 30)];
    }
    else
    {
        [navigation setHeaderImageNamed:@"Paragon_Logo_Red" withFrameRect:CGRectMake(0, 0, 120, 30)];
        [navigation.navigationBar setBarTintColor:[UIColor blackColor]];
    }
}

- (void)dealloc
{
    DLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (FSTRecipes*) dataRequestedFromChild
{
    if ([self.recipe isKindOfClass:[FSTBeefSteakSousVideRecipe class]])
    {
        return (FSTRecipes*)[[FSTBeefSousVideSteakRecipes alloc]init];
    }
    else if ([self.recipe isKindOfClass:[FSTBeefSousVideRecipe class]])
    {
        return (FSTRecipes*)[[FSTBeefSousVideRecipes alloc]init];
    }
    else if ([self.recipe isKindOfClass:[FSTSousVideRecipe class]])
    {
        return (FSTRecipes*)[[FSTSousVideRecipes alloc]init];
    }
    else if ([self.recipe isKindOfClass:[FSTCandyRecipe class]])
    {
        return (FSTRecipes*)[[FSTCandyRecipes alloc]init];
    }
    else
    {
        return [[FSTRecipes alloc]init];
    }
    return nil;
}

- (void) recipeSelected:(FSTRecipe *)cookingMethod
{
    if ([cookingMethod isKindOfClass:[FSTBeefSteakTenderSousVideRecipe class]])
    {
        [self performSegueWithIdentifier:@"segueBeefSettings" sender:cookingMethod];
    }
    else
    {
        [self performSegueWithIdentifier:@"segueSubCookingMethod" sender:cookingMethod];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[FSTRecipeSubSelectionViewController class]])
    {
        ((FSTRecipeSubSelectionViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
        ((FSTRecipeSubSelectionViewController*)segue.destinationViewController).recipe = (FSTRecipe*)sender;
    }
    else if ([segue.destinationViewController isKindOfClass:[FSTCustomCookSettingsViewController class]])
    {
        //the actual recipe for a custom cook settings view is initialized in the view itself
        //just tell it which paragon this should go to
        ((FSTCookSettingsViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
    }
    else if ([segue.destinationViewController isKindOfClass:[FSTCookSettingsViewController class]])
    {
        //if its not a custom cook view controller then its some other type of cook settings view controller
        //so we need to set the to be receip to whatever they just selected, which is the sender
        //(see recipeSelected)
        self.currentParagon.session.toBeRecipe = (FSTRecipe*)sender;
        ((FSTCookSettingsViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
    }
    else if([segue.destinationViewController isKindOfClass:[FSTSavedRecipeViewController class]])
    {
        ((FSTSavedRecipeViewController*)segue.destinationViewController).currentParagon = self.currentParagon;

    }
}

- (IBAction)recipeTap:(id)sender {
    [self performSegueWithIdentifier:@"recipesSegue" sender:nil];
}

- (IBAction)customTap:(id)sender {
    [self performSegueWithIdentifier:@"segueCustom" sender:nil];
}
- (IBAction)menuToggleTapped:(id)sender
{
    [self.revealViewController rightRevealToggle:self.currentParagon]; // the other says product, which is inconsistent
}

@end
