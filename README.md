<p align="center">
	<img src=".github/sasha-logo.png" alt="sasha" />
	<a href="https://travis-ci.org/artemnovichkov/sasha">
        <img src="https://travis-ci.org/artemnovichkov/sasha.svg?branch=master" />
	<a href="https://swift.org">
    	<img src="https://img.shields.io/badge/swift-4-orange.svg?style=flat" alt="Swift 4" />
	</a>
		<img src="https://img.shields.io/badge/homebrew-compatible-brightgreen.svg?style=flat" alt="Make" />
  <a href="https://swift.org/package-manager">
  		<img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
	</a>
  	<a href="https://github.com/JohnSundell/Marathon">
  		<img src="https://img.shields.io/badge/marathon-compatible-brightgreen.svg?style=flat" alt="Marathon" />
	</a>
</p>
Sasha is an easy-to-use CLI app for routine designer tasks.

<p align="center">
  <a href="#features">Features</a> • <a href="#using">Using</a> • <a href="#installing">Installing</a> • <a href="#author">Author</a> • <a href="#license">License</a>
</p>

## Features
- Icon slicing for different platforms:
  - iOS
  - watchOS
  - watchOS Complications
  - macOS
  - Carplay
  - Android
  - Android Wear
- Project folder tree generation

## Using

### Icons

Sasha has two main commands - `icons` and `project`.

```bash
$ sasha icons --platform iOS --name icon.png
```
Sasha generates icons in needed resolutions as well. For Apple platforms Sasha generates `AppIcon.appiconset`, which iOS developer can drag and drop right into `Images.xcassets` without manual icon sorting 👨🏻‍💻👍.

There is a [service](https://github.com/artemnovichkov/sasha/issues/5#issuecomment-358310264) for Sasha. Right click on an original icon, select `Services > Sasha, make me iOS icons`.

### Project generation
```bash
$ sasha project --name ProjectName
```
Sasha generates folder tree with name passed via `--name` option. By default Sasha uses this project structure:

```
iOS
-UI
--old
--png
-UX
--old
--png
Android
-UI
--old
--png
-UX
--old
--png
references
-main_screens
-menu
-cards
-another_case
stuff
-logos
-icons
-patterns
-stocks
-source
```
To change it, open `~/.sasha/project.sasha` file in your favourite text editor and make custom project structure.

## Installing

### Homebrew (recommended):

```bash
$ brew install artemnovichkov/projects/sasha
```

### Make:

```bash
$ git clone https://github.com/artemnovichkov/sasha.git
$ cd sasha
$ make
```

### Swift Package Manager:

```bash
$ git clone https://github.com/artemnovichkov/sasha.git
$ cd sasha
$ make build
$ cp -f .build/release/sasha /usr/local/bin/sasha
$ cp -r .sasha ~
```

### Marathon:

- Install [Marathon](https://github.com/johnsundell/marathon#installing).
- Add Files using `$ marathon add https://github.com/artemnovichkov/sasha.git`.
- Run your script using `$ marathon run <path-to-your-script>`.

## Author

Artem Novichkov, novichkoff93@gmail.com

[![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/artemnovichkov?utm_source=github&utm_medium=button&utm_term=artemnovichkov&utm_campaign=github)


## License

Sasha is available under the MIT license. See the LICENSE file for more info.

