var cache = {};

var app_pre = "system_";

function save(key, value) {
  key = app_pre + key;
  cache[key] = value;
  if (window.localStorage) {
    if (value === undefined || value === null) {
      window.localStorage.removeItem(key);
    } else {
      window.localStorage.setItem(key, JSON.stringify(value));
    }
  }
}

function load(key) {
  key = app_pre + key;
  if (!(key in cache)) {
    var data = window.localStorage.getItem(key);
    // console.log('localstore >', data);
    if (data === null || data === undefined) {
      cache[key] = undefined;
    } else {
      cache[key] = JSON.parse(data);
    }
  }
  return cache[key];
}

function sessionSave(key, value) {
  key = app_pre + key;
  cache[key] = value;
  if (window.sessionStorage) {
    if (value === undefined || value === null) {
      window.sessionStorage.removeItem(key);
    } else {
      window.sessionStorage.setItem(key, JSON.stringify(value));
    }
  }
}

function sessionLoad(key) {
  key = app_pre + key;
  if (!(key in cache)) {
    var data = window.sessionStorage.getItem(key);
    // console.log('session store >', data);
    if (data === null || data === undefined) {
      cache[key] = undefined;
    } else {
      cache[key] = JSON.parse(data);
    }
  }
  return cache[key];
}
