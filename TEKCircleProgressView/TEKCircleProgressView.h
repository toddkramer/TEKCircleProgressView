//
//  TEKCircleProgressView.h
//  CircleProgressView
//
//  Created by Todd Kramer on 4/21/14.
//  Copyright (c) 2014 Todd Kramer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _TEKProgressViewSizes {
    TEKProgressViewSizeSmall = 0,
    TEKProgressViewSizeMedium = 1,
    TEKProgressViewSizeLarge = 2
} TEKProgressViewSize;

typedef enum _TEKProgressViewColorGradients {
    TEKProgressViewColorGradientRedGreen = 0,
    TEKProgressViewColorGradientBlue = 1
} TEKProgressViewColorGradient;

@interface TEKCircleProgressView : UIView

-(id)initWithOrigin:(CGPoint)origin size:(TEKProgressViewSize)size percentage:(float)percentage colorGradient:(TEKProgressViewColorGradient)colorGradient;

-(void)updateViewForPercentage:(float)percentage;

@end
