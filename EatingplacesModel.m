//
//  EatingplacesModel.m
//  WhereToEat
//
//  Created by Yu Xin on 4/16/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "EatingplacesModel.h"

static NSString * const kNameKey = @"name";
static NSString * const kAddressKey = @"address";

// Class Extension
@interface EatingplacesModel()

// Private Properties
@property (nonatomic, strong) NSMutableArray *eatingplaces;
@property (nonatomic, strong) NSString *filePath;



@end

@implementation EatingplacesModel

// Create an init method in the implementation to initialize the model
-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        // get directory of documents folders
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        // create file name for file
        NSString  *fileName = @"eatingplaces.plist";
        
        // save NSArray to file path
        _filePath = [NSString  stringWithFormat:@"%@/%@", path, fileName];
        NSArray *eatingDicts = [[NSArray alloc] initWithContentsOfFile:_filePath];
        
        NSLog(@"Path: %@", _filePath);
        
        if (eatingDicts)
        {
            NSArray *eatingplaces = [self convertDictIntoPlaces:eatingDicts];
            _eatingplaces = [eatingplaces mutableCopy];
        }
        else
        {
            Eatingplace *eatingplace0 = [[Eatingplace alloc] initWithName:@"Blaze Pizza" address:@"3335 S Figueroa St Los Angeles, CA 90007"];
            Eatingplace *eatingplace1 = [[Eatingplace alloc] initWithName:@"Five Star SeaFood Restaurant" address:@"140 W Valley Blvd, San Gabriel, CA 91776"];
            Eatingplace *eatingplace2 = [[Eatingplace alloc] initWithName:@"Lady M" address:@"8718 W 3rd St, Los Angeles, CA 90048"];
            Eatingplace *eatingplace3 = [[Eatingplace alloc] initWithName:@"Kismet" address:@"4648 Hollywood Blvd, Los Angeles, CA 90027"];
            Eatingplace *eatingplace4 = [[Eatingplace alloc] initWithName:@"The Venue" address:@"3470 Wilshire Blvd, Los Angeles, CA 90010"];
            Eatingplace *eatingplace5 = [[Eatingplace alloc] initWithName:@"Chengdu Impression" address:@"21 E Huntington Dr, Arcadia, CA 91006"];
            Eatingplace *eatingplace6 = [[Eatingplace alloc] initWithName:@"Kato" address:@"11925 Santa Monica Blvd, Los Angeles, CA 90025"];
            Eatingplace *eatingplace7 = [[Eatingplace alloc] initWithName:@"Fat Dragon" address:@"3500 W Sunset Blvd, Los Angeles, CA 90026"];
            
            _eatingplaces = [[NSMutableArray alloc] initWithObjects:eatingplace0, eatingplace1, eatingplace2, eatingplace3, eatingplace4, eatingplace5, eatingplace6, eatingplace7, nil];
        }
        _currentIndex = 0;
        
        [self save];
    }
    
    return self;
}

// Creating the model
+(instancetype)sharedModel
{
    static EatingplacesModel *eatingplacesModel = nil;
    
    // GCD - Grand Central Dispatch
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        eatingplacesModel = [[EatingplacesModel alloc] init];
    });
    return eatingplacesModel;
}

// Accessing the number of eatingplaces in model
-(NSUInteger)numberOfEatingplaces
{
    return self.eatingplaces.count;
}

// Accessing an eatingplace
-(Eatingplace*)eatingplaceAtIndex:(NSUInteger)index
{
    return self.eatingplaces[index];
}

// Inserting an eatingplace
-(void)insertWithName:(NSString*)name address:(NSString*)addr
{
    Eatingplace* eatingplaceInserted = [[Eatingplace alloc] initWithName:name address:addr];
    [self.eatingplaces addObject:eatingplaceInserted];
    
    [self save];
}

-(void)insertWithName:(NSString *)name address:(NSString *)addr atIndex:(NSUInteger)index
{
    if (!(index > self.eatingplaces.count))
    {
        Eatingplace* eatingplaceInserted = [[Eatingplace alloc] initWithName:name address:addr];
        [self.eatingplaces insertObject:eatingplaceInserted atIndex:index];
    }
    
    [self save];
}

// Removing an eatingplace
-(void)removeEatingplace
{
    if (self.eatingplaces.count >= 1)
    {
        [self.eatingplaces removeLastObject];
    }
    
    [self save];
}

-(void)removeEatingplaceAtIndex:(NSUInteger)index
{
    if (index < self.eatingplaces.count)
    {
        [self.eatingplaces removeObjectAtIndex:index];
    }
    
    [self save];
}


-(void)save
{
    NSArray *eatingDicts = [self convertPlacesIntoDict:self.eatingplaces];
    [eatingDicts writeToFile:self.filePath atomically:YES];
}

-(NSArray*) convertPlacesIntoDict:(NSArray*)eatingPlaces
{
    NSMutableArray *retVal = [NSMutableArray array];
    for (int i=0; i<eatingPlaces.count; i++)
    {
        NSDictionary *eatingDict = [[NSDictionary alloc] initWithObjectsAndKeys:[eatingPlaces[i] name], kNameKey, [eatingPlaces[i] address], kAddressKey, nil];
        [retVal addObject:eatingDict];
    }
    
    return [NSArray arrayWithArray:retVal];
}

-(NSArray*) convertDictIntoPlaces:(NSArray*)eatingDicts
{
    NSMutableArray *retVal = [NSMutableArray array];
    for (int i=0; i<eatingDicts.count; i++)
    {
        Eatingplace *eatingplace = [[Eatingplace alloc] initWithName:[eatingDicts[i] objectForKey:kNameKey] address:[eatingDicts[i] objectForKey:kAddressKey]];
        [retVal addObject:eatingplace];
    }
    
    return [NSArray arrayWithArray:retVal];
}


@end














