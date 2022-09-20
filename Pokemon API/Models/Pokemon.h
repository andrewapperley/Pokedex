//
//  Pokemon.h
//  Pokemon API
//
//  Created by Andrew Apperley on 2/14/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property(nonatomic) NSInteger identififer;
@property(nonatomic, nonnull) NSString *name;
@property(nonatomic, nonnull) NSString *sprite;
@property(nonatomic, nonnull) NSArray<NSString *> *types;

- (instancetype)initWithDictionary:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
