var gulp = new require('gulp');
var concat = new require('gulp-concat');
var uglify = new require('gulp-uglify');
var cssmin = new require('gulp-cssmin');
var browserSync = new require('browser-sync');
var reload = browserSync.reload;

gulp.task('minify-js', function() {
    return gulp.src(['./js/isotope.pkgd.min.js', './js/venobox.min.js', './js/imagesloaded.js', './js/jquery.form.js', './js/slick.min.js', 'js/jquery.mobile.custom.min.js', './js/angular.min.js', './js/angular-sanitize.min.js', './js/angular-ui-router.min.js', './js/angular-animate.min.js', './js/anim-in-out.js', './js/three.js', './js/spine.js', './js/animation.js'])
        .pipe(concat('./uglify-js.js'))
        .pipe(uglify())
        .pipe(gulp.dest('./js/'))
})


gulp.task('minify-css', function() {
    return gulp.src(['./css/slick.min.css', './css/venobox.css', './css/main.css', './css/animate_banner.css', './css/responsive.css'])
        .pipe(concat('./uglify.css'))
        .pipe(cssmin())
        .pipe(gulp.dest('./css/'))
})

gulp.task('serve', function() {
    browserSync.init({
        server: {
            baseDir: "./"
        }
    });

    gulp.watch('./pages/*.html').on('change', reload);
    gulp.watch('*.html').on('change', reload);
    gulp.watch('./css/*.css').on('change', reload);
})