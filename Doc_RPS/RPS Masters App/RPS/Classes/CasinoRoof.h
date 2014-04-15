//
//  CasinoRoof.h
//  RPS
//
//  Created by chibitotoro on 12-05-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface CasinoRoof : Character

-(void) idle;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;

@end
