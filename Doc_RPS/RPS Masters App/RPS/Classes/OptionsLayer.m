//
//  OptionsLayer.m
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionsLayer.h"
#import "MainMenuLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation OptionsLayer
#pragma mark - OptionsLayer

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	OptionsLayer *layer = [OptionsLayer node];
	[scene addChild: layer];
	return scene;
}

#pragma mark INIT
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init])) {
        
        /*
         // schedule a repeating callback on every frame
         [self schedule:@selector(nextFrame:)];
         
         self.isTouchEnabled = YES;
         */
        
        
        // ask director the the window size
        //CGSize size = [[CCDirector sharedDirector] winSize];
                
        AppController * ad=(AppController*)[[UIApplication sharedApplication] delegate];
        
        sprBackground=[CCSprite spriteWithFile:@"options-bg.png"];
        sprBackground.position=ccp(240,160);
        [self addChild:sprBackground];

        sprHeader=[CCSprite spriteWithFile:@"options-header.png"];
        sprHeader.position=ccp(100,290);
        [self addChild:sprHeader];
        
        //Music Label
        lblMusic = [CCLabelTTF labelWithString:@"Music" fontName:@"ComixHeavy" fontSize:24];
        lblMusic.position =  ccp( 150, 235 );
        lblMusic.color=ccc3(0,0,0);
        [self addChild: lblMusic];
        
        //SFX Label
        lblSFX = [CCLabelTTF labelWithString:@"SFX" fontName:@"ComixHeavy" fontSize:24];
        lblSFX.position =  ccp( 150 , 180 );
        lblSFX.color=ccc3(0,0,0);
        [self addChild: lblSFX];

        
                
        // Return Button
        itmReturn = [CCMenuItemImage itemWithNormalImage:@"return-home.png" 
                                           selectedImage:@"return-home.png" 
                                                   block:^(id sender) {
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                       [[CCDirector sharedDirector] replaceScene:
                                                        [CCTransitionFade transitionWithDuration:0.5f scene:[MainMenuLayer scene]]];
                                                   }];    
        
        itmReturn.position=ccp(93,58);
        
        
        
        NSString * strSFXOnImage;
        
        if(ad.playingSFX) strSFXOnImage=@"on-selected.png";
        else strSFXOnImage=@"on.png";
        
        NSString * strSFXOffImage;
        if(ad.playingSFX) strSFXOffImage=@"off.png";
        else strSFXOffImage=@"off-selected.png";
        
        itmSFXOn = [CCMenuItemImage itemWithNormalImage:strSFXOnImage 
                                          selectedImage:strSFXOnImage
                                                  block:^(id sender) {
                                                      ad.playingSFX=true;
                                                      [[SimpleAudioEngine sharedEngine]setEffectsVolume:1];
                                                      
                                                      if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                      
                                                      [itmSFXOn setNormalImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                      
                                                      [itmSFXOn setSelectedImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                      
                                                      [itmSFXOff setNormalImage:[CCSprite spriteWithFile:@"off.png"]];
                                                      [itmSFXOff setSelectedImage:[CCSprite spriteWithFile:@"off.png"]];
                                                  }];    
        itmSFXOn.position=ccp(250,lblSFX.position.y);
        
        itmSFXOff = [CCMenuItemImage itemWithNormalImage:strSFXOffImage
                                           selectedImage:strSFXOffImage
                                                  block:^(id sender) {

                                                      ad.playingSFX=false;
                                                      [[SimpleAudioEngine sharedEngine]setEffectsVolume:0];
                                                      
                                                      [itmSFXOn setNormalImage:[CCSprite spriteWithFile:@"on.png"]];
                                                      
                                                      [itmSFXOn setSelectedImage:[CCSprite spriteWithFile:@"on.png"]];
                                                      
                                                      [itmSFXOff setNormalImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                      [itmSFXOff setSelectedImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                  }];  
        itmSFXOff.position=ccp(350,lblSFX.position.y);
        
        NSString * strMusicOnImage;

        if(ad.playingBGM) strMusicOnImage=@"on-selected.png";
        else strMusicOnImage=@"on.png";
        
        NSString * strMusicOffImage;
        if(ad.playingBGM) strMusicOffImage=@"off.png";
        else strMusicOffImage=@"off-selected.png";
        
        
        itmMusicOn = [CCMenuItemImage itemWithNormalImage:strMusicOnImage
                                            selectedImage:strMusicOnImage 
                                                    block:^(id sender) {
                                                        ad.playingBGM=true;
                                                        
                                                        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.4f];
                                                        
                                                        if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                        
                                                        [itmMusicOn setNormalImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                        
                                                        [itmMusicOn setSelectedImage:[CCSprite spriteWithFile:@"on-selected.png"]];
                                                        
                                                        [itmMusicOff setNormalImage:[CCSprite spriteWithFile:@"off.png"]];
                                                        [itmMusicOff setSelectedImage:[CCSprite spriteWithFile:@"off.png"]];
                                                        
                                                    }];   
        itmMusicOn.position=ccp(250,lblMusic.position.y);
        
        itmMusicOff = [CCMenuItemImage itemWithNormalImage:strMusicOffImage 
                                           selectedImage:strMusicOffImage 
                                                   block:^(id sender) {
                                                       ad.playingBGM=false;
                                                       [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0];
                                                       
                                                       if(ad.playingSFX) [[SimpleAudioEngine sharedEngine] playEffect:@"Select.mp3"]; 
                                                       
                                                       [itmMusicOn setNormalImage:[CCSprite spriteWithFile:@"on.png"]];
                                                       [itmMusicOn setSelectedImage:[CCSprite spriteWithFile:@"on.png"]];
                                                       
                                                       [itmMusicOff setNormalImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                       [itmMusicOff setSelectedImage:[CCSprite spriteWithFile:@"off-selected.png"]];
                                                   }];  
        itmMusicOff.position=ccp(350,lblMusic.position.y);

        
        
        menu = [CCMenu menuWithItems:itmReturn,itmMusicOn,itmMusicOff,itmSFXOff,itmSFXOn, nil];
        [menu setPosition:ccp(0,0)];
        
        // Add the menu to the layer
        [self addChild:menu];
        
        
	}
	return self;
}

-(void)dealloc{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super dealloc];
}
@end
