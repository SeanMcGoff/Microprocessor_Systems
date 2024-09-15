# Build/Debug Scripts for CSU33D01

This repo holds a couple bash scripts Darragh and I wrote to set up a local dev environment for completing assignments in my CSU33D01 module (Microprocessor Systems 1)

These scripts should work out-the-box on both mac and linux. If you're on windows, I suggest looking into installing [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

# Setting Up your own Dev environment 

First, download/clone this repository onto your computer.

If you are on *MacOS*, follow [this](https://brew.sh/) to install the Homebrew package manager. For WSL/Linux, there should be a package manager already installed, such as *apt-get* or *pacman*.

Use said package manager in your terminal envionment to install these packages:
  - arm-none-eabi-as
  - arm-none-eabi-gdb
  - arm-none-eabi-ld
  - qemu

From there, you should be able to run the two scripts in this project. Navigate your terminal to the project folder and type:
```
./build.sh example
```

This should successfully build and link the example project, which contains assembly that adds 2+2.

From there, you can start a debugging instance with the second script
```
./debug.sh example
```

After a few seconds, this should start a gdb instance, and you can start to debug your assembly program.

## Adding new projects

To add a new project, simply create a folder, name it what you want, and add an assembly file *main.s* in the folder. Write your ARM assembly in the *main.s* file, then run the two commands above, replacing the folder name "example" with your own folder name.