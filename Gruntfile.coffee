module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    compass:
      dist:
        options:
          sassDir: 'src/scss'
          cssDir: 'public/css'

    coffee:
      dist:
        options:
          join: true
        files:
          'public/js/index.js': ['src/coffee/**/*.coffee']

    haml:
      dist:
        files: [
          expand: true
          cwd: 'src/haml'
          src: ['**/*.haml']
          dest: 'public'
          ext: '.html'
        ]

    #imagemin:
      #dynamic:
        #files: [
          #expand: true
          #cwd: 'src/images'
          #src: ['**/*.{png,jpg,gif}']
          #dest: 'public/images'
        #]

    watch:
      sass:
        files: 'src/scss/**/*.scss'
        tasks: ['compass']
      coffee:
        files: 'src/coffee/**/*.coffee'
        tasks: ['coffee']
      haml:
        files: 'src/haml/**/*.haml'
        tasks: ['haml']
      images:
        files: 'src/images/**'
        #tasks: ['imagemin']

  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-haml')
  #grunt.loadNpmTasks('grunt-contrib-imagemin')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('compile', ['compass', 'coffee', 'haml'])
  grunt.registerTask('default', ['compile', 'watch'])
