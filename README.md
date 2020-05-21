# Get Outfit

The app following Get Outfit [website](https://getoutfit.ru).

## Installation

Run [api/randomize.sh](https://github.com/dbystruev/Get-Outfit/blob/master/api/randomize.sh) first before building in order to randomize getReponseToken() algorithm both locally and on the server.

### Server installation

You need to create Google spreadsheets for Orders (Answers, Orders, Users sheets) and Quiz (Questions, Answers sheets), create initial apps scripts for both via Tools > Script Editor and Publish > Deploy as web app..., and give them all neccessary permissions.

```bash
clasp login

cd api/orders
clasp push
clasp deployments
clasp deploy -i "<deployment id>" -d "<deployment message>"

cd ../api/quiz
clasp push
clasp deployments
clasp deploy -i "<deployment id>" -d "<deployment message>"
```

### Client installation
```bash
flutter run
```

## Launch Screen

![Launch Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot01.png?raw=true)

## Login Screen

![Login Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot02.png?raw=true)

## Gender Screen

![Gender Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot03.png?raw=true)

## Quiz Screens

![Quiz Screen 1](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot04.png?raw=true)

![Quiz Screen 2](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot05.png?raw=true)

![Quiz Screen 3](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot06.png?raw=true)

![Quiz Screen 4](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot07.png?raw=true)

![Quiz Screen 5](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot08.png?raw=true)

## Plans Screen

![Plans Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot09.png?raw=true)

## Payment Screen

![Payment Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot10.png?raw=true)

## Thank you Screen

![Thank you Screen](https://github.com/dbystruev/Get-Outfit/blob/master/screenshots/screenshot11.png?raw=true)