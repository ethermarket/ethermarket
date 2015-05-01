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
          "css/lib/bootstrap.min.css"
        ]

      html:
        src: "index.html"

      coffee:
        dest: "generated/dapp/compiled-coffee"
        compiled: [
          "generated/dapp/compiled-coffee/app.js"
          "generated/dapp/compiled-coffee/**/*.js"
        ]

      contracts:
        product: [
          "contracts/ethermarket.sol"
        ]

        democracy: [
          "contracts/base/owned.sol"
          "contracts/base/action.sol"
          "contracts/base/api.sol"
          "contracts/base/ownedApiEnabled.sol"
          "contracts/base/permissions.sol"
          "contracts/base/persistentProtectedContract.sol"
          "contracts/base/permissionsProviderProperty.sol"
          "contracts/base/protectedContract.sol"
          "contracts/base/protectedApi.sol"
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
        dest: "generated/dapp/js/app.min.js"
      css:
        src: "<%= files.css.src %>"
        dest: "generated/dapp/css/app.min.css"
      contracts:
        files:
          "generated/contracts/democracy.sol": '<%= files.contracts.democracy %>'
          "generated/contracts/ethermarket.sol": '<%= files.contracts.product %>'

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
          "generated/dapp/index.html" : "<%= files.html.src %>"
          "dist/dapp/index.html"      : "<%= files.html.src %>"

    server:
      base: "#{process.env.SERVER_BASE || 'generated/dapp'}"
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
        dest: "dist/dapp/js/app.min.js"

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

