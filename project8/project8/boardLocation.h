//
//  boardLocation.h
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef boardLocation_h
#define boardLocation_h

#import <SpriteKit/SpriteKit.h>

@interface boardLocation : NSObject

	@property CGPoint location;
	@property SKNode* sprite;

	//constructor for object
	-(id)init:(CGPoint) loc;

	//This procedure sets the location of this point
	-(void)setPoint:(CGPoint) loc ;

	//method creates and returns sknode from object
	-(SKNode*)createNode:(CGSize) viewDim;

@end

#endif /* boardLocation_h */
