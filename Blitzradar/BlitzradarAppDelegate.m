//
//  BlitzradarAppDelegate.m
//  Blitzradar
//
//  Created by jrk on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlitzradarAppDelegate.h"
#if 0
//***************************************************************************************************************//
//***************************************************************************************************************//
//***************************************************************************************************************//
/****************************************************************************************************************
 Endianness is the byte ordering used to deal with multi-byte data. Endianess is the order in which
 multi-byte(WORD=short, DWORD=unsigned int,unsigned long) values are stored as bytes in computer 
 memory and  transmitted over a network or other medium. Here we will go through a C-Level code to 
 check endianality of a target platform.
 
 *****************************************************************************************************************/
#include <stdio.h>
#define DWORDSZ 32/8 // assuming target architecture is 32-bit = 4-Bytes

typedef enum ENDIANESS { LITTLEENDIAN , BIGENDIAN , UNHANDLE } ENDIANESS; 


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ENDIANESS CheckArchEndianalityV1( void )
{
	
    int Endian = 0x00000001; // assuming target architecture is 32-bit     
    
    // as Endian = 0x00000001 so MSB (Most Significant Byte) = 0x00 and LSB (Least Significant Byte) = 0x01     
	// casting down to a single byte value LSB discarding higher bytes     
	
    return (*(char *) &Endian == 0x01) ? LITTLEENDIAN : BIGENDIAN;
} 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

ENDIANESS CheckArchEndianalityV2( void )
{
	
    ENDIANESS ARCH = UNHANDLE; // middle-endian, bi-endian and anything else except Big & Little endian is not handled     
    
    union 
	{                 
		char MultiByte[DWORDSZ]; // assuming target architecture is 32-bit = 4Byte
		
		long INTVal;
		
	}RegMemOrg;
	
	
	
	
	
    printf("\n [Base] Address of RegMemOrg.MultiByte = %x",RegMemOrg.MultiByte);
    printf("\n Address of RegMemOrg.INTVal = %x",&RegMemOrg.INTVal);
    printf("\n Size of RegMemOrg.MultiByte = %d Bytes",sizeof(RegMemOrg.MultiByte));
    printf("\n Size of RegMemOrg.INTVal = %d Bytes",sizeof(RegMemOrg.INTVal));
    printf("\n Size of RegMemOrg = %d Bytes",sizeof(RegMemOrg));
    RegMemOrg.INTVal = 0x41424344; // ABCD i.e A=[MSB] ..... D=[LSB]
	
    // ASCII value of A is 65 = 0x41 , B is 66 = 0x42, C is 67 = 0x43 and D is 68 = 0x44     
	
    printf("\n Value stored in RegMemOrg.INTVal (HEX)= %x ",RegMemOrg.INTVal);
	
    // In BigEndian MSB is stored at lowest address and LSB is stored at Highest address     
    // and in LittleEndian MSB is stored at High Address and LSB is stored at LowAddress     
    
    printf("\n MultiByte[0]=%c,MultiByte[1]=%c,MultiByte[2]=%c,MultiByte[3]=%c ",RegMemOrg.MultiByte[0],RegMemOrg.MultiByte[1],RegMemOrg.MultiByte[2],RegMemOrg.MultiByte[3]);     
    
    if( RegMemOrg.MultiByte[0] == 'A' && RegMemOrg.MultiByte[1]== 'B' && RegMemOrg.MultiByte[2] == 'C' && RegMemOrg.MultiByte[3] == 'D')         
        
        ARCH = BIGENDIAN; // Big-Endian Host;     
    
    else if( RegMemOrg.MultiByte[0] == 'D' && RegMemOrg.MultiByte[1]== 'C' && RegMemOrg.MultiByte[2] == 'B' && RegMemOrg.MultiByte[3] == 'A')         
        
        ARCH = LITTLEENDIAN; // Little-Endian Host     
    
    return ARCH;
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//***************************************************************************************************************//
//***************************************************************************************************************//

//***************************************************************************************************************//




#endif
@implementation BlitzradarAppDelegate


@synthesize window=_window;

@synthesize tabBarController=_tabBarController;
//#define mkword(lo, hi) \
//	((uint16_t)((uint8_t)(lo)) | (((uint16_t)(uint8_t)(hi))<<8))

#define mkword(lo, hi) \
	((uint16_t)((uint8_t)(hi)) | (((uint16_t)(uint8_t)(lo))<<8))

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if 0
	uint16_t i = mkword(0x7, 0x20);
	
	printf("%.4x\n", i);
	ENDIANESS ARCH = UNHANDLE; // middle-endian, bi-endian and anything else except Big & Little endian is not handled
    int RetCode = 0; //success     
	
    printf("\n Testing Through Version-I");     
    CheckArchEndianalityV1() ? printf("\n Big Endian Host i.e [SPARC|Motorola|PowerPC|MIPS]\n") : printf("\n Little Endian Host i.e [Intel-X86|DEC|MIPS] \n") ;     
    printf("\n Testing Through Version-II");     
    
    ARCH = CheckArchEndianalityV2();     
    if ( ARCH == BIGENDIAN )         
		
        printf("\n Big Endian Host i.e [SPARC|PDP-II|Motorola|PowerPC|MIPS]\n");     
	
    else if ( ARCH == LITTLEENDIAN )         
		
        printf("\n Little Endian Host i.e [Intel-X86|DEC|MIPS] \n");     
	
    else
    {
		
        printf("\n middle-endian, bi-endian and anything else except Big & Little endian is not handled\n");         
        RetCode = 1; //Un-Handled case, failure
    }
	
#endif
	
	NSDictionary *d = [NSDictionary dictionaryWithObject: [NSNumber numberWithBool: YES] forKey: @"aktu"];
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	[defs registerDefaults: d];
	
	
	// Override point for customization after application launch.
	// Add the tab bar controller's current view as a subview of the window
	self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

- (void)dealloc
{
	[_window release];
	[_tabBarController release];
    [super dealloc];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
