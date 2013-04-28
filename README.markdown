# Esperanto - Vim plugin for typing in Esperanto
by [Sergey Potapov](https://github.com/greyblake)


The plugin allows to use the international language in Vim.
It doesn't require additional Esperanto keyboard in system, and keeps
Vim behaviour the same as with English keyboard.


## Installation

To install the plugin it's enough to copy `plugin`, `doc` directories into your `.vim` directory.
But I would recommend to use plugin manager Pathogen or Vundle

## Usage


The plugin provides the next commands:

* `EoOn` - to set Esperanto on
* `EoOff` - to set Esperanto off
* `Eo` - to toggle Esperanto

## EoMap

The plugin allows you to type Esperanto characters in 4 ways. Which one to used is
defined by `EoMap` global variable.

### Keyboard mapping

It's default mapping.  To use it add to `.vimrc` file:

```
let EoMap = "keyboard"
```

It simulates the Esperanto keyboard

![Esperanto Klavaro](http://i1078.photobucket.com/albums/w484/greyblake/esperanto_klavaro.png "Esperanto Klavaro")

Actually it adds the next mappings:

    x = ĉ
    q = ŝ
    w = ĝ
    y = ŭ
    [ = ĵ
    ] = ĥ

### X mapping

To use it add to `.vimrc` file:

```
let EoMap = "x"
```

Example:

```
Cxu vi sxatas gxin?  =  Ĉu vi ŝatas ĝin?
```

### H mapping

To use it add to `.vimrc` file:

```
let EoMap = "h"
```

Example:

```
Chu vi shatas ghin?  =  Ĉu vi ŝatas ĝin?
```

### Caret mapping

To use it add to `.vimrc` file:

```
let EoMap = "caret"
```

Example:

```
C^u vi s^atas g^in?  =  Ĉu vi ŝatas ĝin?
```

## Spell checking

By default the plugin activates spell checking for Esperanto language,
when Esperanto is on, it sets `spelllang=eo`.

To deactivate this behaviour add to `.vimrc` the next:

    let EoSpell = 0


## Credits

* [Sergey Potapov](https://github.com/greyblake) - creator and maintainer


## License

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of
the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston,
MA 02111-1307 USA
