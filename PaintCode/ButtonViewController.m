//
//  FirstViewController.m
//  PaintCode
//
//  Created by Felipe on 5/21/13.
//  Copyright (c) 2013 Felipe Laso Marsetti. All rights reserved.
//

#import "ButtonViewController.h"

@implementation ButtonViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.redSlider setValue:self.buttonView.redColor];
	[self.greenSlider setValue:self.buttonView.greenColor];
	[self.blueSlider setValue:self.buttonView.blueColor];
}

- (IBAction)sliderValueChanged:(UISlider *)slider {
	if (slider == self.redSlider) {
		self.buttonView.redColor = self.redSlider.value;
	}else if (slider == self.greenSlider) {
		self.buttonView.greenColor = self.greenSlider.value;
	}else if (slider == self.blueSlider) {
		self.buttonView.blueColor = self.blueSlider.value;
	}
	
	[self.buttonView setNeedsDisplay];
}
@end
