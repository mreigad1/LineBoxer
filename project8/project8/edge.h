//
//  edge.h
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#ifndef edge_h
#define edge_h

#import <SpriteKit/SpriteKit.h>
#import "boardLocation.h"
#import "userTypes.h"

@interface edge : NSObject

	@property boardLocation* end;
	@property locationState locState;
	@property SKNode* sprite;

	//constructor for object,
	//only end of edge specified, start is implied by indices in edge container
	-(id)init:(boardLocation*) e;

	//method creates sknode to be drawn
	//NOTE: shall return nil if edge does not direct upward or horizontally to right
	-(SKNode*)createNode:(boardLocation*) start withDim:(CGSize) viewDim;

	//method for updating the color of the spritenode associated with this
	-(void) updateEdgeState:(locationState) newState;

@end

#endif /* edge_h */
