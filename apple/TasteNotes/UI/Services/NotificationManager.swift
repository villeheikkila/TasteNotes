import FirebaseMessaging
import SwiftUI

final class NotificationManager: NSObject, ObservableObject {
    @Published private(set) var notifications = [Notification]()

    func refresh(reset: Bool = false) {
        Task {
            switch await repository.notification.getAll(afterId: reset ? nil : notifications.first?.id) {
            case let .success(newNotifications):
                await MainActor.run {
                    if reset {
                        self.notifications = newNotifications
                    } else {
                        self.notifications.append(contentsOf: newNotifications)
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func deleteAll() {
        Task {
            switch await repository.notification.deleteAll() {
            case .success():
                DispatchQueue.main.async {
                    self.notifications = [Notification]()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func markAllAsRead() {
        Task {
            switch await repository.notification.markAllRead() {
            case .success():
                DispatchQueue.main.async {
                    self.notifications = self.notifications.map {
                        if $0.seenAt == nil {
                            return Notification(id: $0.id, createdAt: $0.createdAt, seenAt: Date(), content: $0.content)
                        } else {
                            return $0
                        }
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func markAllFriendRequestsAsRead() {
        let containsFriendRequests = notifications.contains(where: {
            switch $0.content {
            case .friendRequest:
                return true
            default:
                return false
            }
        })

        if containsFriendRequests {
            Task {
                switch await repository.notification.markAllFriendRequestsAsRead() {
                case let .success(updatedNotifications):
                    await MainActor.run {
                        self.notifications = self.notifications.map {
                            n in
                            if let updatedNotification = updatedNotifications.first(where: { $0.id == n.id }) {
                                return updatedNotification
                            } else {
                                return n
                            }
                        }
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func markCheckInAsRead(checkIn: CheckIn) {
        let containsCheckIn = notifications.contains(where: {
            switch $0.content {
            case let .checkInReaction(cr):
                return cr.checkIn == checkIn
            case let .taggedCheckIn(tc):
                return tc == checkIn
            default:
                return false
            }
        })

        if containsCheckIn {
            Task {
                switch await repository.notification.markAllCheckInNotificationsAsRead(checkInId: checkIn.id) {
                case let .success(updatedNotifications):
                    await MainActor.run {
                        self.notifications = self.notifications.map {
                            n in
                            if let updatedNotification = updatedNotifications.first(where: { $0.id == n.id }) {
                                return updatedNotification
                            } else {
                                return n
                            }
                        }
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func markAsRead(_ notifaction: Notification) {
        Task {
            switch await repository.notification.markRead(id: notifaction.id) {
            case let .success(updatedNotification):
                await MainActor.run {
                    if let index = self.notifications.firstIndex(of: notifaction) {
                        self.notifications[index] = updatedNotification
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func deleteFromIndex(at: IndexSet) {
        if let index = at.first {
            Task {
                switch await repository.notification.delete(id: notifications[index].id) {
                case .success:
                    await MainActor.run {
                        DispatchQueue.main.async {
                            self.notifications.remove(at: index)
                        }
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func deleteNotifications(notification: Notification) {
        Task {
            switch await repository.notification.delete(id: notification.id) {
            case .success():
                await MainActor.run {
                    self.notifications.removeAll(where: { $0.id == notification.id })
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func refreshAPNS() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                Task {
                    switch await repository.profile.uploadPushNotificationToken(token: Profile.PushNotificationToken(firebaseRegistrationToken: token)) {
                    case .success():
                        break
                    case let .failure(error):
                        print("Couldn't save FCM (\(String(describing: token))): \(error)")
                    }
                }
            }
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        refresh()
        return [[.sound]]
    }

    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
    }
}
