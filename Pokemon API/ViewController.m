//
//  ViewController.m
//  Pokemon API
//
//  Created by Andrew Apperley on 2/11/22.
//

#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "APIClient.h"
#import "Pokemon.h"
#import "ListCellNode.h"
#import "PokemonDetailsViewController.h"

@interface ViewController () <ASTableDataSource, ASTableDelegate>

@property (nonatomic, copy) NSArray<Pokemon *> *pokemon;
@property (nonatomic) NSInteger currentOffset;

@end

@implementation ViewController

- (instancetype)init {
    self = [super initWithNode: [ASTableNode new]];
    if (self == nil) { return self; }
    
    self.pokemon = @[];
    self.currentOffset = 1;
    return self;
}

- (void)dealloc {
    self.node.delegate = nil;
    self.node.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Pokedex";
    
    self.node.delegate = self;
    self.node.dataSource = self;
    
    [self requestNextPokemonWithCompletionHandler:^{
        [self.node reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.node deselectRowAtIndexPath: self.node.indexPathForSelectedRow animated: animated];
}

- (void)requestNextPokemonWithCompletionHandler:(void (^)(void))completion {
    __block ViewController *blockSelf = self;
    [[APIClient shared] requestPokemonListWithOffset:self.currentOffset andLimit:9 andCompletionHandler:^(NSInteger newOffset, NSArray<Pokemon *> * _Nullable pokemon) {
        blockSelf.pokemon = pokemon;
        blockSelf.currentOffset = newOffset;
        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    }];
}

#pragma mark - TableDatasource / TableDelegate

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Pokemon *pokemon = self.pokemon[indexPath.row];
    
    return ^{
        ListCellNode *listCellNode = [[ListCellNode alloc] initWithPokemon:pokemon];
        return listCellNode;
    };
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Pokemon *pokemon = self.pokemon[indexPath.row];
    PokemonDetailsViewController *details = [[PokemonDetailsViewController alloc] initWitPokemon:pokemon];
    [self.navigationController presentViewController:details animated:YES completion:nil];
}

@end
