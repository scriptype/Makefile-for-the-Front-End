![Screenshot of Makefile](https://cdn.pbrd.co/images/1C4pcDgo.png)

# Makefile for the Front End

I've used this Makefile for a fast development environment for a side-project 
that I no longer continue.

You can clone this repository to kickstart a frontend project. Required folder 
structure is set up for Makefile to work.

## Why Make?

I'm using Make to manage ops-side of my front-end projects because it's simple.
In Gulp, Grunt or Webpack or any other tool, you have to comprehend the complexity
of programmatic usage and learn to use how some 3rd party abstraction works.

When, instead, Make is used for the same tasks, it's much easier for anyone to
contribute, fix or make any kind of change on the build script (at least for me). 
It's not asynchronous, it doesn't give you abstractions to "make your job easier". 
It's flat. You read a Makefile in sequential order, with no indirection.

## Setup

You need `Node` and `npm` installed on your machine which is capable of running 
Makefiles (i.e: not Windows as far as I know).

```
# Clone the repository
git clone git@github.com:scriptype/Makefile-for-the-Front-End.git

# Go to project directory
cd Makefile-for-the-Front-End

# Install dependencies
npm i
```

Besides modules used in Makefile, `react` and `react-dom` for JS and 
`express` for dev-server will also be installed. They are not mandatory.

## Run

#### Development

```sh
make

# in a separate session:
node server dev
```

When finished, head over to `localhost:8989/dist`

#### Production

```sh
make release

# in a separate session:
node server prod
```

When finished, head over to `localhost:8989`

## Notes

  - It's far from being perfect (and it's not intented to be).

  - `Express` dependency is for `server.js`. You can remove it and handle 
  dev-server however you like. `env.js` is also used only in `server.js`

  - JS files are preprocessed for compiling `JSX` and enabling `ES2015` syntax.

  - `Watchify` is used in combination with `livereload` for JS source.

  - Handlebars is used in `index.html` to dynamically manipulate the path of JS 
  and CSS files according to environment. It also calls livereload script in dev mode.

  - No CSS pre-processor was used. CSS files are completely static in dev mode and 
  source files are directly used. You get an experience similar to  prototyping in 
  browser thanks to livereload.

  - As `src/style.css` is used during development, your __dev server should serve 
  root directory__ of project instead of only `/dist`. Yet since `index.html` is 
  still in /dist, in order to view the page in browser, __you should type 
  `localhost:port/dist` in address bar__. This is not a problem after release.

  - You can see `@import` rules actually cause requests to css files in dev mode.

  - When releasing the project:

    - `@import`ed css files will be concatenated into a single file.

    - CSS will be autoprefixed.

    - JS modules will be babelified to normalize JSX and ES2015.

    - HTML, JS and CSS outputs will be minified.

## Contribution

Don't hesitate to open issues and making pull requests. When doing that, consider 
this boilerplate is aimed to have minimum complexity. e.g: Implementing redux for JS 
is out of scope of this project.

## Licence
MIT License

Copyright (c) 2016 Mustafa Enes Ertarhanacı

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
