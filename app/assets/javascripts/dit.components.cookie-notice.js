
var dit = {} || dit;
dit.components = {} || dit.components;

dit.components.cookieNotice = (new function() {

  const COOKIE_NOTICE_ID = 'header-cookie-notice';
  const COOKIE_CLOSE_BUTTON_ID = 'dismiss-cookie-notice';

  function viewInhibitor(activate) {
    var rule = '#header-cookie-notice { display: none; }';
    var style;
    if (arguments.length && activate) {
      style = document.createElement('style');
      style.setAttribute('type', 'text/css');
      style.setAttribute('id', 'cookie-notice-view-inhibitor');
      style.appendChild(document.createTextNode(rule));
      document.head.appendChild(style);
    }
    else {
      document.head.removeChild(document.getElementById('cookie-notice-view-inhibitor'));
    }
  };

  // Hide on load
  viewInhibitor(true);

  setCookie = function(name, value, days) {
    if (days) {
      var date = new Date();
      date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
      value += '; expires=' + date.toGMTString();
    }
    document.cookie = name + '=' + value + '; path=/';
  }

  getCookie = function(name) {
    if (document.cookie.length > 0) {
      var start = document.cookie.indexOf(name + '=');
      if (start !== -1) {
        start = start + name.length + 1;
        var end = document.cookie.indexOf(';', start);
        if (end == -1) {
          end = document.cookie.length;
        }
        return unescape(document.cookie.substring(start, end));
      }
    }
    return '';
  }

  hideNoticeAndSetCookie = function() {
    $('#header-cookie-notice').hide();
    setCookie('hide_cookie_notice', true, 30);
  }

  createCloseButton = function() {
    const $container = $('.cookie-notice-container');
    const $closeButton = $('<button>', {
      'class': 'cookie-close',
      'aria-controls': COOKIE_NOTICE_ID,
      'aria-label': 'Close this message',
      id: COOKIE_CLOSE_BUTTON_ID
    });
    $container.append($closeButton);
    return $closeButton;
  }

  closeButtonEventHandler = function() {
    const $button = createCloseButton();

    $button.on('keydown', function(e) {
      // Close on enter or space
      if(e.which === 13 || e.which === 32) {
        hideNoticeAndSetCookie();
      }
    });

    $button.on('click', function(e) {
      hideNoticeAndSetCookie();
      e.preventDefault();
    });
  }

  this.init = function() {
    closeButtonEventHandler();
    let showCookieNotice = !getCookie('hide_cookie_notice');
    if (showCookieNotice) {
      $('#header-cookie-notice').show();
    } else {
      $('#header-cookie-notice').hide();
    }
    viewInhibitor(false);
  }

});

$(document).ready(function() {
  dit.components.cookieNotice.init();
});
