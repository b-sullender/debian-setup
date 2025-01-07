# Debian Setup Scripts

These scripts automates the setup process for a Debian system, installing various software packages, configuring the GNOME desktop environment, and setting up development tools.

## Prerequisites

- A fresh installation of Debian.
- Access to a user account with root privileges.

**Important:** If you assigned a password to the root account during the Debian installation, your regular user account may not have root privileges. To grant root privileges to your regular user, add the user to the `sudo` group as follows:

1. Install the `sudo` package:
   ```shell
   apt install sudo
   ```

2. Add your user to the `sudo` group:
   ```shell
   usermod -aG sudo <username>
   ```
   Replace `<username>` with your actual username.

## Usage

To set up your Debian system, follow these steps:

1. **Install Required Packages**  
   Run the following command to install necessary tools:  
   ```shell
   apt install -y wget zip git
   ```
   *Optional:* For driver installation, refer to the [Installing Drivers](drivers.md) guide.

2. **Clone the Repository**  
   Use `git` to clone this repository:  
   ```shell
   git clone https://github.com/b-sullender/debian-setup.git
   ```

3. **Navigate to the Repository Directory**  
   ```shell
   cd debian-setup
   ```

4. **Run the Setup Script**  
   Execute the setup script:  
   ```shell
   sudo bash bookworm.sh
   ```

   Follow the prompts during execution and provide any required inputs.

## GNOME

If your using the GNOME desktop environment or want to install it with the recommended configuration, run the GNOME configuration script:
```shell
bash config-gnome.sh
```

### 4K Resolution & Above

If you're using a 4K resolution or higher, certain elements, such as the login screen or Qt applications, may not scale correctly. The following sections explain how to adjust the scaling to ensure proper display.

#### GNOME Display Manager (GDM)

To scale the login screen appropriately for 4K resolution, follow these steps:

1. Create an override file by running the following command:
   ```shell
   echo -e "[org.gnome.desktop.interface]\nscaling-factor=2" | sudo tee /usr/share/glib-2.0/schemas/93_hidpi.gschema.override > /dev/null
   ```
   Note: Change the value of `scaling-factor` (e.g., `2`) to fit your needs.
   
2. Reinitialize schemas by executing the following command:
   ```shell
   sudo glib-compile-schemas /usr/share/glib-2.0/schemas
   ```

#### Qt Applications

To adjust scaling for Qt applications, follow these steps:

1. Create a script to set the `QT_AUTO_SCREEN_SCALE_FACTOR` environment variable:  
   ```shell
   echo -e "export QT_AUTO_SCREEN_SCALE_FACTOR=2" | sudo tee /etc/profile.d/hidpi.sh > /dev/null
   ```  
   Adjust the value as necessary for your display.
   
2. Reboot your computer to apply the changes.

## Contributing

Contributions are welcome! If you have any improvements or bug fixes, feel free to open an issue or submit a pull request.

## Disclaimer

Please use this script at your own risk. It is recommended to review the script and ensure it aligns with your system requirements before running it. We are not responsible for any damages or data loss caused by the use of this script.

## Contact

For any questions or feedback, please feel free to contact the script maintainer:

- Maintainer: [Brian Sullender](https://github.com/b-sullender)

## Screenshot

![Screenshot](screenshot.png)

