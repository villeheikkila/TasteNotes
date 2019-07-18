/**
 * This file was automatically generated by GraphQL Nexus
 * Do not make changes to this file directly
 */

import * as types from "../types/index"




declare global {
  interface NexusGen extends NexusGenTypes {}
}

export interface NexusGenInputs {
  CheckinWhereInput: { // input type
    AND?: NexusGenInputs['CheckinWhereInput'][] | null; // [CheckinWhereInput!]
    author?: NexusGenInputs['UserWhereInput'] | null; // UserWhereInput
    comment?: string | null; // String
    comment_contains?: string | null; // String
    comment_ends_with?: string | null; // String
    comment_gt?: string | null; // String
    comment_gte?: string | null; // String
    comment_in?: string[] | null; // [String!]
    comment_lt?: string | null; // String
    comment_lte?: string | null; // String
    comment_not?: string | null; // String
    comment_not_contains?: string | null; // String
    comment_not_ends_with?: string | null; // String
    comment_not_in?: string[] | null; // [String!]
    comment_not_starts_with?: string | null; // String
    comment_starts_with?: string | null; // String
    createdAt?: any | null; // DateTime
    createdAt_gt?: any | null; // DateTime
    createdAt_gte?: any | null; // DateTime
    createdAt_in?: any[] | null; // [DateTime!]
    createdAt_lt?: any | null; // DateTime
    createdAt_lte?: any | null; // DateTime
    createdAt_not?: any | null; // DateTime
    createdAt_not_in?: any[] | null; // [DateTime!]
    id?: string | null; // ID
    id_contains?: string | null; // ID
    id_ends_with?: string | null; // ID
    id_gt?: string | null; // ID
    id_gte?: string | null; // ID
    id_in?: string[] | null; // [ID!]
    id_lt?: string | null; // ID
    id_lte?: string | null; // ID
    id_not?: string | null; // ID
    id_not_contains?: string | null; // ID
    id_not_ends_with?: string | null; // ID
    id_not_in?: string[] | null; // [ID!]
    id_not_starts_with?: string | null; // ID
    id_starts_with?: string | null; // ID
    NOT?: NexusGenInputs['CheckinWhereInput'][] | null; // [CheckinWhereInput!]
    OR?: NexusGenInputs['CheckinWhereInput'][] | null; // [CheckinWhereInput!]
    product?: NexusGenInputs['ProductWhereInput'] | null; // ProductWhereInput
    rating?: number | null; // Int
    rating_gt?: number | null; // Int
    rating_gte?: number | null; // Int
    rating_in?: number[] | null; // [Int!]
    rating_lt?: number | null; // Int
    rating_lte?: number | null; // Int
    rating_not?: number | null; // Int
    rating_not_in?: number[] | null; // [Int!]
    updatedAt?: any | null; // DateTime
    updatedAt_gt?: any | null; // DateTime
    updatedAt_gte?: any | null; // DateTime
    updatedAt_in?: any[] | null; // [DateTime!]
    updatedAt_lt?: any | null; // DateTime
    updatedAt_lte?: any | null; // DateTime
    updatedAt_not?: any | null; // DateTime
    updatedAt_not_in?: any[] | null; // [DateTime!]
  }
  ProductWhereInput: { // input type
    AND?: NexusGenInputs['ProductWhereInput'][] | null; // [ProductWhereInput!]
    checkins_every?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    checkins_none?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    checkins_some?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    id?: string | null; // ID
    id_contains?: string | null; // ID
    id_ends_with?: string | null; // ID
    id_gt?: string | null; // ID
    id_gte?: string | null; // ID
    id_in?: string[] | null; // [ID!]
    id_lt?: string | null; // ID
    id_lte?: string | null; // ID
    id_not?: string | null; // ID
    id_not_contains?: string | null; // ID
    id_not_ends_with?: string | null; // ID
    id_not_in?: string[] | null; // [ID!]
    id_not_starts_with?: string | null; // ID
    id_starts_with?: string | null; // ID
    name?: string | null; // String
    name_contains?: string | null; // String
    name_ends_with?: string | null; // String
    name_gt?: string | null; // String
    name_gte?: string | null; // String
    name_in?: string[] | null; // [String!]
    name_lt?: string | null; // String
    name_lte?: string | null; // String
    name_not?: string | null; // String
    name_not_contains?: string | null; // String
    name_not_ends_with?: string | null; // String
    name_not_in?: string[] | null; // [String!]
    name_not_starts_with?: string | null; // String
    name_starts_with?: string | null; // String
    NOT?: NexusGenInputs['ProductWhereInput'][] | null; // [ProductWhereInput!]
    OR?: NexusGenInputs['ProductWhereInput'][] | null; // [ProductWhereInput!]
    producer?: string | null; // String
    producer_contains?: string | null; // String
    producer_ends_with?: string | null; // String
    producer_gt?: string | null; // String
    producer_gte?: string | null; // String
    producer_in?: string[] | null; // [String!]
    producer_lt?: string | null; // String
    producer_lte?: string | null; // String
    producer_not?: string | null; // String
    producer_not_contains?: string | null; // String
    producer_not_ends_with?: string | null; // String
    producer_not_in?: string[] | null; // [String!]
    producer_not_starts_with?: string | null; // String
    producer_starts_with?: string | null; // String
    type?: string | null; // String
    type_contains?: string | null; // String
    type_ends_with?: string | null; // String
    type_gt?: string | null; // String
    type_gte?: string | null; // String
    type_in?: string[] | null; // [String!]
    type_lt?: string | null; // String
    type_lte?: string | null; // String
    type_not?: string | null; // String
    type_not_contains?: string | null; // String
    type_not_ends_with?: string | null; // String
    type_not_in?: string[] | null; // [String!]
    type_not_starts_with?: string | null; // String
    type_starts_with?: string | null; // String
  }
  UserWhereInput: { // input type
    admin?: boolean | null; // Boolean
    admin_not?: boolean | null; // Boolean
    AND?: NexusGenInputs['UserWhereInput'][] | null; // [UserWhereInput!]
    checkins_every?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    checkins_none?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    checkins_some?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    email?: string | null; // String
    email_contains?: string | null; // String
    email_ends_with?: string | null; // String
    email_gt?: string | null; // String
    email_gte?: string | null; // String
    email_in?: string[] | null; // [String!]
    email_lt?: string | null; // String
    email_lte?: string | null; // String
    email_not?: string | null; // String
    email_not_contains?: string | null; // String
    email_not_ends_with?: string | null; // String
    email_not_in?: string[] | null; // [String!]
    email_not_starts_with?: string | null; // String
    email_starts_with?: string | null; // String
    firstName?: string | null; // String
    firstName_contains?: string | null; // String
    firstName_ends_with?: string | null; // String
    firstName_gt?: string | null; // String
    firstName_gte?: string | null; // String
    firstName_in?: string[] | null; // [String!]
    firstName_lt?: string | null; // String
    firstName_lte?: string | null; // String
    firstName_not?: string | null; // String
    firstName_not_contains?: string | null; // String
    firstName_not_ends_with?: string | null; // String
    firstName_not_in?: string[] | null; // [String!]
    firstName_not_starts_with?: string | null; // String
    firstName_starts_with?: string | null; // String
    friends_every?: NexusGenInputs['UserWhereInput'] | null; // UserWhereInput
    friends_none?: NexusGenInputs['UserWhereInput'] | null; // UserWhereInput
    friends_some?: NexusGenInputs['UserWhereInput'] | null; // UserWhereInput
    id?: string | null; // ID
    id_contains?: string | null; // ID
    id_ends_with?: string | null; // ID
    id_gt?: string | null; // ID
    id_gte?: string | null; // ID
    id_in?: string[] | null; // [ID!]
    id_lt?: string | null; // ID
    id_lte?: string | null; // ID
    id_not?: string | null; // ID
    id_not_contains?: string | null; // ID
    id_not_ends_with?: string | null; // ID
    id_not_in?: string[] | null; // [ID!]
    id_not_starts_with?: string | null; // ID
    id_starts_with?: string | null; // ID
    lastName?: string | null; // String
    lastName_contains?: string | null; // String
    lastName_ends_with?: string | null; // String
    lastName_gt?: string | null; // String
    lastName_gte?: string | null; // String
    lastName_in?: string[] | null; // [String!]
    lastName_lt?: string | null; // String
    lastName_lte?: string | null; // String
    lastName_not?: string | null; // String
    lastName_not_contains?: string | null; // String
    lastName_not_ends_with?: string | null; // String
    lastName_not_in?: string[] | null; // [String!]
    lastName_not_starts_with?: string | null; // String
    lastName_starts_with?: string | null; // String
    NOT?: NexusGenInputs['UserWhereInput'][] | null; // [UserWhereInput!]
    OR?: NexusGenInputs['UserWhereInput'][] | null; // [UserWhereInput!]
    password?: string | null; // String
    password_contains?: string | null; // String
    password_ends_with?: string | null; // String
    password_gt?: string | null; // String
    password_gte?: string | null; // String
    password_in?: string[] | null; // [String!]
    password_lt?: string | null; // String
    password_lte?: string | null; // String
    password_not?: string | null; // String
    password_not_contains?: string | null; // String
    password_not_ends_with?: string | null; // String
    password_not_in?: string[] | null; // [String!]
    password_not_starts_with?: string | null; // String
    password_starts_with?: string | null; // String
  }
}

