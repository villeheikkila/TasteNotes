import Foundation
import Supabase

protocol SubBrandRepository {
    func insert(newSubBrand: SubBrand.NewRequest) async -> Result<SubBrand, Error>
    func update(updateRequest: SubBrand.Update) async -> Result<Void, Error>
    func delete(id: Int) async -> Result<Void, Error>
}

struct SupabaseSubBrandRepository: SubBrandRepository {
    let client: SupabaseClient

    func insert(newSubBrand: SubBrand.NewRequest) async -> Result<SubBrand, Error> {
        do {
            let response = try await client
                .database
                .from(SubBrand.getQuery(.tableName))
                .insert(values: newSubBrand, returning: .representation)
                .select(columns: SubBrand.getQuery(.saved(false)))
                .single()
                .execute()
                .decoded(to: SubBrand.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }
    
    func update(updateRequest: SubBrand.Update) async -> Result<Void, Error> {
        do {
            let baseQuery = client
                .database
                .from(SubBrand.getQuery(.tableName))
            
            switch updateRequest {
            case let .brand(update):
                try await baseQuery
                    .update(values: update)
                    .eq(column: "id", value: update.id)
                    .execute()
            case let .name(update):
                try await baseQuery
                    .update(values: update)
                    .eq(column: "id", value: update.id)
                    .execute()
            }
                        
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func delete(id: Int) async -> Result<Void, Error> {
        do {
            try await client
                .database
                .from(SubBrand.getQuery(.tableName))
                .delete()
                .eq(column: "id", value: id)
                .execute()
            
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
