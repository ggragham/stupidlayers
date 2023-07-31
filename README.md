# Stupid Layers

The **Motospeed CK62** is a sh*tty keyboard that doesn't have normal 'fn' key. Instead, it toggles layers. In response to this, [Francesco149](https://github.com/Francesco149/stupidlayers) has created a tool that captures all keyboard input via evdev and emulates a 'fn' key by forwarding modified inputs to a virtual keyboard created with uinput. This tool operates with virtually zero latency.

You can reuse *stupidlayers.c* as a mini library to create your own keyboard remapper.

## Usage
Just install it from package or build and install it from source and replug your keyboard.

## Keybinds

* **l_ctrl** acts as a normal **fn** key if held down
* **l_ctrl** + **w**/**a**/**s**/**d** acts as arrow keys
* **l_ctrl** + esc acts as **grave** key

## Dependencies
* gcc
* make
* udev
* at

## Building from git
Make sure you have the required dependencies installed! If you do this, then:
```bash
git clone https://github.com/ggragham/stupidlayers
cd stupidlayers
sudo make install
```
