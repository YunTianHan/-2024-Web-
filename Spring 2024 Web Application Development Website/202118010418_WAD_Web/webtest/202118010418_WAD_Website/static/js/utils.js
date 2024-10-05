function jump(path) {
  if (path) {
    if (location.href) {
      location.href = path;
    }
    return;
  }
  console.error("path not found!");
}

function getNow() {
  const date = new Date();
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

function getToday() {
  const date = new Date();
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

function formatDate(time) {
  if (!time) return time;
  var date = new Date(time);
  var year = date.getUTCFullYear();
  var month = (date.getUTCMonth() + 1).toString().padStart(2, "0");
  var day = date.getUTCDate().toString().padStart(2, "0");
  var hours = date.getUTCHours().toString().padStart(2, "0");
  var minutes = date.getUTCMinutes().toString().padStart(2, "0");
  return `${year}-${month}-${day}`;
}

function formatDateTime(time) {
  if (!time) return time;
  var date = new Date(time);
  var year = date.getUTCFullYear();
  var month = (date.getUTCMonth() + 1).toString().padStart(2, "0");
  var day = date.getUTCDate().toString().padStart(2, "0");
  var hours = date.getUTCHours().toString().padStart(2, "0");
  var minutes = date.getUTCMinutes().toString().padStart(2, "0");
  var seconds = date.getUTCSeconds().toString().padStart(2, "0");
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}
