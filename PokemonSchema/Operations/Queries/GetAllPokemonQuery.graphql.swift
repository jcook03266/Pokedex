// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension PokemonSchema {
  class GetAllPokemonQuery: GraphQLQuery {
    public static let operationName: String = "getAllPokemon"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getAllPokemon {
          pokemon: pokemon_v2_pokemon(order_by: {id: asc}) {
            __typename
            name
            id
            types: pokemon_v2_pokemontypes {
              __typename
              pokemon_v2_type {
                __typename
                pokemonType: name
              }
            }
            speciesColorID: pokemon_v2_pokemonspecy {
              __typename
              id: pokemon_color_id
            }
          }
        }
        """#
      ))

    public init() {}

    public struct Data: PokemonSchema.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Query_root }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("pokemon_v2_pokemon", alias: "pokemon", [Pokemon].self, arguments: ["order_by": ["id": "asc"]]),
      ] }

      /// fetch data from the table: "pokemon_v2_pokemon"
      public var pokemon: [Pokemon] { __data["pokemon"] }

      /// Pokemon
      ///
      /// Parent Type: `Pokemon_v2_pokemon`
      public struct Pokemon: PokemonSchema.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemon }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("name", String.self),
          .field("id", Int.self),
          .field("pokemon_v2_pokemontypes", alias: "types", [Type_SelectionSet].self),
          .field("pokemon_v2_pokemonspecy", alias: "speciesColorID", SpeciesColorID?.self),
        ] }

        public var name: String { __data["name"] }
        public var id: Int { __data["id"] }
        /// An array relationship
        public var types: [Type_SelectionSet] { __data["types"] }
        /// An object relationship
        public var speciesColorID: SpeciesColorID? { __data["speciesColorID"] }

        /// Pokemon.Type_SelectionSet
        ///
        /// Parent Type: `Pokemon_v2_pokemontype`
        public struct Type_SelectionSet: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemontype }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("pokemon_v2_type", Pokemon_v2_type?.self),
          ] }

          /// An object relationship
          public var pokemon_v2_type: Pokemon_v2_type? { __data["pokemon_v2_type"] }

          /// Pokemon.Type_SelectionSet.Pokemon_v2_type
          ///
          /// Parent Type: `Pokemon_v2_type`
          public struct Pokemon_v2_type: PokemonSchema.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_type }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("name", alias: "pokemonType", String.self),
            ] }

            public var pokemonType: String { __data["pokemonType"] }
          }
        }

        /// Pokemon.SpeciesColorID
        ///
        /// Parent Type: `Pokemon_v2_pokemonspecies`
        public struct SpeciesColorID: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonspecies }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("pokemon_color_id", alias: "id", Int?.self),
          ] }

          public var id: Int? { __data["id"] }
        }
      }
    }
  }

}