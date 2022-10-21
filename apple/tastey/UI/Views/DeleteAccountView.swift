import AlertToast
import GoTrue
import PhotosUI
import SwiftUI
                           
struct DeleteAccountView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showingImagePicker = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showDeleteConfirmation = false
    @EnvironmentObject var currentProfile: CurrentProfile
    @Environment(\.colorScheme) var initialColorScheme

    var body: some View {
        Form {
            Section {
                Button("Export", action: { viewModel.exportData() })
                Button("Delete Account", role: .destructive, action: {
                    showDeleteConfirmation = true
                })
                .confirmationDialog(
                    "Are you sure you want to permanently delete your account? All data will be lost.",
                    isPresented: $showDeleteConfirmation
                ) {
                    Button("Delete Account", role: .destructive, action: { viewModel.deleteCurrentAccount() })
                }
            }
        }
        .navigationTitle("Delete Account")
        .toast(isPresenting: $viewModel.showToast, duration: 1, tapToDismiss: true) {
            switch viewModel.toast {
            case .exported:
                return AlertToast(type: .complete(.green), title: "Data was exported as CSV")
            case .exportError:
                return AlertToast(type: .error(.red), title: "Error occured while trying to export data")
            case .none:
                return AlertToast(type: .error(.red), title: "")
            }
        }
    }
}

extension DeleteAccountView {
    enum Toast {
        case exported
        case exportError
    }

    @MainActor class ViewModel: ObservableObject {
        @Published var csvExport: CSVFile?
        @Published var showingExporter = false
        @Published var showToast = false
        @Published var toast: Toast?
        var initialColorScheme: ColorScheme? = nil

        var profile: Profile?
        var user: User?

        func showToast(type: Toast) {
            toast = type
            showToast = true
        }

        func exportData() {
            Task {
                let csvText = try await repository.profile.currentUserExport()
                self.csvExport = CSVFile(initialText: csvText)
                self.showingExporter = true
            }
        }

        func deleteCurrentAccount() {
            Task {
                do {
                    try await repository.profile.deleteCurrentAccount()
                    try await repository.auth.logOut()
                } catch {
                    print("error \(error)")
                }
            }
        }
    }
}
