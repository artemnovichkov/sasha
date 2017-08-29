
# Sasha
[![Swift 4.0](https://img.shields.io/badge/swift-3.1-orange.svg?style=flat)](#)
[![Make](https://img.shields.io/badge/make-compatible-brightgreen.svg?style=flat)](#)
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![Marathon](https://img.shields.io/badge/marathon-compatible-brightgreen.svg?style=flat)](https://github.com/JohnSundell/Marathon)

Sasha is easy-to-use script for folder tree generation.

## Using

At first, you should create a configuration file with name `project.sasha` in script directory (`/usr/local/bin` by default) and fill it out with needed project structure, for example:

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
-main-screens
-menu
-cards
-another-case
stuff
-logos
-icons
-patterns
-stocks
-source
```

Use dashes for different folder levels.

Than just run `sasha` in any folder with project name as first parameter, for example:

```
$ sasha Facebook
```

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
```
### Marathon

- Install [Marathon](https://github.com/johnsundell/marathon#installing).
- Add Carting to Marathon using `$ marathon add git@github.com:artemnovichkov/sasha.git`. Alternatively, add `git@github.com:artemnovichkov/sasha.git` to your `Marathonfile`.
- Write your script, then run it using `$ marathon run <path-to-your-script>`.

## Author

Artem Novichkov, novichkoff93@gmail.com

## License

Sasha is available under the MIT license. See the LICENSE file for more info.