export interface NexusGenEnums {
  CheckinOrderByInput: "comment_ASC" | "comment_DESC" | "createdAt_ASC" | "createdAt_DESC" | "id_ASC" | "id_DESC" | "rating_ASC" | "rating_DESC" | "updatedAt_ASC" | "updatedAt_DESC"
  MutationType: "CREATED" | "DELETED" | "UPDATED"
}

export interface NexusGenRootTypes {
  AuthPayload: { // root type
    token?: string | null; // String
    user?: NexusGenRootTypes['User'] | null; // User
  }
  Checkin: { // root type
    comment: string; // String!
    createdAt: any; // DateTime!
    id: string; // ID!
    rating: number; // Int!
    updatedAt: any; // DateTime!
  }
  Mutation: {};
  Product: { // root type
    id: string; // ID!
    name: string; // String!
    producer?: string | null; // String
    type?: string | null; // String
  }
  ProductPreviousValues: { // root type
    id: string; // ID!
    name: string; // String!
    producer?: string | null; // String
    type?: string | null; // String
  }
  ProductSubscriptionPayload: { // root type
    mutation: NexusGenEnums['MutationType']; // MutationType!
    node?: NexusGenRootTypes['Product'] | null; // Product
    previousValues?: NexusGenRootTypes['ProductPreviousValues'] | null; // ProductPreviousValues
    updatedFields?: string[] | null; // [String!]
  }
  Query: {};
  Subscription: {};
  User: { // root type
    admin: boolean; // Boolean!
    email?: string | null; // String
    firstName: string; // String!
    id: string; // ID!
    lastName: string; // String!
  }
  UserPreviousValues: { // root type
    admin: boolean; // Boolean!
    email?: string | null; // String
    firstName: string; // String!
    id: string; // ID!
    lastName: string; // String!
    password: string; // String!
  }
  UserSubscriptionPayload: { // root type
    mutation: NexusGenEnums['MutationType']; // MutationType!
    node?: NexusGenRootTypes['User'] | null; // User
    previousValues?: NexusGenRootTypes['UserPreviousValues'] | null; // UserPreviousValues
    updatedFields?: string[] | null; // [String!]
  }
  String: string;
  Int: number;
  Float: number;
  Boolean: boolean;
  ID: string;
  DateTime: any;
}

