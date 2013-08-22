//
//  ButtonView.m
//  PaintCode
//
//  Created by wufulin on 13-8-22.
//  Copyright (c) 2013年 Felipe Laso Marsetti. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.redColor = 1.0f;
        self.greenColor = 0.0f;
        self.blueColor = 0.0f;
        self.contentMode = UIViewContentModeRedraw;
    }	
    return self;
}

- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
	[self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	[self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//// Color Declarations
    UIColor *buttonColorLight = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha: 1];
	
    if (self.state == UIControlStateHighlighted) {
        buttonColorLight = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:0.5];
    }
	
    CGFloat buttonColorLightRGBA[4];
    [buttonColorLight getRed:&buttonColorLightRGBA[0]
                       green:&buttonColorLightRGBA[1]
                        blue:&buttonColorLightRGBA[2]
                       alpha:&buttonColorLightRGBA[3]];
	
    UIColor *buttonColorDark = [UIColor colorWithRed:(buttonColorLightRGBA[0] * 0.5)
                                               green:(buttonColorLightRGBA[1] * 0.5)
                                                blue:(buttonColorLightRGBA[2] * 0.5)
                                               alpha:(buttonColorLightRGBA[3] * 0.5 + 0.5)];
    UIColor *innerGlowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.53];
    UIColor *highlightColor2 = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.51];
	
	//// Gradient Declarations
	NSArray* buttonGradientColors =@[(id)buttonColorLight.CGColor,(id)buttonColorDark.CGColor];
	CGFloat buttonGradientLocations[] = {0, 1};
	CGGradientRef buttonGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)buttonGradientColors, buttonGradientLocations);
	
	//// Shadow Declarations
	UIColor* outerGlow = innerGlowColor;
	CGSize outerGlowOffset = CGSizeMake(0.1, -0.1);
	CGFloat outerGlowBlurRadius = 3;
	UIColor* highlight = highlightColor2;
	CGSize highlightOffset = CGSizeMake(0.1, 2.1);
	CGFloat highlightBlurRadius = 2;
	
	//// Frames
	CGRect frame = rect;
	
	
	//// Button
	{
		//// Rounded Rectangle Drawing
		CGRect roundedRectangleRect = CGRectMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 4, CGRectGetWidth(frame) - 7, floor((CGRectGetHeight(frame) - 4) * 0.91111 + 0.5));
		UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: roundedRectangleRect cornerRadius: 4];
		CGContextSaveGState(context);
		CGContextSetShadowWithColor(context, outerGlowOffset, outerGlowBlurRadius, outerGlow.CGColor);
		CGContextBeginTransparencyLayer(context, NULL);
		[roundedRectanglePath addClip];
		CGContextDrawLinearGradient(context, buttonGradient,
									CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMinY(roundedRectangleRect)),
									CGPointMake(CGRectGetMidX(roundedRectangleRect), CGRectGetMaxY(roundedRectangleRect)),
									0);
		CGContextEndTransparencyLayer(context);
		
		////// Rounded Rectangle Inner Shadow
		CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -highlightBlurRadius, -highlightBlurRadius);
		roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -highlightOffset.width, -highlightOffset.height);
		roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);
		
		UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect: roundedRectangleBorderRect];
		[roundedRectangleNegativePath appendPath: roundedRectanglePath];
		roundedRectangleNegativePath.usesEvenOddFillRule = YES;
		
		CGContextSaveGState(context);
		{
			CGFloat xOffset = highlightOffset.width + round(roundedRectangleBorderRect.size.width);
			CGFloat yOffset = highlightOffset.height;
			CGContextSetShadowWithColor(context,
										CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
										highlightBlurRadius,
										highlight.CGColor);
			
			[roundedRectanglePath addClip];
			CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0);
			[roundedRectangleNegativePath applyTransform: transform];
			[[UIColor grayColor] setFill];
			[roundedRectangleNegativePath fill];
		}
		CGContextRestoreGState(context);
		
		CGContextRestoreGState(context);
		
		[[UIColor blackColor] setStroke];
		roundedRectanglePath.lineWidth = 2;
		[roundedRectanglePath stroke];
	}
	
	
	//// Cleanup
	CGGradientRelease(buttonGradient);
	CGColorSpaceRelease(colorSpace);
	
}

@end
