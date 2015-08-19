//
//  FSTRecipeViewController.h
//  FirstBuild
//
//  Created by John Nolan on 8/17/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTRecipeTableViewController.h"
#import "FSTParagon.h"

@interface FSTRecipeViewController : UIViewController <FSTRecipeTableDelegate>

@property FSTParagon* currentParagon;

@end