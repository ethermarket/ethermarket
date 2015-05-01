module.exports = (grunt) ->

  # task configurations
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    banner: "/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - " +
      "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n" +
      "<%= pkg.homepage ? \"* \" + pkg.homepage + \"\\n\" : \"\" %>" +
      "* Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %>;" +
      " Licensed <%= _.pluck(pkg.licenses, \"type\").join(\", \") %> */\n"

    files:
      js:
        vendor: [
          "js/lib/jquery.min.js"
          "js/lib/underscore.js"
          "js/lib/json2.js"
          "js/lib/backbone.js"
          "js/lib/backbone.marionette.min.js"
          "js/lib/bootstrap.min.js"
          "js/lib/web3.js"
        ]

        src: [
          "js/ethermarket/**/*.js"
          "js/app.js"
        ]

      css:
        src: [
          "stylesheets/lib/bootstrap.min.css"
        ]
      html:
        src: "index.html"

      coffee:
        dest: "generated/compiled-coffee"
        compiled: [
          "generated/compiled-coffee/app.js"
          "generated/compiled-coffee/**/*.js"
        ]

    coffee:
      compile:
        expand: true
        cwd: 'coffee'
        src: '**/*.coffee'
        dest: '<%= files.coffee.dest %>'
        ext: '.js'

    concat:
      app:
        src: ["<%= files.js.vendor %>", "<%= files.coffee.compiled %>"]
        dest: "generated/js/app.min.js"
      css:
        src: "<%= files.css.src %>"
        dest: "generated/css/app.min.css"

    watch:
      options:
        livereload: true

      html:
        files: ["<%= files.html.src %>"]
        tasks: ["copy"]

      js:
        files: ["<%= files.js.vendor %>"]
        tasks: ["concat"]

      css:
        files: ["<%= concat.css.src %>"]
        tasks: ["concat"]

      coffee:
        files: ["coffee/**/*.coffee"]
        tasks: ["coffee", "concat"]

    copy:
      html:
        files:
          "generated/index.html" : "<%= files.html.src %>"
          "dist/index.html"      : "<%= files.html.src %>"

    server:
      base: "#{process.env.SERVER_BASE || 'generated'}"
      web:
        port: 8000

    open:
      dev:
        path: "http://localhost:<%= server.web.port %>"

    uglify:
      options:
        banner: "<%= banner %>"

      dist:
        src: "<%= concat.app.dest %>" # input from the concat process
        dest: "dist/js/app.min.js"

    clean:
      workspaces: ["dist", "generated"]

  # loading local tasks
  grunt.loadTasks "tasks"

  # loading external tasks (aka: plugins)
  # Loads all plugins that match "grunt-", in this case all of our current plugins
  require('matchdep').filterAll('grunt-*').forEach(grunt.loadNpmTasks)

  # creating workflows
  grunt.registerTask "default", ["coffee", "concat", "copy", "server", "open", "watch"]
  grunt.registerTask "build", ["clean", "coffee", "concat", "uglify", "copy"]
  grunt.registerTask "prodsim", ["build", "server", "open", "watch"]

