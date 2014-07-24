var gulp = require('gulp'),
    cheerio = require('cheerio'),
    ejs = require('ejs'),
    Qfs = require('q-io/fs'),
    Q = require('q'),
    QS = require('qartulskripti'),
    hljs = require('./src/highlight'),
    path = require('path');

var SRC_PATH = path.resolve('src'),
    TEMPLATE_PATH = SRC_PATH + '/template.html',
    DOCS_PATH = SRC_PATH + '/docs',
    DOCS = [
      [
        'shesavali',
        'node.js',
        'browser'
      ],
      [
        'mimoxilva',
        'js.eqvivalentebi',
        'pirobiti.operatorebi'
      ]
    ];

gulp.task('default', function () {
  var menu = '',
    content = '',
    readDocs = {};

  Q.all(
    Array.prototype.concat.apply([], DOCS).map(function (docFile) {
      return Qfs.read(DOCS_PATH + '/' + docFile + '.html')
        .then(function (content) {
          var $ = cheerio.load(content, { decodeEntities : false }),
            id = $('div').attr('id'),
            name = $('div h2').text();

          $('.qartulskripti-code').each(function () {
            var qs_code = $(this).text().trim(),
                js_code = QS.compile(qs_code, { bare : true });
            $(this).html(
              '<button>გაუშვი</button>' +
              '<pre><code>' + hljs.highlight('qartulskripti', qs_code).value + '</pre></code>' +
              '<pre><code>' + hljs.highlight('javascript', js_code).value + '</pre></code>'
            );
          });

          readDocs[docFile] = {
            id : id,
            name : name,
            content : $.html()
          };
        })
    })
  ).then(function () {
    return Qfs.read(TEMPLATE_PATH)
  }).then(function (template) {
    template = ejs.render(template, {
      DOCS : DOCS,
      content : readDocs
    });

    return Qfs.write('./index.html', template)
  }).catch(function (error) {
    console.error(error);
    console.error(error.stack);
  });
});
