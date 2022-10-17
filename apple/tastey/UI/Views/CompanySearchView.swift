import SwiftUI
import AlertToast

struct CompanySearchView: View {
    @State var searchText: String = ""
    @State var searchResults = [Company]()
    @State var status: Status? = nil
    @State var showToast = false
    @State var companyName = ""

    let onSelect: (_ company: Company) -> Void
    
    func onAdd() {
        self.companyName = searchText
        self.status = Status.add
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.id) { company in
                    Button(action: { self.onSelect(company) }) {
                        Text(company.name)
                    }
                }

                switch status {
                case .searched:
                    Section {
                        Button(action: {
                            onAdd()
                        }) {
                            Text("Add")
                        }
                    } header: {
                        Text("Didn't find the company you were looking for?")
                    }.textCase(nil)
                case .add:
                    Section {
                        TextField("Name", text: $companyName)
                        Button("Create") {
                            createNewCompany()
                        }
                    } header: {
                        Text("Add new company")
                    }
                case .none:
                    EmptyView()
                }
            }
            .navigationTitle("Search companies")
            .searchable(text: $searchText)
            .onSubmit(of: .search, searchUsers)
            .toast(isPresenting: $showToast, duration: 2, tapToDismiss: true) {
                AlertToast(type: .complete(.green), title: "Company Created!")
            }
        }
    }

    func searchUsers() {
        Task {
            do {
                let searchResults = try await SupabaseCompanyRepository().search(searchTerm: searchText)
                DispatchQueue.main.async {
                    self.searchResults = searchResults
                    self.status = Status.searched
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }

    func createNewCompany() {
        let newCompany = NewCompany(name: companyName)
        Task {
            do {
                let newCompany = try await SupabaseCompanyRepository().insert(newCompany: newCompany)

                DispatchQueue.main.async {
                    self.searchResults.append(newCompany)
                    self.showToast = true
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}

extension CompanySearchView {
    enum Status {
        case add
        case searched
    }
}
