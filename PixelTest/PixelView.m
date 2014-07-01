//
//  PixelView.m
//  PixelTest
//
//  Created by Aaron Golden on 6/30/14.
//  Copyright (c) 2014 Aaron Golden. All rights reserved.
//

#import "PixelView.h"

@implementation PixelView {
    NSBitmapImageRep *_bitmapRep;
}

- (void)refresh {
    self.layer.contents = (__bridge id)_bitmapRep.CGImage;
}

- (void)updateBitmap {
    const CGRect selfBounds = [self bounds];
    const CGFloat backingScaleFactor = [[NSScreen mainScreen] backingScaleFactor];
    const NSInteger width = CGRectGetWidth(selfBounds) * backingScaleFactor;
    const NSInteger height = CGRectGetHeight(selfBounds) * backingScaleFactor;
    _bitmapRep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:width pixelsHigh:height bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSDeviceRGBColorSpace bitmapFormat:NSAlphaFirstBitmapFormat bytesPerRow:width * 4 bitsPerPixel:8 * 4];
    unsigned char *pixels = [_bitmapRep bitmapData];
    memset(pixels, 0, width * height * 4);

    [self refresh];
}

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setWantsLayer:YES];
        [self updateBitmap];
    }
    return self;
}

- (void)setFrame:(NSRect)frameRect {
    if (!CGRectEqualToRect(frameRect, self.frame)) {
        [super setFrame:frameRect];
        [self updateBitmap];
    }
}

- (unsigned char *)pixels {
    return [_bitmapRep bitmapData];
}

- (NSInteger)pixelsWide {
    return [_bitmapRep pixelsWide];
}

- (NSInteger)pixelsHigh {
    return [_bitmapRep pixelsHigh];
}

- (BOOL)getPixelX:(NSInteger *)outX pixelY:(NSInteger *)outY forPoint:(CGPoint)point {
    const CGFloat backingScaleFactor = [self.window backingScaleFactor];
    NSInteger x = lround(point.x * backingScaleFactor);
    NSInteger y = lround((CGRectGetHeight([self bounds]) - point.y) * backingScaleFactor);
    if (outX) {
        *outX = x;
    }
    if (outY) {
        *outY = y;
    }
    return (x < [_bitmapRep pixelsWide] && y < [_bitmapRep pixelsHigh]);
}

@end
