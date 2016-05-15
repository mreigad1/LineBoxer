//
//  buttonControl.h
//  project8
//
//  Created by Timothy Redband on 4/21/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef buttonControl_h
#define buttonControl_h

#import <SpriteKit/SpriteKit.h>

@interface buttonControl : NSObject

@property CGPoint location;
@property SKSpriteNode* d_pad;
@property NSString *file;


-(id)initWithFile:(NSString*)fileName;

-(void)setPosition:(float)x y:(float)ypos;

-(void) addToView: (SKScene*) s;

@end
#endif /* buttonControl_h */
