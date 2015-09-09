//
//  UILabel+MultiLineAutoSize.m
//  FirstBuild
//
//  Created by Myles Caley on 1/23/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "UILabel+MultiLineAutoSize.h"

@implementation UILabel (MultiLineAutoSize)

//make sure label is set to clip and not word wrap!
- (void)adjustFontSizeToFitMultiLine {
    UIFont *font = self.font;
    CGSize size = self.frame.size;
    
    for (CGFloat maxSize = self.font.pointSize; maxSize >= self.minimumScaleFactor * self.font.pointSize; maxSize -= 1.f)
    {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        
        CGRect textRect = [self.text boundingRectWithSize:constraintSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:font}
                                                  context:nil];
        
        CGSize labelSize = textRect.size;
        
        if(labelSize.height <= size.height)
        {
            self.font = font;
            [self setNeedsLayout];
            break;
        }
    }
    // set the font to the minimum size anyway
    self.font = font;
    [self setNeedsLayout];
}


@end