export interface NexusGenAllTypes extends NexusGenRootTypes {
  CheckinWhereInput: NexusGenInputs['CheckinWhereInput'];
  ProductWhereInput: NexusGenInputs['ProductWhereInput'];
  UserWhereInput: NexusGenInputs['UserWhereInput'];
  CheckinOrderByInput: NexusGenEnums['CheckinOrderByInput'];
  MutationType: NexusGenEnums['MutationType'];
}

export interface NexusGenFieldTypes {
  AuthPayload: { // field return type
    token: string | null; // String
    user: NexusGenRootTypes['User'] | null; // User
  }
  Checkin: { // field return type
    author: NexusGenRootTypes['User']; // User!
    comment: string; // String!
    createdAt: any; // DateTime!
    id: string; // ID!
    product: NexusGenRootTypes['Product']; // Product!
    rating: number; // Int!
    updatedAt: any; // DateTime!
  }
  Mutation: { // field return type
    addProduct: NexusGenRootTypes['Product'] | null; // Product
    createCheckin: NexusGenRootTypes['Checkin'] | null; // Checkin
    deleteCheckin: NexusGenRootTypes['Checkin'] | null; // Checkin
    deleteProduct: NexusGenRootTypes['Product'] | null; // Product
    deleteUser: NexusGenRootTypes['User'] | null; // User
    login: NexusGenRootTypes['AuthPayload'] | null; // AuthPayload
    signup: NexusGenRootTypes['AuthPayload'] | null; // AuthPayload
    updateProduct: NexusGenRootTypes['Product'] | null; // Product
    updateUser: NexusGenRootTypes['User'] | null; // User
  }
  Product: { // field return type
    checkins: NexusGenRootTypes['Checkin'][] | null; // [Checkin!]
    id: string; // ID!
    name: string; // String!
    producer: string | null; // String
    type: string | null; // String
  }
  ProductPreviousValues: { // field return type
    id: string; // ID!
    name: string; // String!
    producer: string | null; // String
    type: string | null; // String
  }
  ProductSubscriptionPayload: { // field return type
    mutation: NexusGenEnums['MutationType']; // MutationType!
    node: NexusGenRootTypes['Product'] | null; // Product
    previousValues: NexusGenRootTypes['ProductPreviousValues'] | null; // ProductPreviousValues
    updatedFields: string[] | null; // [String!]
  }
  Query: { // field return type
    checkin: NexusGenRootTypes['Checkin'][] | null; // [Checkin!]
    checkins: NexusGenRootTypes['Checkin'][] | null; // [Checkin!]
    me: NexusGenRootTypes['User'] | null; // User
    product: NexusGenRootTypes['Product'][] | null; // [Product!]
    products: NexusGenRootTypes['Product'][] | null; // [Product!]
    user: NexusGenRootTypes['User'][] | null; // [User!]
    users: NexusGenRootTypes['User'][] | null; // [User!]
  }
  Subscription: { // field return type
    product: NexusGenRootTypes['ProductSubscriptionPayload'] | null; // ProductSubscriptionPayload
    user: NexusGenRootTypes['UserSubscriptionPayload'] | null; // UserSubscriptionPayload
  }
  User: { // field return type
    admin: boolean; // Boolean!
    checkins: NexusGenRootTypes['Checkin'][] | null; // [Checkin!]
    email: string | null; // String
    firstName: string; // String!
    id: string; // ID!
    lastName: string; // String!
  }
  UserPreviousValues: { // field return type
    admin: boolean; // Boolean!
    email: string | null; // String
    firstName: string; // String!
    id: string; // ID!
    lastName: string; // String!
    password: string; // String!
  }
  UserSubscriptionPayload: { // field return type
    mutation: NexusGenEnums['MutationType']; // MutationType!
    node: NexusGenRootTypes['User'] | null; // User
    previousValues: NexusGenRootTypes['UserPreviousValues'] | null; // UserPreviousValues
    updatedFields: string[] | null; // [String!]
  }
}

