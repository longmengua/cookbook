(self.webpackChunkweb_application_demo=self.webpackChunkweb_application_demo||[]).push([[581],{550:(n,t,e)=>{"use strict";e.d(t,{AW:()=>v,rs:()=>d});var r=e(788),o=e(294),a=(e(697),e(731),e(523)),i=e(177),p=e(122),u=e(779),c=e.n(u),l=(e(864),e(756),e(679),function(n){var t=(0,a.Z)();return t.displayName="Router-History",t}()),s=function(n){var t=(0,a.Z)();return t.displayName="Router",t}();o.Component;o.Component,o.Component;var m={},f=0;function h(n,t){void 0===t&&(t={}),("string"==typeof t||Array.isArray(t))&&(t={path:t});var e=t,r=e.path,o=e.exact,a=void 0!==o&&o,i=e.strict,p=void 0!==i&&i,u=e.sensitive,l=void 0!==u&&u;return[].concat(r).reduce((function(t,e){if(!e&&""!==e)return null;if(t)return t;var r=function(n,t){var e=""+t.end+t.strict+t.sensitive,r=m[e]||(m[e]={});if(r[n])return r[n];var o=[],a={regexp:c()(n,o,t),keys:o};return f<1e4&&(r[n]=a,f++),a}(e,{end:a,strict:p,sensitive:l}),o=r.regexp,i=r.keys,u=o.exec(n);if(!u)return null;var s=u[0],h=u.slice(1),v=n===s;return a&&!v?null:{path:e,url:"/"===e&&""===s?"/":s,isExact:v,params:i.reduce((function(n,t,e){return n[t.name]=h[e],n}),{})}}),null)}var v=function(n){function t(){return n.apply(this,arguments)||this}return(0,r.Z)(t,n),t.prototype.render=function(){var n=this;return o.createElement(s.Consumer,null,(function(t){t||(0,i.Z)(!1);var e=n.props.location||t.location,r=n.props.computedMatch?n.props.computedMatch:n.props.path?h(e.pathname,n.props):t.match,a=(0,p.Z)({},t,{location:e,match:r}),u=n.props,c=u.children,l=u.component,m=u.render;return Array.isArray(c)&&0===c.length&&(c=null),o.createElement(s.Provider,{value:a},a.match?c?"function"==typeof c?c(a):c:l?o.createElement(l,a):m?m(a):null:"function"==typeof c?c(a):null)}))},t}(o.Component);o.Component;var d=function(n){function t(){return n.apply(this,arguments)||this}return(0,r.Z)(t,n),t.prototype.render=function(){var n=this;return o.createElement(s.Consumer,null,(function(t){t||(0,i.Z)(!1);var e,r,a=n.props.location||t.location;return o.Children.forEach(n.props.children,(function(n){if(null==r&&o.isValidElement(n)){e=n;var i=n.props.path||n.props.from;r=i?h(a.pathname,(0,p.Z)({},n.props,{path:i})):t.match}})),r?o.cloneElement(e,{location:a,computedMatch:r}):null}))},t}(o.Component);o.useContext}}]);