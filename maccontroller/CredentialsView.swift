import SwiftUI

struct CredentialsView: View {
    @State private var host: String = UserDefaults.standard.string(forKey: "SSH_HOST") ?? ""
    @State private var username: String = UserDefaults.standard.string(forKey: "SSH_USER") ?? ""
    @State private var password: String = UserDefaults.standard.string(forKey: "SSH_PASSWORD") ?? ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("SSH Credentials")
                .font(.largeTitle)
                .padding()

            TextField("Host", text: $host)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: saveCredentials) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Message"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            Spacer()
        }
        .padding()
    }

    func saveCredentials() {
        UserDefaults.standard.set(host, forKey: "SSH_HOST")
        UserDefaults.standard.set(username, forKey: "SSH_USER")
        UserDefaults.standard.set(password, forKey: "SSH_PASSWORD")
        alertMessage = "Credentials Saved!"
        showAlert = true
    }
}

struct CredentialsView_Previews: PreviewProvider {
    static var previews: some View {
        CredentialsView()
    }
}
