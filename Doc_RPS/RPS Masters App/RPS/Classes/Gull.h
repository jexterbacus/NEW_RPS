//
//  Gull.h
//  RPS
//
//  Created by chibitotoro on 12-05-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface Gull : Character
-(void) idle;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;

@end