export interface NexusGenArgTypes {
  Mutation: {
    addProduct: { // args
      name?: string | null; // String
      producer?: string | null; // String
      type?: string | null; // String
    }
    createCheckin: { // args
      authorId?: string | null; // ID
      comment?: string | null; // String
      productId?: string | null; // ID
      rating?: number | null; // Int
    }
    deleteCheckin: { // args
      id?: string | null; // ID
    }
    deleteProduct: { // args
      id?: string | null; // ID
    }
    deleteUser: { // args
      id?: string | null; // ID
    }
    login: { // args
      email?: string | null; // String
      password?: string | null; // String
    }
    signup: { // args
      email?: string | null; // String
      firstName?: string | null; // String
      lastName?: string | null; // String
      password?: string | null; // String
    }
    updateProduct: { // args
      id?: string | null; // ID
      name?: string | null; // String
      producer?: string | null; // String
      type?: string | null; // String
    }
    updateUser: { // args
      email?: string | null; // String
      firstName?: string | null; // String
      id?: string | null; // ID
      lastName?: string | null; // String
    }
  }
  Product: {
    checkins: { // args
      after?: string | null; // String
      before?: string | null; // String
      first?: number | null; // Int
      last?: number | null; // Int
      orderBy?: NexusGenEnums['CheckinOrderByInput'] | null; // CheckinOrderByInput
      skip?: number | null; // Int
      where?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    }
  }
  Query: {
    checkin: { // args
      id?: string | null; // ID
    }
    product: { // args
      id?: string | null; // ID
    }
    user: { // args
      id?: string | null; // ID
    }
  }
  User: {
    checkins: { // args
      after?: string | null; // String
      before?: string | null; // String
      first?: number | null; // Int
      last?: number | null; // Int
      orderBy?: NexusGenEnums['CheckinOrderByInput'] | null; // CheckinOrderByInput
      skip?: number | null; // Int
      where?: NexusGenInputs['CheckinWhereInput'] | null; // CheckinWhereInput
    }
  }
}

