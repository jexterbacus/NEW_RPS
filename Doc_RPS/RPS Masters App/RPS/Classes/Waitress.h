//
//  Waitress.h
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface Waitress : Character{
    NSMutableArray *anfCollectLeft;                //idle animation frames
    NSMutableArray *anfCollectRight;                //idle animation frames
    CCAnimation * aniCollectLeft;
    CCAnimation * aniCollectRight;    
    CCAction * actCollectLeft;
    CCAction * actCollectRight;    
}
-(void) idle;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;
-(void) collectLeft;
-(void) collectRight;

@end
