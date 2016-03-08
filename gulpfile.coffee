gulp = require 'gulp'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'
webserver = require 'gulp-webserver'

gulp.task 'html', ->
    gulp.src './src/index.html'
    .pipe gulp.dest './dest'

gulp.task 'js', ->
    gulp.src './src/assets/_coffee/*.coffee'
    .pipe plumber()
    .pipe concat 'all.coffee'
    .pipe coffee()
    .pipe gulp.dest './dest/assets/js'
    .pipe gulp.dest './src/assets/js'

gulp.task 'sass', ->
    gulp.src './src/assets/_sass/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe gulp.dest './dest/assets/css'
    .pipe gulp.dest './src/assets/css'

gulp.task 'watch', ->
    gulp.watch './src/assets/_coffee/*.coffee', ['js']
    gulp.watch './src/assets/_sass/*.scss', ['sass']
    gulp.watch './src/index.html', ['html']

gulp.task 'webserver', ->
    gulp.src('./dest')
    .pipe webserver(
        host: '192.168.33.33'
        livereload: true
    )


gulp.task 'default', ['html', 'js', 'sass', 'watch', 'webserver']