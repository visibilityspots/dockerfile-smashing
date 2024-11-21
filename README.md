# smashing

[![build status](https://github.com/visibilityspots/dockerfile-smashing/actions/workflows/main.yml/badge.svg)](https://github.com/visibilityspots/dockerfile-smashing/actions/workflows/main.yml)
[![docker image size](https://img.shields.io/docker/image-size/visibilityspots/smashing/latest)](https://hub.docker.com/r/visibilityspots/smashing)
[![docker pulls](https://img.shields.io/docker/pulls/visibilityspots/smashing.svg)](https://hub.docker.com/r/visibilityspots/smashing/)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Run [smashing](https://github.com/Smashing/smashing) in a [Docker](http://docker.io/) container.

## Run

```
docker run -d -p 8080:3030 visibilityspots/smashing
```

and point your browser to [http://localhost:8080/](http://localhost:8080/).

## Configuration

### Custom smashing port

If you want smashing to use a custom port inside the container, e g 8080, use the environment variable `$PORT`:

```
docker run -d -e PORT=8080 -p 80:8080 visibilityspots/smashing
```

### Dashboards

To provide a custom dashboard, use container volume **/dashboards**:

```
docker run -v=/my/custom/dashboards:/dashboards -d -p 8080:3030 visibilityspots/smashing
```

(*Don't forget to also provide the layout.erb*)

### Jobs
To provide custom jobs, use container volume **/jobs**:

```
docker run -v=/my/cool/job:/jobs -d -p 8080:3030 visibilityspots/smashing
```

### Widgets
To install custom widgets supply the gist IDs of the widgets as an environment variable:

```
docker run -d -e WIDGETS=5641535 -p 8080:3030 visibilityspots/smashing
```

This example will install the [Random Aww](https://gist.github.com/chelsea/5641535) widget
before starting smashing. Multiple widgets can be supplied.

Also you can use local custom widgets

```
docker run -v=/my/cool/widgets:/widgets -d -p 8080:3030 visibilityspots/smashing
```

### Gems
To install gems, supply the gem name(s) as an environment variable:

```
docker run -d -e GEMS=instagram -e WIDGETS=5278790 -p 8080:3030 visibilityspots/smashing
```

This example installs the [Instagram photos by location](https://gist.github.com/mjamieson/5278790) widget,
which depends on the instagram gem. Multiple gems and widgets can be supplied like so:

```
docker run -d -e GEMS="mysql instagram" -e WIDGETS=5278790 -p 8080:3030 visibilityspots/smashing
```

### Public (favicon, 404)
To provide custom 404 and favicon, use container volume **/public**.

### Configuration File
The configuration file config.ru is available on volume */config*.

Edit this file to change your API key, to add authentication and more.

### lib volume
The smashing lib dir is available on volume */lib-smashing*.

## Thanks
- [@mattgruter](https://github.com/mattgruter), awsome contributions!
- [@rowanu](https://github.com/rowanu), [Hotness Widget](https://gist.github.com/rowanu/6246149).
- [@munkius](https://github.com/munkius), [fork](https://gist.github.com/munkius/9209839) of Hotness Widget.
- [@chelsea](https://github.com/chelsea), [Random Aww](https://gist.github.com/chelsea/5641535).
- [@bemehow](https://github.com/bemehow)), for the official ruby docker image implementation

## License
Distributed under the MIT license
