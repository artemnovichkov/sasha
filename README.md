
<p align="center">
<img src=".github/sasha-logo.png" alt="Rosberry Card" />
<a href="https://swift.org">
    <img src="https://img.shields.io/badge/swift-3.1-orange.svg?style=flat" alt="Swift 3.1" />
  </a>
	<img src="https://img.shields.io/badge/make-compatible-brightgreen.svg?style=flat" alt="Make" />
  <a href="https://swift.org/package-manager">
    <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
  </a>
  <a href="https://github.com/JohnSundell/Marathon">
    <img src="https://img.shields.io/badge/marathon-compatible-brightgreen.svg?style=flat" alt="Marathon" />
  </a>
</p>

Sasha is easy-to-use script for folder tree generation.

## Using


Run `sasha` in any folder with project name as first parameter, for example:

```
$ sasha ProjectName
```

By default Sasha uses this project structure:

```
UI
-iOS
--old
--png
-Android
--old
--png
UX
-iOS
--old
--png
-Android
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

To change it, open `/usr/local/bin/project.sasha` file in your favourite text editor and make custom project structure.

## Installing

### Make:

```
$ git clone https://github.com/artemnovichkov/sasha.git
$ cd sasha
$ make
```

### Swift Package Manager:

```
$ git clone https://github.com/artemnovichkov/sasha.git
$ cd sasha
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/sasha /usr/local/bin/sasha
$ cp -f project.sasha /usr/local/bin
```
### Marathon

- Install [Marathon](https://github.com/johnsundell/marathon#installing).
- Add Sasha to Marathon using `$ marathon add git@github.com:artemnovichkov/sasha.git`. Alternatively, add `git@github.com:artemnovichkov/sasha.git` to your `Marathonfile`.
- Write your script, then run it using `$ marathon run <path-to-your-script>`.

## Author

Artem Novichkov, novichkoff93@gmail.com

## License

Sasha is available under the MIT license. See the LICENSE file for more info.

