//
//  buttonControl.m
//  project8
//
//  Created by Timothy Redband on 4/21/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "buttonControl.h"

@implementation buttonControl



-(id)initWithFile:(NSString*)fileName{
    if(self = [super init]){
        _file = fileName;
        _d_pad = [SKSpriteNode spriteNodeWithImageNamed:fileName];
    }
    return self;
}

-(void)setPosition:(float)xpos y:(float)ypos{
    _location.x = xpos;
    _location.y = ypos;
    
}

//adds the directional pad button into the scene
-(void)addToView: (SKScene*) s{
    CGFloat h = s.size.height;
    CGFloat w = s.size.width;
    CGFloat x_p = w - _location.x * w;
    CGFloat y_p = h - _location.y * h;
    CGPoint pos;
    pos.x = x_p;
    pos.y = y_p;
    float button_scale = 0.5;
	
	//TODO: Figure out why buttons are not being sized smaller for ipad
	//larger scale for buttons on iphone than ipad
	if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){//phone
		button_scale = 0.15;
	}else{	//ipad
		button_scale = 0.10;
	}
	
    [_d_pad setPosition:pos];
    [_d_pad setScale:button_scale];
    [s addChild:_d_pad];
}



@end