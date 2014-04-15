//
//  Chef.h
//  RPS
//
//  Created by chibitotoro on 12-05-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface Chef : Character{
    
}
-(void) idle;
-(void) addCharacterToLayer:(CCLayer*) layer atX:(float)x atY:(float)y isFlipped:(bool)flip;

@end
