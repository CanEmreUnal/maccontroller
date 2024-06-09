import SwiftUI

struct ContentView: View {
    @State private var volume: Double = 50
    @State private var isConnected = false
    @State private var statusMessage = "Not connected"
    @State private var showingCredentialsView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Remote Mac Controller")
                    .font(.largeTitle)
                    .padding()

                if isConnected {
                    VStack {
                        Text("Volume: \(Int(volume))")
                        Slider(value: $volume, in: 0...100, step: 1)
                            .padding()
                            .onChange(of: volume) { newValue in
                                SSHManager.shared.setVolume(to: Int(newValue))
                            }

                        Button("Put to Sleep") {
                            SSHManager.shared.putToSleep()
                        }
                        .padding()
                    }
                } else {
                    Text("Connecting...")
                        .padding()
                }

                Text(statusMessage)
                    .padding()

                Button("Enter SSH Credentials") {
                    showingCredentialsView = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .sheet(isPresented: $showingCredentialsView) {
                    CredentialsView()
                }
            }
            .onAppear {
                SSHManager.shared.connect { success, message in
                    isConnected = success
                    statusMessage = message
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
