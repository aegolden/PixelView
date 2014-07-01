//
//  DrawingView.m
//  PixelTest
//
//  Created by Aaron Golden on 6/30/14.
//  Copyright (c) 2014 Aaron Golden. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

- (void)clearView {
    memset_pattern4(self.pixels, (unsigned char[4]){255, 0, 0, 0}, self.pixelsWide * self.pixelsHigh * 4);
    [self refresh];
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self clearView];
    }
    return self;
}

- (void)drawWhiteForEvent:(NSEvent *)theEvent {
    CGPoint pointInView = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSInteger x, y;
    if ([self getPixelX:&x pixelY:&y forPoint:pointInView]) {
        NSInteger j = (y * self.pixelsWide + x) * 4;
        unsigned char *pixels = self.pixels;
        pixels[j + 0] = 255; // Alpha
        pixels[j + 1] = 255; // Red
        pixels[j + 2] = 255; // Green
        pixels[j + 3] = 255; // Blue
        [self refresh];
    }
}

- (void)setFrame:(NSRect)frameRect {
    if (!CGRectEqualToRect(frameRect, self.frame)) {
        [super setFrame:frameRect];
        [self clearView];
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    [self drawWhiteForEvent:theEvent];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    [self drawWhiteForEvent:theEvent];
}

@end
