jQuery.fn.selectFilter = function (options) {
  let defaults = {
    callBack: function (res) {},
  };
  let ops = $.extend({}, defaults, options);
  let selectList = $(this).find("select option");
  let that = this;
  let html = "";

  // 读取select 标签的值
  html += '<ul class="filter-list">';

  $(selectList).each(function (idx, item) {
    let val = $(item).val();
    let valText = $(item).html();
    let selected = $(item).attr("selected");
    let disabled = $(item).attr("disabled");
    let isSelected = selected ? "filter-selected" : "";
    let isDisabled = disabled ? "filter-disabled" : "";
    if (selected) {
      html +=
        '<li class="' +
        isSelected +
        '" data-value="' +
        val +
        '"><a title="' +
        valText +
        '">' +
        valText +
        "</a></li>";
      $(that).find(".filter-title").val(valText);
    } else if (disabled) {
      html +=
        '<li class="' +
        isDisabled +
        '" data-value="' +
        val +
        '"><a>' +
        valText +
        "</a></li>";
    } else {
      html +=
        '<li data-value="' +
        val +
        '"><a title="' +
        valText +
        '">' +
        valText +
        "</a></li>";
    }
  });

  html += "</ul>";
  $(that).append(html);
  $(that).find("select").hide();

  //点击选择
  $(that).on("click", ".filter-text", function () {
    $(that).find(".filter-list").slideToggle(100);
    $(that).find(".filter-list").toggleClass("filter-open");
    $(that).find(".icon-filter-arrow").toggleClass("filter-show");
  });

  //点击选择列表
  $(that)
    .find(".filter-list li")
    .not(".filter-disabled")
    .on("click", function () {
      let val = $(this).data("value");
      console.log("that==", that);
      let valText = $(this).find("a").html();
      $(that).find(".filter-title").val(valText);
      $(that).find(".icon-filter-arrow").toggleClass("filter-show");
      $(this)
        .addClass("filter-selected")
        .siblings()
        .removeClass("filter-selected");
      $(this).parent().slideToggle(50);
      for (let i = 0; i < selectList.length; i++) {
        let selectVal = selectList.eq(i).val();
        if (val == selectVal) {
          $(that).find("select").val(val);
        }
      }
      ops.callBack(val); //返回值
    });

  //其他元素被点击则收起选择
  $(document).on("mousedown", function (e) {
    closeSelect(that, e);
  });
  $(document).on("touchstart", function (e) {
    closeSelect(that, e);
  });

  function closeSelect(that, e) {
    let filter = $(that).find(".filter-list"),
      filterEl = $(that).find(".filter-list")[0];
    let filterBoxEl = $(that)[0];
    let target = e.target;
    if (
      filterEl !== target &&
      !$.contains(filterEl, target) &&
      !$.contains(filterBoxEl, target)
    ) {
      filter.slideUp(50);
      $(that).find(".filter-list").removeClass("filter-open");
      $(that).find(".icon-filter-arrow").removeClass("filter-show");
    }
  }
};
