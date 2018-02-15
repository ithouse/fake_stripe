(function() {
  var Stripe, exports, key, _i, _len,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    _this = this;

  var api = function() {
    var createToken = function(property, data) {
      var token = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
      return new Promise(function(resolve, reject) {
        setTimeout(resolve, 100, {token: {id: token}});
      });
    };

    return {
      createToken: createToken
    };
  }();

  this.Stripe = (function() {

    function Stripe() {
      return api;
    }

    return Stripe;

  }).call(this);

  Stripe = this.Stripe;

  if (typeof module !== "undefined" && module !== null) {
    module.exports = this.Stripe;
  }

  if (typeof define === "function") {
    define('stripe', [], function() {
      return _this.Stripe;
    });
  }

}).call(this);

