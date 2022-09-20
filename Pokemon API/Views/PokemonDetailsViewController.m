//
//  PokemonDetailsViewController.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/11/22.
//

#import "PokemonDetailsViewController.h"
#import "Pokemon.h"
#import "DetailsViewNode.h"

@interface PokemonDetailsViewController ()

@end

@implementation PokemonDetailsViewController

- (instancetype)initWitPokemon:(Pokemon *)pokemon {
    self  = [super initWithNode: [[DetailsViewNode alloc] initWithPokemon:pokemon]];
    if (self == nil) { return self; }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.node.backgroundColor = [UIColor whiteColor];
}

@end
