# FiveM Identifier Logger By TIGO
![Custom ESX Jobs](https://i.imgur.com/HoLY5s9.png)
[![Thymon](https://i.imgur.com/3EquTNl.jpg)](https://www.tigodev.com)

[![Developer](https://img.shields.io/badge/Developer-TigoDevelopment-darkgreen)](https://github.com/TigoDevelopment)
[![Discord](https://img.shields.io/badge/Discord-Tigo%239999-purple)](https://discordapp.com/users/636509961375055882)
[![Version](https://img.shields.io/badge/Version-1.0.0-darkgreen)](https://github.com/TigoDevelopment/FiveMIdentifierLogger/blob/master/version)
[![Version](https://img.shields.io/badge/License-MIT-darkgreen)](https://github.com/TigoDevelopment/FiveMIdentifierLogger/blob/master/LICENSE)

### About FiveM Identifier Logger

These resources capture all identifiers a player connects with. These are stored in the database under table `user_identifiers`.

### Requirement
- **None**

### Get Started
1) Copy **FiveMIdentifierLogger** to your FXServer resource folder
2) Run the **FiveMIdentifierLogger.sql** file in your FXServer database
3) Add **FiveMIdentifierLogger** to your **sever.cfg** file
3) Start your server or resource

⚠️ **FiveMIdentifierLogger.sql** creates table `user_identifiers`

### Overview of all captured identifiers
Identifier | Type
:----------|:----
`identifier` | Steam Identifier
`name` | Steam Name
`license` | GTA License
`xbl` | XBOX Live ID
`live` | Microsoft ID
`discord` | Discord ID
`fivem` | FiveM ID
`ip` | IP

### License
MIT License

Copyright (c) 2020 Thymon Arens (TigoDevelopment)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


### Disclamer
---
This resource was created by me with all the knowledge at the time of writing. The request for new functionality is allowed but it does not mean that it will be released. Further development of this resource is permitted.
