//
//  TEKViewController.m
//  CircleProgressView
//
//  Created by Todd Kramer on 4/21/14.
//  Copyright (c) 2014 Todd Kramer. All rights reserved.
//

#import "TEKViewController.h"
#import "TEKCircleProgressView.h"

@interface TEKViewController ()

@property (strong, nonatomic) IBOutlet UISlider *percentageSlider;
@property (strong, nonatomic) TEKCircleProgressView *progressView;

@end

@implementation TEKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.progressView = [[TEKCircleProgressView alloc] initWithOrigin:CGPointMake(100, 100) size:TEKProgressViewSizeMedium percentage:self.percentageSlider.value colorGradient:TEKProgressViewColorGradientRedGreen];
    [self.view addSubview:self.progressView];
}

- (IBAction)sliderValueChange:(id)sender {
    [self.progressView updateViewForPercentage:self.percentageSlider.value];
}

@end
