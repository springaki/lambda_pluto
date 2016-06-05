gulp   = require("gulp")
lamjet = require("lamjet")
gutil = require("gulp-util");
zip = require("gulp-zip");

lamjet.setup(gulp)

gulp.task "after-compile", ->
  gulp.src('.env').on('error', gutil.log).pipe gulp.dest('./dist')

gulp.task "archive-to-zip", ->

gulp.task "before-archive-to-zip", ->
  gulp.src(["dist/**/*", "dist/.env"]).pipe(zip("dist.zip")).pipe(gulp.dest("./"))
