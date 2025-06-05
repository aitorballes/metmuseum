import SwiftUI

struct ValidatedTextField: View {
    let titleKey: LocalizedStringKey
    @Binding var text: String
    let isFocused: Bool
    let validate: (String) -> LocalizedStringResource?

    @State private var error = false
    @State private var errorMessage: String?

    init(
        _ titleKey: LocalizedStringKey,
        text: Binding<String>,
        isFocused: Bool,
        validate: @escaping (String) -> LocalizedStringResource?
    ) {
        self.titleKey = titleKey
        self._text = text
        self.isFocused = isFocused
        self.validate = validate
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(titleKey)
                .font(.caption)
                .foregroundStyle(error ? .red : .primary)
            
            HStack {
                TextField(titleKey, text: $text)
                    .padding(6)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                error
                                ? Color.red
                                : Color.secondary
                                    .opacity(0.5),
                                lineWidth: 1
                            )
                            .background(
                                Color.secondary.opacity(0.1).cornerRadius(10)
                            )
                    }
                    .onChange(of: text) {
                        validateField(text: text)
                    }
                
                if !text.isEmpty && isFocused {
                    Button {
                        text = ""
                        errorMessage = ""
                        error = false
                    } label: {
                        Label("Clear", systemImage: "xmark.circle.fill")
                    }
                    .tint(.secondary)
                    .labelStyle(.iconOnly)
                }
            }
            
            Text(errorMessage ?? "")
                .font(.caption)
                .foregroundStyle(.red)
                .opacity(error ? 1 : 0)
                .fixedSize(horizontal: false, vertical: true)
        }
        .animation(.easeInOut, value: text.isEmpty)
        .animation(.easeInOut, value: error)
    }

    private func validateField(text: String) {
        if let message = validate(text) {
            errorMessage = String(localized: message)
            error = true
        } else {
            errorMessage = ""
            error = false
        }
    }
}

#Preview {
    @Previewable @State var text = ""

    ValidatedTextField(
        LocalizedStringKey(stringLiteral: "Name"),
        text: $text,
        isFocused: true,
        validate: { value in
            if value.isEmpty {
                return "Cannot be empty"
            } else {
                return nil
            }
        }
    )
    .padding()
}

#Preview {
    @Previewable @State var zip = "24007"
    
    ValidatedTextField(
        LocalizedStringKey(stringLiteral: "ZIPCODE"),
        text: $zip,
        isFocused: true,
        validate: { value in
            if value.count > 5 {
                return nil
            } else {
                return "Should be 5 digits"
            }
        }
    )
    .padding()
}