export interface NexusGenAbstractResolveReturnTypes {
}

export interface NexusGenInheritedFields {}

export type NexusGenObjectNames = "AuthPayload" | "Checkin" | "Mutation" | "Product" | "ProductPreviousValues" | "ProductSubscriptionPayload" | "Query" | "Subscription" | "User" | "UserPreviousValues" | "UserSubscriptionPayload";

export type NexusGenInputNames = "CheckinWhereInput" | "ProductWhereInput" | "UserWhereInput";

export type NexusGenEnumNames = "CheckinOrderByInput" | "MutationType";

export type NexusGenInterfaceNames = never;

export type NexusGenScalarNames = "Boolean" | "DateTime" | "Float" | "ID" | "Int" | "String";

export type NexusGenUnionNames = never;

export interface NexusGenTypes {
  context: types.Context;
  inputTypes: NexusGenInputs;
  rootTypes: NexusGenRootTypes;
  argTypes: NexusGenArgTypes;
  fieldTypes: NexusGenFieldTypes;
  allTypes: NexusGenAllTypes;
  inheritedFields: NexusGenInheritedFields;
  objectNames: NexusGenObjectNames;
  inputNames: NexusGenInputNames;
  enumNames: NexusGenEnumNames;
  interfaceNames: NexusGenInterfaceNames;
  scalarNames: NexusGenScalarNames;
  unionNames: NexusGenUnionNames;
  allInputTypes: NexusGenTypes['inputNames'] | NexusGenTypes['enumNames'] | NexusGenTypes['scalarNames'];
  allOutputTypes: NexusGenTypes['objectNames'] | NexusGenTypes['enumNames'] | NexusGenTypes['unionNames'] | NexusGenTypes['interfaceNames'] | NexusGenTypes['scalarNames'];
  allNamedTypes: NexusGenTypes['allInputTypes'] | NexusGenTypes['allOutputTypes']
  abstractTypes: NexusGenTypes['interfaceNames'] | NexusGenTypes['unionNames'];
  abstractResolveReturn: NexusGenAbstractResolveReturnTypes;
}