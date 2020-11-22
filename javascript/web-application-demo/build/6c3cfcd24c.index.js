(self["webpackChunkweb_application_demo"] = self["webpackChunkweb_application_demo"] || []).push([["index"],{

/***/ "./node_modules/express/lib sync recursive":
/*!****************************************!*\
  !*** ./node_modules/express/lib/ sync ***!
  \****************************************/
/*! default exports */
/*! exports [not provided] [maybe used in runtime~index (runtime-defined)] */
/*! runtime requirements: module, __webpack_require__.o */
/***/ ((module) => {

function webpackEmptyContext(req) {
	var e = new Error("Cannot find module '" + req + "'");
	e.code = 'MODULE_NOT_FOUND';
	throw e;
}
webpackEmptyContext.keys = () => [];
webpackEmptyContext.resolve = webpackEmptyContext;
webpackEmptyContext.id = "./node_modules/express/lib sync recursive";
module.exports = webpackEmptyContext;

/***/ }),

/***/ "./server/main.ts":
/*!************************!*\
  !*** ./server/main.ts ***!
  \************************/
/*! namespace exports */
/*! runtime requirements: __webpack_require__, __webpack_require__.n, __webpack_require__.* */
/***/ ((__unused_webpack_module, __unused_webpack___webpack_exports__, __webpack_require__) => {

"use strict";
/* harmony import */ var express__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! express */ "./node_modules/express/index.js");
/* harmony import */ var express__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(express__WEBPACK_IMPORTED_MODULE_0__);
Object(function webpackMissingModule() { var e = new Error("Cannot find module 'fs'"); e.code = 'MODULE_NOT_FOUND'; throw e; }());
Object(function webpackMissingModule() { var e = new Error("Cannot find module 'path'"); e.code = 'MODULE_NOT_FOUND'; throw e; }());
/* harmony import */ var mongoose__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! mongoose */ "./node_modules/mongoose/dist/browser.umd.js");
/* harmony import */ var mongoose__WEBPACK_IMPORTED_MODULE_2___default = /*#__PURE__*/__webpack_require__.n(mongoose__WEBPACK_IMPORTED_MODULE_2__);
/* harmony import */ var _repository_Profile__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! ./repository/Profile */ "./server/repository/Profile/index.ts");





var initDB = function () {
    var uri = "mongodb+srv://admin:admin@cluster0.74fjw.gcp.mongodb.net/demo?retryWrites=true&w=majority";
    mongoose__WEBPACK_IMPORTED_MODULE_2__.connect(uri, { useNewUrlParser: true, useUnifiedTopology: true })
        .then(function (r) { return r; });
    var db = mongoose__WEBPACK_IMPORTED_MODULE_2__.connection;
    db.on('error', console.error.bind(console, 'connection error:'));
    db.once('open', function () {
        console.log("we're connected!");
    });
};
var app = express__WEBPACK_IMPORTED_MODULE_0__();
var port = 8000;
initDB();
app.listen(port, function () {
    console.log('App is listening ' + port);
});
/**
 * root path
 * */
app.get('/', function (req, res) {
    res.send('Hello World!');
});
/**
 * this is for mock server.
 * */
app.get('/json/:name', function (req, res, next) {
    var sourcePath = Object(function webpackMissingModule() { var e = new Error("Cannot find module 'path'"); e.code = 'MODULE_NOT_FOUND'; throw e; }())('src/json/');
    var name = req.params['name'];
    // const param = req.query['p'];
    var stream = Object(function webpackMissingModule() { var e = new Error("Cannot find module 'fs'"); e.code = 'MODULE_NOT_FOUND'; throw e; }())(Object(function webpackMissingModule() { var e = new Error("Cannot find module 'path'"); e.code = 'MODULE_NOT_FOUND'; throw e; }())(sourcePath, name + ".json"));
    stream.pipe(res);
});
(0,_repository_Profile__WEBPACK_IMPORTED_MODULE_3__.default)(app, mongoose__WEBPACK_IMPORTED_MODULE_2__);


/***/ }),

/***/ "./server/repository/Profile/index.ts":
/*!********************************************!*\
  !*** ./server/repository/Profile/index.ts ***!
  \********************************************/
/*! namespace exports */
/*! export default [provided] [used in runtime~index] [could be renamed] */
/*! runtime requirements: __webpack_exports__, __webpack_require__.d, __webpack_require__.* */
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => __WEBPACK_DEFAULT_EXPORT__
/* harmony export */ });
var path = "/Profile";
var Profile = function (app, mongoose) {
    app.get(path, function (req, response, next) {
        //todo: implement get method
        response.send("Get request on " + req.baseUrl + path);
    });
    app.post(path, function (req, response, next) {
        //todo: implement post method
        response.send("Post request on " + req.baseUrl + path);
    });
    app.put(path, function (req, response, next) {
        //todo: implement put method
        response.send("Put request on " + req.baseUrl + path);
    });
    app.delete(path, function (req, response, next) {
        //todo: implement delete method
        response.send("Delete request on " + req.baseUrl + path);
    });
};
/* harmony default export */ const __WEBPACK_DEFAULT_EXPORT__ = (Profile);


