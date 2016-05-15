//
//  board.m
//  project8
//
//  Created by Matthew Reigada on 4/14/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "board.h"
#import "edge.h"
#import "userTypes.h"

static int SQUARE_BOARD_SIZE = 10;

@implementation board : NSObject 

	+(void) SET_BOARD_SIZE:(int) newSize{
		SQUARE_BOARD_SIZE = newSize;
	}

	+(int) GET_BOARD_SIZE{
		return SQUARE_BOARD_SIZE;
	}

	+(int) LOCATION_SIZE{
		return ((40 / SQUARE_BOARD_SIZE) + 1);
	}

	+(int) SELECTED_LOCATION_SIZE{
		return ([board LOCATION_SIZE] + 1);
	}

	+(int) EDGE_THICKNESS{
		return ([board LOCATION_SIZE ] - 1);
	}

	+(double) MOVEMENT_DURATION{
		return (0.125);
	}

	//Default constructor
	-(id)init{
		_locations = [[NSMutableArray alloc] init];
		_edges = [[NSMutableArray alloc] init];
		[self initSquareBoard: SQUARE_BOARD_SIZE];
		return self;
	}

	//This function will set the width of the board as a rectangle
	-(void)initBoardWidth:(int) width{
		
		NSUInteger height = _locations.count;
		
		for(int i = 0; i < height; i++){
			_locations[i] = [[NSMutableArray alloc] init];
			
			//for each entry create node
			for(int j = 0; j < width; j++){
				
				//margin for sides, top, and bottom
				double sideMargin = 0.0;
				double bottemMargin = (1.0 / 3.0);
				double topMargin = 0.0;
				
				//these are normalized coordinates in (0,1) range
				double xNormal = (j + 1.0) / (width + 1.0);
				double yNormal = (i + 1.0) / (height + 1.0);
				
				//these are coordinates within (0,1) range with margins added
				double ypos = (yNormal + bottemMargin) / (1.0 + bottemMargin + topMargin);
				double xpos = (xNormal + sideMargin) / (1.0 + sideMargin);
				CGPoint pos = CGPointMake(xpos, ypos);
				
				//create and initialize each boardLocations in grid
				[((NSMutableArray*) _locations[i]) addObject: [[boardLocation alloc] init:pos]];
				
			}
		}
	}

	//This function will set the height of the board as a rectangle
	-(void)initBoardHeight:(int) height{
		for(int i = 0; i < height; i++){
			[_locations addObject:[[NSMutableArray alloc] init]];
		}
	}


	//This method will create the list of edge objects from the list of nodeObjects for default grid layouts
	-(void)generateGridEdges:(int)gridWidth withGridHeight:(int) gridHeight{
		
		//create array of size height and iterate each entry
		_edges = [NSMutableArray arrayWithCapacity:gridHeight];
		for(int i = 0; i < gridHeight; i++){
		
			//create array of size width at each entry and iterate each item in width
			_edges[i] = [NSMutableArray arrayWithCapacity:gridWidth];
			for(int j = 0; j < gridWidth; j++){
			
				//create empty array of edges at each 2d index
				_edges[i][j] = [[NSMutableArray alloc] init];
				
				//for each neighbor node at Chebyshev distance 1 with xoffset and yoffset of current node in grid
				for(int xoffset = -1; xoffset <= 1; xoffset++){
					for(int yoffset = -1; yoffset <= 1; yoffset++){
						
						//Check that neighbor node is not self
						if(xoffset != 0 || yoffset != 0){
							
							//get coordinates of potential neighbor
							int nx = j + xoffset;
							int ny = i + yoffset;
							
							//if neighbor is in bounds of width
							if(nx >= 0 && nx < gridWidth){
								//if neighbor is in bounds of height
								if(ny >= 0 && ny < gridHeight){
								
									//valid neighbor, create and add edge to edges
									edge* e = [[edge alloc] init:(_locations[ny][nx])];
									[_edges[i][j] addObject:e];
								}
							}
						}
					}
				}
			}
		}
	}



	//This function will load this object with an unused square board of the specified dimension
	-(void)initSquareBoard:(int) dimension{
		
		//creating all boardLocation objects
		[self initBoardHeight:dimension];
		[self initBoardWidth:dimension];
		
		//generate all the edges between nodes
		[self generateGridEdges:dimension withGridHeight:dimension];
	}

	//Method for adding nodes to scene
	-(void) addToView: (SKScene*) s{
	
		//add each board position
		for(int i = 0; i < _locations.count; i++){
			NSMutableArray* loci = ((NSMutableArray*)_locations[i]);
			for(int j = 0; j < loci.count; j++){
				boardLocation* bl = (boardLocation*)loci[j];
				SKNode* n = [bl createNode:s.size];
				[s addChild:n];
			}
		}
		
		//add each edge
		for(int i = 0; i < _edges.count; i++){
			NSMutableArray* ei = ((NSMutableArray*)_edges[i]);
			for(int j = 0; j < ei.count; j++){
				NSMutableArray* eij = (NSMutableArray*)ei[j];
				boardLocation* locij = (boardLocation*)(((NSMutableArray*)_locations[i])[j]);
				for(int k = 0; k < eij.count; k++){
					edge* ed = (edge*)eij[k];
					SKNode* n = [ed createNode:locij withDim: s.size ];
					
					if (n != nil){
						[s addChild:n];
					}
				}
			}
		}
	}

@end