import SwiftUI

struct MembershipView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: MembershipViewModel
    

    @FocusState private var focusedField: MembershipField?
    var body: some View {
        @Bindable var viewModel = viewModel
        Form {
            Section(header: Text("Personal Information")) {
                ValidatedTextField(
                    "First name",
                    text: $viewModel.firstName,
                    isFocused: focusedField == .firstName,
                    validate: viewModel.validateIsEmpty
                )
                .textContentType(.name)
                .focused($focusedField, equals: .firstName)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

                ValidatedTextField(
                    "Email",
                    text: $viewModel.email,
                    isFocused: focusedField == .email,
                    validate: viewModel.validateEmail
                )
                .textContentType(.emailAddress)
                .focused($focusedField, equals: .email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
            }

            Section(header: Text("Membership Type")) {
                Picker(
                    "Select Membership Type",
                    selection: $viewModel.selectedMembershipType
                ) {
                    ForEach(MembershipType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Button {
                if viewModel.validate() {
                    dismiss()
                }
            } label: {
                Text("Generate Membership Card")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(10)
        }
        .alert(
            "Validation error",
            isPresented: $viewModel.isAlertPresented
        ) {
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

//#Preview {
//    MembershipView(viewModel: MembershipViewModel())
//}
