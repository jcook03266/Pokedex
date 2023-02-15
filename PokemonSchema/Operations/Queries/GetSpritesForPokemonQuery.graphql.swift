// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension PokemonSchema {
  class GetSpritesForPokemonQuery: GraphQLQuery {
    public static let operationName: String = "getSpritesForPokemon"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getSpritesForPokemon($id: Int) {
          pokemonSprites: pokemon_v2_pokemonsprites(where: {id: {_eq: $id}}) {
            __typename
            sprites
          }
        }
        """#
      ))

    public var id: GraphQLNullable<Int>

    public init(id: GraphQLNullable<Int>) {
      self.id = id
    }

    public var __variables: Variables? { ["id": id] }

    public struct Data: PokemonSchema.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Query_root }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("pokemon_v2_pokemonsprites", alias: "pokemonSprites", [PokemonSprite].self, arguments: ["where": ["id": ["_eq": .variable("id")]]]),
      ] }

      /// An array relationship
      public var pokemonSprites: [PokemonSprite] { __data["pokemonSprites"] }

      /// PokemonSprite
      ///
      /// Parent Type: `Pokemon_v2_pokemonsprites`
      public struct PokemonSprite: PokemonSchema.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonsprites }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("sprites", String.self),
        ] }

        public var sprites: String { __data["sprites"] }
      }
    }
  }

}