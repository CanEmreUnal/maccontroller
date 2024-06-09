
# MyMacRemoteController

MyMacRemoteController is a macOS application that allows you to control your Mac's volume and put it to sleep remotely via SSH.

## Features

- Connect to a remote Mac using SSH.
- Adjust the remote Mac's volume.
- Put the remote Mac to sleep.

## Requirements

- macOS 10.15 or later
- Xcode 12.0 or later
- Swift 5.3 or later

## Installation

### Using CocoaPods

1. Ensure you have [CocoaPods](https://cocoapods.org) installed. If not, install it using:
   ```sh
   sudo gem install cocoapods
   ```
2. Navigate to your project directory and create a `Podfile` if you don't already have one:
   ```sh
   pod init
   ```
3. Open the `Podfile` and add the following:
   ```ruby
   target 'MyMacRemoteController' do
     use_frameworks!
     pod 'NMSSH', :git => 'https://github.com/speam/NMSSH.git'
   end
   ```
4. Install the pod:
   ```sh
   pod install
   ```
5. Open the generated `.xcworkspace` file.

## Usage

### Configure SSH Credentials

1. Launch the app.
2. Click on `Enter SSH Credentials`.
3. Input your SSH host, username, and password.
4. Click `Save`.

### Connect and Control

1. Click the `Connect` button to establish an SSH connection.
2. Use the slider to adjust the volume.
3. Click `Put to Sleep` to put the remote Mac to sleep.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