/***/ }),

/***/ "?2e00":
/*!*******************************!*\
  !*** ./extend-node (ignored) ***!
  \*******************************/
/*! unknown exports (runtime-defined) */
/*! runtime requirements:  */
/***/ (() => {

/* (ignored) */

/***/ }),

/***/ "?ec5d":
/*!***************************!*\
  !*** ./streams (ignored) ***!
  \***************************/
/*! unknown exports (runtime-defined) */
/*! runtime requirements:  */
/***/ (() => {

/* (ignored) */

/***/ }),

/***/ "?d356":
/*!**********************!*\
  !*** http (ignored) ***!
  \**********************/
/*! unknown exports (runtime-defined) */
/*! runtime requirements:  */
/***/ (() => {

/* (ignored) */

/***/ })

},
0,[["./server/main.ts","runtime~index","vendor.node_modules_accepts_index_js_53831da9","vendor.node_modules_array-flatten_array-flatten_js_06e99e92","vendor.node_modules_body-parser_index_js_15038b17","vendor.node_modules_body-parser_lib_read_js_35080990","vendor.node_modules_body-parser_lib_types_j","vendor.node_modules_body-parser_node_modules_d","vendor.node_modules_bytes_index_js_f2483ec4","vendor.node_modules_con","vendor.node_modules_cookie_index_js_8958bf88","vendor.node_modules_d","vendor.node_modules_etag_index_js_638805e4","vendor.node_modules_events_events_js_faa137ad","vendor.node_modules_express_index_js_b97db169","vendor.node_modules_express_lib_a","vendor.node_modules_express_lib_middleware_i","vendor.node_modules_express_lib_request_js_4e7b39d9","vendor.node_modules_express_lib_response_js_7b3868b1","vendor.node_modules_express_lib_router_i","vendor.node_modules_express_lib_router_route_js_2bd18cf6","vendor.node_modules_express_lib_u","vendor.node_modules_express_node_modules_d","vendor.node_modules_fi","vendor.node_modules_fresh_index_js_04c26316","vendor.node_modules_http-errors_i","vendor.node_modules_iconv-lite_encodings_dbcs-codec_js_90c96e90","vendor.node_modules_iconv-lite_encodings_d","vendor.node_modules_iconv-lite_encodings_sbcs-c","vendor.node_modules_iconv-lite_encodings_sbcs-data-generated_js_80bc198c","vendor.node_modules_iconv-lite_encodings_tables_big5-added_json_71f0060a","vendor.node_modules_iconv-lite_encodings_tables_cp936_json_b2fd92fd","vendor.node_modules_iconv-lite_encodings_tables_cp949_json_e56450f1","vendor.node_modules_iconv-lite_encodings_tables_cp950_json_86d7cd9b","vendor.node_modules_iconv-lite_encodings_tables_eucjp_json_4981c3fb","vendor.node_modules_iconv-lite_encodings_tables_g","vendor.node_modules_iconv-lite_encodings_utf1","vendor.node_modules_iconv-lite_lib_b","vendor.node_modules_inherits_inherits_browser_js_3fb5cc4e","vendor.node_modules_ipaddr_js_lib_ipaddr_js_aa9eef5d","vendor.node_modules_med","vendor.node_modules_me","vendor.node_modules_mime-db_db_json_ea72a239","vendor.node_modules_mime_types_json_c50abde6","vendor.node_modules_mongoose_dist_browser_umd_js_8c0d224e","vendor.node_modules_negotiator_i","vendor.node_modules_on-finished_index_js_0bad19e1","vendor.node_modules_par","vendor.node_modules_proxy-addr_index_js_38757243","vendor.node_modules_qs_lib_formats_js_b31391f7","vendor.node_modules_qs_lib_i","vendor.node_modules_qs_lib_s","vendor.node_modules_querystring_d","vendor.node_modules_range-parser_index_js_451fe5d4","vendor.node_modules_raw-body_index_js_7db9abcc","vendor.node_modules_safer-buffer_safer_js_c5919461","vendor.node_modules_send_index_js_87ae7f23","vendor.node_modules_send_node_modules_d","vendor.node_modules_send_node_modules_ms_index_js_27c6e5c4","vendor.node_modules_se","vendor.node_modules_t","vendor.node_modules_ur","vendor.node_modules_url_url_js_0b163432","vendor.node_modules_vary_index_js_4b16f318"]]]);
//# sourceMappingURL=6c3cfcd24c.index.js.map