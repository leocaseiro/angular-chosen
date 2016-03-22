var config = {
    test: './test',
	src: './src/',
    dist: './dist/',
    file: 'angular-chosen'
};

var banner = ['/**',
  ' * <%= pkg.name %> - <%= pkg.description %>',
  ' * @version v<%= pkg.version %>',
  ' * @link <%= pkg.homepage %>',
  ' * @license <%= pkg.license %>',
  ' */',
  ''].join('\n');

var args = require('yargs').argv,
    gulp = require('gulp'),
    karma = require('karma'),
    del  = require('del'),
    $    = require('gulp-load-plugins')({ lazy: true }),
    pkg  = require('./package.json');

// List Tasks by default
gulp.task('default', $.taskListing.withFilters(null, ['build-hint']));

// without gulp-karma: https://github.com/karma-runner/gulp-karma
gulp.task('test', function(done) {
  new karma.Server({
    configFile: __dirname + '/test/karma.conf.js',
    singleRun: true
  }, done).start();
});

//TODO rewrite Coffee Script of coffeelint()
gulp.task('build-hint', function() {
    return gulp.src(config.src + '/*.coffee')
        .pipe($.if(args.debug, $.debug()))
        .pipe($.plumber())
        .pipe($.coffeelint())
        .pipe($.coffeelint.reporter());
        // .pipe($.jshint())
        // .pipe($.jshint.reporter('jshint-stylish', { verbose: true }));
        // .pipe($.jscs());
});

// gulp.task('build-coffee-script', ['build-hint'], function() {
/**
 * Compile CoffeeScript into ./dist/angular-chose.js
 */
gulp.task('build-coffee-script', function() {
    return gulp.src(config.src + '/*.coffee')
        .pipe($.if(args.debug, $.debug()))
        .pipe($.plumber())
    	.pipe($.coffee().on('error', $.util.log))
    	.pipe($.rename(config.file + '.js'))
        .pipe($.header(banner, { pkg : pkg }))
    	.pipe(gulp.dest(config.dist));
});

/**
 * Minify ./dist/angular-chose.js into ./dist/angular-chose.min.js
 */
gulp.task('build-minify', ['build-coffee-script'], function() {
    return gulp.src(config.dist + '/angular-chosen.js')
        .pipe($.if(args.debug, $.debug()))
        .pipe($.plumber())
        .pipe($.uglify({mangle: true}))
        .pipe($.rename(config.file + '.min.js'))
        .pipe($.header(banner, {pkg : pkg}))
        .pipe(gulp.dest(config.dist));
});

/**
 * Run Clean Javascripts, than minify(coffee-script)
 */
gulp.task('build', ['build-clean-javascripts'], function() {
    gulp.start('build-minify');
});

/**
 * Clean Javascripts from .dist/
 */
gulp.task('build-clean-javascripts', function() {
    return del(config.dist);
});

/**
 * Watch files and compile Coffee Script in real-time
 */
gulp.task('watcher', ['tests'], function() {
    gulp.watch([config.src + '*.coffee', config.dist + '*.js'], ['tests']);
});

gulp.task('test', function (done) {
  new karma.Server({
    configFile: __dirname + '/test/support/karma.conf.js',
      singleRun: true
  }, done).start();
});

gulp.task('tests', ['build-minify'], function (done) {
  new karma.Server({
    configFile: __dirname + '/test/support/karma.conf.js',
    singleRun: false
  }, done).start();
});
