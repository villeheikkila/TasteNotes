import Foundation
import Supabase

protocol LocationRepository {
    func insert(location: Location) async -> Result<Location, Error>
}

struct SupabaseLocationRepository: LocationRepository {
    let client: SupabaseClient

    func insert(location: Location) async -> Result<Location, Error> {
        let params = location.getNew()
        print(params)
        do {
            let result =  try await client
                .database
                .rpc(fn: "fnc__get_location_insert_if_not_exist", params: params)
                .select(columns: Location.getQuery(.joined(false)))
                .single()
                .execute()
                .decoded(to: Location.self)
            
            
            print(result)
            
            return .success(result)
        } catch {
           return .failure(error)
        }
    }
}
