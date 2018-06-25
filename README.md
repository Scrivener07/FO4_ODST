# Fallout 4 - ODST
A Fallout 4 modification by [Darkman32197](https://www.nexusmods.com/users/5280910) and [NovaFinch](https://www.nexusmods.com/users/38614105).
This file should help authors get started developing for ODST.

### WIP
* [ODST WIP 1](https://www.nexusmods.com/fallout4/images/110670)
* [ODST WIP 2](https://www.nexusmods.com/fallout4/images/111188)
* [ODST WIP 3](https://www.nexusmods.com/fallout4/images/115593)
* [ODST WIP 4](https://www.nexusmods.com/fallout4/images/119187)

### Prerequisites
* Fallout 4 Creation Kit
* Fallout 4 Script Extender (F4SE) - http://f4se.silverlock.org/

### Compiling
In the root Fallout 4 directory, create the file `CreationKitCustom.ini` if it does not already exist.
Add these settings to the initialization file and restart the creation kit.

```
[Papyrus]
sScriptSourceFolder = ".\Data\Scripts\Source\ODST"
sAdditionalImports = "$(source);.\Data\Scripts\Source\User;.\Data\Scripts\Source\Base"
sAutoFillNamespaceDefault1 = "ODST"
```

### Console Commands
* `StartQuest ODST_Cheat`, Adds weapons to the players inventory for testing purposes.
