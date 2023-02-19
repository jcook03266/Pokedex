// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension PokemonSchema {
  class GetStatsForPokemonQuery: GraphQLQuery {
    public static let operationName: String = "getStatsForPokemon"
    public static let document: ApolloAPI.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getStatsForPokemon($id: Int) {
          pokemon: pokemon_v2_pokemon(where: {id: {_eq: $id}}) {
            __typename
            name
            id
            height
            weight
            pokemon_v2_pokemonspecy {
              __typename
              name
              gender_rate
              pokemon_color_id
              pokemon_v2_pokemonegggroups {
                __typename
                pokemon_v2_egggroup {
                  __typename
                  name
                }
              }
            }
            pokemon_v2_pokemonabilities {
              __typename
              pokemon_v2_ability {
                __typename
                name
              }
            }
            pokemon_v2_pokemonstats {
              __typename
              pokemon_v2_stat {
                __typename
                name
              }
              base_stat
            }
            pokemon_v2_pokemontypes {
              __typename
              pokemon_v2_type {
                __typename
                name
              }
            }
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
        .field("pokemon_v2_pokemon", alias: "pokemon", [Pokemon].self, arguments: ["where": ["id": ["_eq": .variable("id")]]]),
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
          .field("height", Int?.self),
          .field("weight", Int?.self),
          .field("pokemon_v2_pokemonspecy", Pokemon_v2_pokemonspecy?.self),
          .field("pokemon_v2_pokemonabilities", [Pokemon_v2_pokemonability].self),
          .field("pokemon_v2_pokemonstats", [Pokemon_v2_pokemonstat].self),
          .field("pokemon_v2_pokemontypes", [Pokemon_v2_pokemontype].self),
        ] }

        public var name: String { __data["name"] }
        public var id: Int { __data["id"] }
        public var height: Int? { __data["height"] }
        public var weight: Int? { __data["weight"] }
        /// An object relationship
        public var pokemon_v2_pokemonspecy: Pokemon_v2_pokemonspecy? { __data["pokemon_v2_pokemonspecy"] }
        /// An array relationship
        public var pokemon_v2_pokemonabilities: [Pokemon_v2_pokemonability] { __data["pokemon_v2_pokemonabilities"] }
        /// An array relationship
        public var pokemon_v2_pokemonstats: [Pokemon_v2_pokemonstat] { __data["pokemon_v2_pokemonstats"] }
        /// An array relationship
        public var pokemon_v2_pokemontypes: [Pokemon_v2_pokemontype] { __data["pokemon_v2_pokemontypes"] }

        /// Pokemon.Pokemon_v2_pokemonspecy
        ///
        /// Parent Type: `Pokemon_v2_pokemonspecies`
        public struct Pokemon_v2_pokemonspecy: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonspecies }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("name", String.self),
            .field("gender_rate", Int?.self),
            .field("pokemon_color_id", Int?.self),
            .field("pokemon_v2_pokemonegggroups", [Pokemon_v2_pokemonegggroup].self),
          ] }

          public var name: String { __data["name"] }
          public var gender_rate: Int? { __data["gender_rate"] }
          public var pokemon_color_id: Int? { __data["pokemon_color_id"] }
          /// An array relationship
          public var pokemon_v2_pokemonegggroups: [Pokemon_v2_pokemonegggroup] { __data["pokemon_v2_pokemonegggroups"] }

          /// Pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonegggroup
          ///
          /// Parent Type: `Pokemon_v2_pokemonegggroup`
          public struct Pokemon_v2_pokemonegggroup: PokemonSchema.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonegggroup }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("pokemon_v2_egggroup", Pokemon_v2_egggroup?.self),
            ] }

            /// An object relationship
            public var pokemon_v2_egggroup: Pokemon_v2_egggroup? { __data["pokemon_v2_egggroup"] }

            /// Pokemon.Pokemon_v2_pokemonspecy.Pokemon_v2_pokemonegggroup.Pokemon_v2_egggroup
            ///
            /// Parent Type: `Pokemon_v2_egggroup`
            public struct Pokemon_v2_egggroup: PokemonSchema.SelectionSet {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_egggroup }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("name", String.self),
              ] }

              public var name: String { __data["name"] }
            }
          }
        }

        /// Pokemon.Pokemon_v2_pokemonability
        ///
        /// Parent Type: `Pokemon_v2_pokemonability`
        public struct Pokemon_v2_pokemonability: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonability }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("pokemon_v2_ability", Pokemon_v2_ability?.self),
          ] }

          /// An object relationship
          public var pokemon_v2_ability: Pokemon_v2_ability? { __data["pokemon_v2_ability"] }

          /// Pokemon.Pokemon_v2_pokemonability.Pokemon_v2_ability
          ///
          /// Parent Type: `Pokemon_v2_ability`
          public struct Pokemon_v2_ability: PokemonSchema.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_ability }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }
        }

        /// Pokemon.Pokemon_v2_pokemonstat
        ///
        /// Parent Type: `Pokemon_v2_pokemonstat`
        public struct Pokemon_v2_pokemonstat: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemonstat }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("pokemon_v2_stat", Pokemon_v2_stat?.self),
            .field("base_stat", Int.self),
          ] }

          /// An object relationship
          public var pokemon_v2_stat: Pokemon_v2_stat? { __data["pokemon_v2_stat"] }
          public var base_stat: Int { __data["base_stat"] }

          /// Pokemon.Pokemon_v2_pokemonstat.Pokemon_v2_stat
          ///
          /// Parent Type: `Pokemon_v2_stat`
          public struct Pokemon_v2_stat: PokemonSchema.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_stat }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }
        }

        /// Pokemon.Pokemon_v2_pokemontype
        ///
        /// Parent Type: `Pokemon_v2_pokemontype`
        public struct Pokemon_v2_pokemontype: PokemonSchema.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_pokemontype }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("pokemon_v2_type", Pokemon_v2_type?.self),
          ] }

          /// An object relationship
          public var pokemon_v2_type: Pokemon_v2_type? { __data["pokemon_v2_type"] }

          /// Pokemon.Pokemon_v2_pokemontype.Pokemon_v2_type
          ///
          /// Parent Type: `Pokemon_v2_type`
          public struct Pokemon_v2_type: PokemonSchema.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ApolloAPI.ParentType { PokemonSchema.Objects.Pokemon_v2_type }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("name", String.self),
            ] }

            public var name: String { __data["name"] }
          }
        }
      }
    }
  }

}