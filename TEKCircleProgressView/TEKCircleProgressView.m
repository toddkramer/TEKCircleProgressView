//
//  TEKCircleProgressView.m
//  CircleProgressView
//
//  Created by Todd Kramer on 4/21/14.
//  Copyright (c) 2014 Todd Kramer. All rights reserved.
//

#import "TEKCircleProgressView.h"
@import QuartzCore;

@interface TEKCircleProgressView ()

@property (nonatomic, strong) UIView *maskingView;
@property (nonatomic, strong) UILabel *percentageLabel;
@property (nonatomic, assign) TEKProgressViewColorGradient colorGradient;
@property (nonatomic, assign) float percentage;
@property (nonatomic, assign) float percentageLabelFontSize;

@end

const float kTEKProgressViewSizeSmallDimension = 60.0;
const float kTEKProgressViewSizeMediumDimension = 100.0;
const float kTEKProgressViewSizeLargeDimension = 150.0;

const float kTEKFontSizeSmall = 12.0;
const float kTEKFontSizeMedium = 16.0;
const float kTEKFontSizeLarge = 24.0;

@implementation TEKCircleProgressView

-(id) init {
    return [self initWithOrigin:CGPointMake(0, 0) size:TEKProgressViewSizeMedium percentage:50.0 colorGradient:TEKProgressViewColorGradientRedGreen];
}

- (id)initWithFrame:(CGRect)frame
{
    float frameWidth = frame.size.width;
    float frameHeight = frame.size.height;
    if (!(frameWidth == frameHeight)) {
        frameHeight = frameWidth;
    }
    float dimension = frameWidth;
    
    TEKProgressViewSize size;
    if (dimension > 125) {
        size = TEKProgressViewSizeLarge;
    }
    else if (80 < dimension <= 125) {
        size = TEKProgressViewSizeMedium;
    }
    else {
        size = TEKProgressViewSizeSmall;
    }

    return [self initWithOrigin:frame.origin size:size percentage:50.0 colorGradient:TEKProgressViewColorGradientRedGreen];
}

-(id)initWithOrigin:(CGPoint)origin size:(TEKProgressViewSize)size percentage:(float)percentage colorGradient:(TEKProgressViewColorGradient)colorGradient {
    CGSize progressViewSize;
    switch (size) {
        case TEKProgressViewSizeSmall:
            progressViewSize = [self squareSizeWithDimension:kTEKProgressViewSizeSmallDimension];
            _percentageLabelFontSize = kTEKFontSizeSmall;
            break;
        
        case TEKProgressViewSizeMedium:
            progressViewSize = [self squareSizeWithDimension:kTEKProgressViewSizeMediumDimension];
            _percentageLabelFontSize = kTEKFontSizeMedium;
            break;
            
        case TEKProgressViewSizeLarge:
            progressViewSize = [self squareSizeWithDimension:kTEKProgressViewSizeLargeDimension];
            _percentageLabelFontSize = kTEKFontSizeLarge;
            break;
            
        default:
            break;
    }
    self = [super initWithFrame:CGRectMake(origin.x, origin.y, progressViewSize.width, progressViewSize.height)];
    if (self) {
        _percentage = percentage;
        _colorGradient = colorGradient;
        _maskingView = [[UIView alloc] init];
        _percentageLabel = [[UILabel alloc] init];
        
        [self updateProgressView];
    }
    return self;
}

-(CGSize)squareSizeWithDimension:(float)dimension {
    return CGSizeMake(dimension, dimension);
}

-(void)updateViewForPercentage:(float)percentage {
    self.percentage = percentage;
    [self updateProgressView];
}

-(void)updatePercentageLabel {
    if (0 <= self.percentage < 100.0f) {
        self.percentageLabel.text = [NSString stringWithFormat:@"%0.1f%%",self.percentage];
    }
    else if (self.percentage >= 100.0f) {
        self.percentageLabel.text = @"100%%";
    }
    else {
        self.percentageLabel.text = @"0%%";
    }
    
    self.percentageLabel.textAlignment = NSTextAlignmentCenter;
    self.percentageLabel.textColor = [UIColor blackColor];
    self.percentageLabel.font = [UIFont boldSystemFontOfSize:self.percentageLabelFontSize];
    
    CGRect boundingRect = [self.percentageLabel.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.percentageLabel.font} context:nil];
    self.percentageLabel.frame = CGRectMake(0, (self.frame.size.height/2) - (boundingRect.size.height/2), self.frame.size.width, boundingRect.size.height);
    [self addSubview:self.percentageLabel];
}

-(UIColor *)grayBackgroundColor {
    return [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
}

-(void)updateProgressView {
    self.backgroundColor = [self grayBackgroundColor];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.masksToBounds = YES;
    
    float scaledPercentage = ((self.percentage * self.frame.size.height) / 100);
    self.maskingView.frame = CGRectMake(0, self.frame.size.height - scaledPercentage, self.frame.size.width, scaledPercentage);
    if (self.percentage <= 50.0) {
        switch (self.colorGradient) {
            case TEKProgressViewColorGradientRedGreen:
                self.maskingView.backgroundColor = [UIColor colorWithRed:255/255.0 green:(self.percentage * 4)/255.0 blue:0 alpha:1.0];
                break;
                
            case TEKProgressViewColorGradientBlue:
                self.maskingView.backgroundColor = [UIColor colorWithRed:(250 - (self.percentage * 4))/255.0 green:255/255.0 blue:255.0 alpha:1.0];
                break;
        }
    }
    else {
        switch (self.colorGradient) {
            case TEKProgressViewColorGradientRedGreen:
                self.maskingView.backgroundColor = [UIColor colorWithRed:(255 - ((self.percentage - 50)*4))/255.0 green:200/255.0 blue:0 alpha:1.0];
                break;
                
            case TEKProgressViewColorGradientBlue:
                self.maskingView.backgroundColor = [UIColor colorWithRed:0/255.0 green:(255 - ((self.percentage - 50) * 4))/255.0 blue:255.0 alpha:1.0];
                break;
        }
    }
    
    if (![self.maskingView isDescendantOfView:self]) {
        [self insertSubview:self.maskingView atIndex:0];
    }
    
    [self updatePercentageLabel];
}

@end
