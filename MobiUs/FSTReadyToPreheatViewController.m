//
//  FSTReadyToPreheatViewController.m
//  FirstBuild
//
//  Created by Myles Caley on 5/12/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "FSTReadyToPreheatViewController.h"
#import "FSTCookingViewController.h"
#import "MobiNavigationController.h"
#import "FSTRevealViewController.h"

@interface FSTReadyToPreheatViewController ()

@end

@implementation FSTReadyToPreheatViewController

NSObject* _cookModeChangedObserver;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    __weak typeof(self) weakSelf = self;
    
    _cookModeChangedObserver = [center addObserverForName:FSTCookModeChangedNotification
                                                      object:weakSelf.currentParagon
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification)
   {
       if(weakSelf.currentParagon.currentCookMode == kPARAGON_PREHEATING)
       {
           [weakSelf performSegueWithIdentifier:@"seguePreheating" sender:weakSelf];
       }
       else if(weakSelf.currentParagon.currentCookMode == kPARAGON_HEATING)
       {
           [weakSelf performSegueWithIdentifier:@"seguePreheating" sender:weakSelf];
       }
   }];
}

-(void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:_cookModeChangedObserver];
}

-(void)dealloc
{
    [self removeObservers];
}

- (void)viewWillAppear:(BOOL)animated
{

    MobiNavigationController* controller = (MobiNavigationController*)self.navigationController;
    [controller setHeaderText:@"GET READY" withFrameRect:CGRectMake(0, 0, 120, 30)];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self removeObservers];

    if ([segue.destinationViewController isKindOfClass:[FSTCookingViewController class]])
    {
        ((FSTCookingViewController*)segue.destinationViewController).currentParagon = self.currentParagon;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuToggleTapped:(id)sender {
    [self.revealViewController rightRevealToggle:self.currentParagon];
}

@end
