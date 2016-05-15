//
//  boardLocation.m
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "boardLocation.h"
#import "userTypes.h"
#import "board.h"

@implementation boardLocation : NSObject

	//constructor for object
	-(id)init:(CGPoint) loc{
		_location = loc;
		return self;
	}



	//This procedure sets the location of this point
	-(void)setPoint:(CGPoint) loc {
		_location = loc;
		
	}

	-(SKNode*)createNode:(CGSize) viewDim{
		SKShapeNode* retVal = [SKShapeNode shapeNodeWithCircleOfRadius:[board LOCATION_SIZE]];
		retVal.fillColor = [SKColor whiteColor];
		[retVal setPosition:CGPointMake(_location.x * viewDim.width, _location.y * viewDim.height)];
		[retVal setZPosition:3];
		_sprite = retVal;
		return retVal;
	}

@end