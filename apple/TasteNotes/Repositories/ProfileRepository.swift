import Foundation
import GoTrue
import Realtime
import Supabase
import SupabaseStorage

protocol ProfileRepository {
    func getById(id: UUID) async -> Result<Profile, Error>
    func getCurrentUser() async -> Result<Profile.Extended, Error>
    func update(id: UUID, update: Profile.UpdateRequest) async -> Result<Profile.Extended, Error>
    func currentUserExport() async -> Result<String, Error>
    func search(searchTerm: String, currentUserId: UUID) async -> Result<[Profile], Error>
    func uploadAvatar(userId: UUID, data: Data) async -> Result<String, Error>
    func uploadPushNotificationToken(token: Profile.PushNotificationToken) async -> Result<Void, Error>
    func deleteCurrentAccount() async -> Result<Void, Error>
    func updateSettings(id: UUID, update: ProfileSettings.UpdateRequest) async -> Result<ProfileSettings, Error>
}

struct SupabaseProfileRepository: ProfileRepository {
    let client: SupabaseClient
    
    func getById(id: UUID) async -> Result<Profile, Error> {
        do {
            let response = try await client
                .database
                .from(Profile.getQuery(.tableName))
                .select(columns: Profile.getQuery(.minimal(false)))
                .eq(column: "id", value: id.uuidString.lowercased())
                .limit(count: 1)
                .single()
                .execute()
                .decoded(to: Profile.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func getCurrentUser() async -> Result<Profile.Extended, Error> {
        do {
            let response = try await client
                .database
                .rpc(fn: "fnc__get_current_profile")
                .select(columns: Profile.getQuery(.extended(false)))
                .limit(count: 1)
                .single()
                .execute()
                .decoded(to: Profile.Extended.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func update(id: UUID, update: Profile.UpdateRequest) async -> Result<Profile.Extended, Error> {
        do {
            let response = try await client
                .database
                .from(Profile.getQuery(.tableName))
                .update(
                    values: update,
                    returning: .representation
                )
                .eq(column: "id", value: id.uuidString.lowercased())
                .select(columns: Profile.getQuery(.extended(false)))
                .single()
                .execute()
                .decoded(to: Profile.Extended.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func updateSettings(id: UUID, update: ProfileSettings.UpdateRequest) async -> Result<ProfileSettings, Error> {
        do {
            let response = try await client
                .database
                .from(ProfileSettings.getQuery(.tableName))
                .update(
                    values: update,
                    returning: .representation
                )
                .eq(column: "id", value: id.uuidString.lowercased())
                .select(columns: ProfileSettings.getQuery(.saved(false)))
                .single()
                .execute()
                .decoded(to: ProfileSettings.self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func uploadPushNotificationToken(token: Profile.PushNotificationToken) async -> Result<Void, Error> {
        do {
            try await client
                .database
                .rpc(fn: "fnc__upsert_push_notification_token", params: token)
                .execute()
            
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    func currentUserExport() async -> Result<String, Error> {
        do {
            let response = try await client
                .database
                .rpc(fn: "fnc__export_data")
                .csv()
                .execute()

            guard let csv = String(data: response.data, encoding: String.Encoding.utf8) else {
                throw ProfileError.csvExportFailure
            }

            return .success(csv)
        } catch {
            return .failure(error)
        }
    }

    func search(searchTerm: String, currentUserId: UUID) async -> Result<[Profile], Error> {
        do {
            let response = try await client
                .database
                .from(Profile.getQuery(.tableName))
                .select(columns: Profile.getQuery(.minimal(false)))
                .ilike(column: "search", value: "%\(searchTerm)%")
                .not(column: "id", operator: .eq, value: currentUserId.uuidString)
                .execute()
                .decoded(to: [Profile].self)

            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    func uploadAvatar(userId: UUID, data: Data) async -> Result<String, Error> {
        do {
            let fileName = "\(UUID().uuidString.lowercased()).jpeg"
            let file = File(
                name: fileName, data: data, fileName: fileName, contentType: "image/jpeg")
            _ = try await client
                .storage
                .from(id: "avatars")
                .upload(
                    path: "\(userId.uuidString.lowercased())/\(fileName)", file: file, fileOptions: nil)

            return .success(fileName)
        } catch {
            return .failure(error)
        }
    }

    func deleteCurrentAccount() async -> Result<Void, Error> {
        do {
            try await client
                .database
                .rpc(fn: "fnc__delete_current_user")
                .execute()

            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
