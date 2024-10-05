const BASE_URL = "http://127.0.0.1:5000";
let loadIndex = 0;
let headers = {
  "Content-Type": "application/json",
};

function get(url, ...reset) {
  ajax(url, "GET", ...reset);
}

function post(url, ...reset) {
  ajax(url, "POST", ...reset);
}

function showLoading() {
  this.layerIndex += 1;
  let loadingHtml = `<div class="overlay">
      <span class="loading">Loading...</span>
    </div>`;
  $("body").append(loadingHtml);
}

function hideLoading() {
  $(".overlay").remove();
}

function ajax(url, type, params, successfn, errorfn) {
  url =
    url.startsWith("/") || url.startsWith("//") || url.startsWith("http")
      ? url
      : BASE_URL + url;
  if (!loadIndex) {
    showLoading();
  }
  loadIndex += 1;
  $.ajax({
    url,
    type: type,
    headers,
    data: JSON.stringify(params || {}),
    dataType: "json",
    success: function (res) {
      loadIndex -= 1;
      if (!loadIndex) {
        hideLoading();
      }
      if (res && res.code === 0) {
        successfn && successfn(res);
        return;
      }

      if (res && res.message) {
        alert(res.message);
      }
      errorfn && errorfn(res);
    },
    error: function (err) {
      console.log("reeeee", err);
      loadIndex -= 1;
      if (!loadIndex) {
        hideLoading();
      }
      errorfn && errorfn(err);
    },
    complete: function () {
      // loadIndex -= 1;
      // if (!loadIndex) {
      //   hideLoading();
      // }
    },
  });
}

function upload(url, formData, successfn, errorfn) {
  url =
    url.startsWith("/") || url.startsWith("//") || url.startsWith("http")
      ? url
      : BASE_URL + url;
  if (!loadIndex) {
    showLoading();
  }
  loadIndex += 1;
  $.ajax({
    url,
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (res) {
      successfn && successfn(res);
    },
    error: function (err) {
      errorfn && errorfn(err);
      if (err) {
        alert("Data request failed, please try again later!");
      }
    },
    complete: function (data) {
      loadIndex -= 1;
      if (!loadIndex) {
        hideLoading();
      }
    },
  });
}
