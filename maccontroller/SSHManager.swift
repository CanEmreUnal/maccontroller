import Foundation
import NMSSH

class SSHManager {
    static let shared = SSHManager()
    private var session: NMSSHSession?
    
    private init() {}
    
    func connect(completion: @escaping (Bool, String) -> Void) {
        guard let host = UserDefaults.standard.string(forKey: "SSH_HOST"),
              let user = UserDefaults.standard.string(forKey: "SSH_USER"),
              let password = UserDefaults.standard.string(forKey: "SSH_PASSWORD") else {
            completion(false, "Missing SSH configuration")
            return
        }
        
        session = NMSSHSession(host: host, andUsername: user)
        session?.connect()
//        
//        print(host)
//        print(user)
//        print(password)
//        
        if session?.isConnected == true {
            print("SSH: Connected to \(host)")
            session?.authenticate(byPassword: password)
            if session?.isAuthorized == true {
                print("SSH: Authorized")
                completion(true, "Connected to \(host)")
            } else {
                print("SSH: Authentication failed")
                completion(false, "Authentication failed")
            }
        } else {
            print("SSH: Connection failed with error: \(session?.lastError?.localizedDescription ?? "Unknown error")")
            completion(false, "Connection failed")
        }
    }
    
    func setVolume(to value: Int) {
        guard session?.isAuthorized == true else {
            print("SSH: Not authorized")
            return
        }
        let command = "osascript -e 'set volume output volume \(value)'"
        session?.channel.execute(command, error: nil, timeout: 10)
    }
    
    func putToSleep() {
        guard session?.isAuthorized == true else {
            print("SSH: Not authorized")
            return
        }
        let command = "pmset sleepnow"
        session?.channel.execute(command, error: nil, timeout: 10)
    }
}
