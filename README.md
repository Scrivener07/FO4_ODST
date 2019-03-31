# Fallout 4 - ODST
A Fallout 4 modification by [Darkman32197](https://www.nexusmods.com/users/5280910), [NovaFinch](https://www.nexusmods.com/users/38614105) and [Soda](https://www.nexusmods.com/users/4991811). This file should help authors get started developing for ODST.

Built for `ODST v1.0.2`.

## WIP
* [ODST WIP 1](https://www.nexusmods.com/fallout4/images/110670)
* [ODST WIP 2](https://www.nexusmods.com/fallout4/images/111188)
* [ODST WIP 3](https://www.nexusmods.com/fallout4/images/115593)
* [ODST WIP 4](https://www.nexusmods.com/fallout4/images/119187)
* [ODST - WIP Video 1](https://youtu.be/Rwcv4ZNj16A) *Emblem Designer*
* [ODST - WIP Video 2](https://youtu.be/NLYbu99T0ko) *Emblem Designer*

## Resources
* [Fallout 4 Creation Kit](https://www.creationkit.com/fallout4/index.php?title=Main_Page)
* [Fallout 4 Script Extender](http://f4se.silverlock.org/) (F4SE)
* [Mod Configuration Menu](https://www.nexusmods.com/fallout4/mods/21497) (MCM), read the [documentation](https://github.com/Neanka/MCM_0.1_AS3/wiki).

## Compiling
This projects includes both Papyrus and Flash/AS3 to compile and publish.

### Flash
* **MCM Library:** `../../../../../MCM/Config/ODST/lib.swf`

### Papyrus
In the root Fallout 4 directory, create the file `CreationKitCustom.ini` if it does not already exist.
Add these settings to the initialization file and restart the creation kit.

```
[Papyrus]
sScriptSourceFolder = ".\Data\Scripts\Source\ODST"
sAdditionalImports = "$(source);.\Data\Scripts\Source\User;.\Data\Scripts\Source\Base"
sAutoFillNamespaceDefault1 = "ODST"
```

## Console Commands
* `StartQuest ODST_Cheat`, Adds weapons to the players inventory for testing purposes.
