//
//  FirstViewController.h
//  PaintCode
//
//  Created by Felipe on 5/21/13.
//  Copyright (c) 2013 Felipe Laso Marsetti. All rights reserved.
//

#import "ButtonView.h"

@interface ButtonViewController : UIViewController

@property (weak, nonatomic) IBOutlet ButtonView *buttonView;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end
