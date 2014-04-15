//
//  Casino.h
//  RPS
//
//  Created by chibitotoro on 12-05-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stage.h"
#import "CasinoRoof.h"
#import "Glow.h"
#import "Sign.h"
#import "SlotLeft.h"
#import "SlotRight.h"
#import "Lever.h"
#import "BunnyGirl.h"
#import "Grandma.h"
#import "CatGirl.h"
#import "BusinessMan.h"
#import "Tycoon.h"

@interface Casino : Stage{
    CasinoRoof * roof;
    CCSprite * machine;
    Glow * glow;
    Sign * sign;
    SlotLeft * slotLeft;
    SlotRight * slotRight;
    Lever * lever;
    BunnyGirl * bunnyGirl;
    CatGirl * catGirl;
    Grandma * grandma;
    BusinessMan * businessMan;
    Tycoon * tycoon;
}

@property (nonatomic,assign) Tycoon * tycoon;
@property (nonatomic,assign) CasinoRoof * roof;
@property (nonatomic,assign) Glow * glow;
@property (nonatomic,assign) Lever * lever;
@property (nonatomic,assign) SlotLeft * slotLeft;
@property (nonatomic,assign) SlotRight * slotRight;
@property (nonatomic,assign) CCSprite * machine;
@property (nonatomic,assign) Sign * sign;
@property (nonatomic,assign) BunnyGirl * bunnyGirl;
@property (nonatomic,assign) CatGirl * catGirl;
@property (nonatomic,assign) Grandma * grandma;
@property (nonatomic,assign) BusinessMan * businessMan;
-(void) pause;
-(void) resume;

@end
