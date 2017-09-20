
<p align="center">
	<img src=".github/sasha-logo.png" alt="sasha" />
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

## Features
- Project folder tree generation
- iOS and Android icon slicing

## Using
Sasha has two main commands - `project` and `icons`.

```bash
$ sasha project
```
Sasha asks new project name and generates folder tree. By default Sasha uses this project structure:

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

```bash
$ sasha icons
```
Sasha asks target platform (iOS or Android), name of original image and generates icons in needed resolutions. For iOS platform Sasha generates `AppIcon.appiconset`, which iOS developer can drag and drop right into `Images.xcassets` w/o manual icon sorting 👨🏻‍💻👍.

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
$ swift build -c release -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
$ cp -f .build/release/sasha /usr/local/bin/sasha
$ cp -r .sasha ~
```
By default SPM [hardcodes](https://github.com/apple/swift-package-manager/blob/c62bd0bb8c7669fd284e6e3b2fc82f9708334b4f/Sources/Xcodeproj/pbxproj().swift#L118) the deployment target to macOS 10.10. Read more [here](https://oleb.net/blog/2017/04/swift-3-1-package-manager-deployment-target/).

### Marathon:

- Install [Marathon](https://github.com/johnsundell/marathon#installing).
- Add Sasha to Marathon using `$ marathon add git@github.com:artemnovichkov/sasha.git`. Alternatively, add `git@github.com:artemnovichkov/sasha.git` to your `Marathonfile`.
- Write your script, then run it using `$ marathon run <path-to-your-script>`.

## TODO
 - [ ] Remove hardcoded paths for Sketch templates
 - [ ] Add flags for platform selection: macOS, watchOS, Carplay

## Author

Artem Novichkov, novichkoff93@gmail.com

## License

Sasha is available under the MIT license. See the LICENSE file for more info.

