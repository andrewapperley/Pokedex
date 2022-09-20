//
//  PokemonDetailsViewController.h
//  Pokemon API
//
//  Created by Andrew Apperley on 2/11/22.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class Pokemon;

NS_ASSUME_NONNULL_BEGIN

@interface PokemonDetailsViewController : ASDKViewController

- (instancetype)initWitPokemon:(Pokemon *)pokemon;

@end

NS_ASSUME_NONNULL_END
