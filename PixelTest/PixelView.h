//
//  PixelView.h
//  PixelTest
//
//  Created by Aaron Golden on 6/30/14.
//  Copyright (c) 2014 Aaron Golden. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 PixelView is an NSView subclass designed to support "direct" pixel
 manipulation.  A PixelView's layer's contents is the CGImage of an
 NSBitmapImageRep.

 To modify what a PixelView displays, manipulate the memory at `pixels` and
 send `refresh`.
 */
@interface PixelView : NSView

/**
 The pixel's of the NSBitmapImageRep whose CGImage is the contents of the
 receiver's layer.  The pixel format is ARGB, with the first `pixelsWide` * 4
 bytes corresponding to the top row of the contents.
 */
@property (nonatomic, readonly) unsigned char *pixels;

/**
 The width of the receiver's layer's backing store in pixels.
 */
@property (nonatomic, readonly) NSInteger pixelsWide;

/**
 The height of the receiver's layer's backing store in pixels.
 */
@property (nonatomic, readonly) NSInteger pixelsHigh;

/**
 Convenience method to get integer x and y pixel coordinates in the
 receiver's backing store for a point in the receiver's coordinate
 system.

 @param point a point in the receiver's coordinate system.
 @param outX on return, the x coordinate of the pixel nearest to point.
 The first column of pixels on the left has x coordinate equal to zero, and
 the last column of pixels on the right has x coordinate equal to
 `pixelsWide` - 1.
 @param outY on return, the y coordinate of the pixel nearest to point.
 The top row of pixels has y coordinate equal to zero.
 @return YES if point corresponds to a valid point in the bitmap, NO otherwise.
 */
- (BOOL)getPixelX:(NSInteger *)outX pixelY:(NSInteger *)outY forPoint:(CGPoint)point;

/**
 Causes the receiver to redraw immediately.
 */
- (void)refresh;

@end
