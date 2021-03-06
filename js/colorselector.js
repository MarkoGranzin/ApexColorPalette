var colorselector = (function() {
  "use strict";
  var scriptVersion = "1.0.0";
  var util = {
    version: "1.0.5",
    isAPEX: function() {
      if (typeof apex !== "undefined") {
        return true;
      } else {
        return false;
      }
    },
    debug: {
      info: function(str) {
        if (util.isAPEX()) {
          apex.debug.info(str);
        }
      },
      error: function(str) {
        if (util.isAPEX()) {
          apex.debug.error(str);
        } else {
          console.error(str);
        }
      }
    }
  };
  var colors = [
    {
      hex: "#F44336",
      shades: [
        {
          hex: "#FFEBEE"
        },
        {
          hex: "#FFCDD2"
        },
        {
          hex: "#EF9A9A"
        },
        {
          hex: "#E57373"
        },
        {
          hex: "#EF5350"
        },
        {
          hex: "#F44336"
        },
        {
          hex: "#E53935"
        },
        {
          hex: "#D32F2F"
        },
        {
          hex: "#C62828"
        },
        {
          hex: "#B71C1C"
        },
        {
          hex: "#FF8A80"
        },
        {
          hex: "#FF5252"
        },
        {
          hex: "#FF1744"
        },
        {
          hex: "#D50000"
        }
      ]
    },
    {
      name: "PINK",
      hex: "#E91E63",
      shades: [
        {
          hex: "#FCE4EC"
        },
        {
          hex: "#F8BBD0"
        },
        {
          hex: "#F48FB1"
        },
        {
          hex: "#F06292"
        },
        {
          hex: "#EC407A"
        },
        {
          hex: "#E91E63"
        },
        {
          hex: "#D81B60"
        },
        {
          hex: "#C2185B"
        },
        {
          hex: "#AD1457"
        },
        {
          hex: "#880E4F"
        },
        {
          hex: "#FF80AB"
        },
        {
          hex: "#FF4081"
        },
        {
          hex: "#F50057"
        },
        {
          hex: "#C51162"
        }
      ]
    },
    {
      name: "PURPLE",
      hex: "#9C27B0",
      shades: [
        {
          hex: "#F3E5F5"
        },
        {
          hex: "#E1BEE7"
        },
        {
          hex: "#CE93D8"
        },
        {
          hex: "#BA68C8"
        },
        {
          hex: "#AB47BC"
        },
        {
          hex: "#9C27B0"
        },
        {
          hex: "#8E24AA"
        },
        {
          hex: "#7B1FA2"
        },
        {
          hex: "#6A1B9A"
        },
        {
          hex: "#4A148C"
        },
        {
          hex: "#EA80FC"
        },
        {
          hex: "#E040FB"
        },
        {
          hex: "#D500F9"
        },
        {
          hex: "#AA00FF"
        }
      ]
    },
    {
      name: "DEEP PURPLE",
      hex: "#673AB7",
      shades: [
        {
          hex: "#EDE7F6"
        },
        {
          hex: "#D1C4E9"
        },
        {
          hex: "#B39DDB"
        },
        {
          hex: "#9575CD"
        },
        {
          hex: "#7E57C2"
        },
        {
          hex: "#673AB7"
        },
        {
          hex: "#5E35B1"
        },
        {
          hex: "#512DA8"
        },
        {
          hex: "#4527A0"
        },
        {
          hex: "#311B92"
        },
        {
          hex: "#B388FF"
        },
        {
          hex: "#7C4DFF"
        },
        {
          hex: "#651FFF"
        },
        {
          hex: "#6200EA"
        }
      ]
    },
    {
      name: "INDIGO",
      hex: "#3F51B5",
      shades: [
        {
          hex: "#E8EAF6"
        },
        {
          hex: "#C5CAE9"
        },
        {
          hex: "#9FA8DA"
        },
        {
          hex: "#7986CB"
        },
        {
          hex: "#5C6BC0"
        },
        {
          hex: "#3F51B5"
        },
        {
          hex: "#3949AB"
        },
        {
          hex: "#303F9F"
        },
        {
          hex: "#283593"
        },
        {
          hex: "#1A237E"
        },
        {
          hex: "#8C9EFF"
        },
        {
          hex: "#536DFE"
        },
        {
          hex: "#3D5AFE"
        },
        {
          hex: "#304FFE"
        }
      ]
    },
    {
      name: "BLUE",
      hex: "#2196F3",
      shades: [
        {
          hex: "#E3F2FD"
        },
        {
          hex: "#BBDEFB"
        },
        {
          hex: "#90CAF9"
        },
        {
          hex: "#64B5F6"
        },
        {
          hex: "#42A5F5"
        },
        {
          hex: "#2196F3"
        },
        {
          hex: "#1E88E5"
        },
        {
          hex: "#1976D2"
        },
        {
          hex: "#1565C0"
        },
        {
          hex: "#0D47A1"
        },
        {
          hex: "#82B1FF"
        },
        {
          hex: "#448AFF"
        },
        {
          hex: "#2979FF"
        },
        {
          hex: "#2962FF"
        }
      ]
    },
    {
      name: "LIGHT BLUE",
      hex: "#03A9F4",
      shades: [
        {
          hex: "#E1F5FE"
        },
        {
          hex: "#B3E5FC"
        },
        {
          hex: "#81D4FA"
        },
        {
          hex: "#4FC3F7"
        },
        {
          hex: "#29B6F6"
        },
        {
          hex: "#03A9F4"
        },
        {
          hex: "#039BE5"
        },
        {
          hex: "#0288D1"
        },
        {
          hex: "#0277BD"
        },
        {
          hex: "#01579B"
        },
        {
          hex: "#80D8FF"
        },
        {
          hex: "#40C4FF"
        },
        {
          hex: "#00B0FF"
        },
        {
          hex: "#0091EA"
        }
      ]
    },
    {
      name: "CYAN",
      hex: "#00BCD4",
      shades: [
        {
          hex: "#E0F7FA"
        },
        {
          hex: "#B2EBF2"
        },
        {
          hex: "#80DEEA"
        },
        {
          hex: "#4DD0E1"
        },
        {
          hex: "#26C6DA"
        },
        {
          hex: "#00BCD4"
        },
        {
          hex: "#00ACC1"
        },
        {
          hex: "#0097A7"
        },
        {
          hex: "#00838F"
        },
        {
          hex: "#006064"
        },
        {
          hex: "#84FFFF"
        },
        {
          hex: "#18FFFF"
        },
        {
          hex: "#00E5FF"
        },
        {
          hex: "#00B8D4"
        }
      ]
    },
    {
      name: "TEAL",
      hex: "#009688",
      shades: [
        {
          hex: "#E0F2F1"
        },
        {
          hex: "#B2DFDB"
        },
        {
          hex: "#80CBC4"
        },
        {
          hex: "#4DB6AC"
        },
        {
          hex: "#26A69A"
        },
        {
          hex: "#009688"
        },
        {
          hex: "#00897B"
        },
        {
          hex: "#00796B"
        },
        {
          hex: "#00695C"
        },
        {
          hex: "#004D40"
        },
        {
          hex: "#A7FFEB"
        },
        {
          hex: "#64FFDA"
        },
        {
          hex: "#1DE9B6"
        },
        {
          hex: "#00BFA5"
        }
      ]
    },
    {
      name: "GREEN",
      hex: "#4CAF50",
      shades: [
        {
          hex: "#E8F5E9"
        },
        {
          hex: "#C8E6C9"
        },
        {
          hex: "#A5D6A7"
        },
        {
          hex: "#81C784"
        },
        {
          hex: "#66BB6A"
        },
        {
          hex: "#4CAF50"
        },
        {
          hex: "#43A047"
        },
        {
          hex: "#388E3C"
        },
        {
          hex: "#2E7D32"
        },
        {
          hex: "#1B5E20"
        },
        {
          hex: "#B9F6CA"
        },
        {
          hex: "#69F0AE"
        },
        {
          hex: "#00E676"
        },
        {
          hex: "#00C853"
        }
      ]
    },
    {
      name: "LIGHT GREEN",
      hex: "#8BC34A",
      shades: [
        {
          hex: "#F1F8E9"
        },
        {
          hex: "#DCEDC8"
        },
        {
          hex: "#C5E1A5"
        },
        {
          hex: "#AED581"
        },
        {
          hex: "#9CCC65"
        },
        {
          hex: "#8BC34A"
        },
        {
          hex: "#7CB342"
        },
        {
          hex: "#689F38"
        },
        {
          hex: "#558B2F"
        },
        {
          hex: "#33691E"
        },
        {
          hex: "#CCFF90"
        },
        {
          hex: "#B2FF59"
        },
        {
          hex: "#76FF03"
        },
        {
          hex: "#64DD17"
        }
      ]
    },
    {
      name: "LIME",
      hex: "#CDDC39",
      shades: [
        {
          hex: "#F9FBE7"
        },
        {
          hex: "#F0F4C3"
        },
        {
          hex: "#E6EE9C"
        },
        {
          hex: "#DCE775"
        },
        {
          hex: "#D4E157"
        },
        {
          hex: "#CDDC39"
        },
        {
          hex: "#C0CA33"
        },
        {
          hex: "#AFB42B"
        },
        {
          hex: "#9E9D24"
        },
        {
          hex: "#827717"
        },
        {
          hex: "#F4FF81"
        },
        {
          hex: "#EEFF41"
        },
        {
          hex: "#C6FF00"
        },
        {
          hex: "#AEEA00"
        }
      ]
    },
    {
      name: "YELLOW",
      hex: "#FFEB3B",
      shades: [
        {
          hex: "#FFFDE7"
        },
        {
          hex: "#FFF9C4"
        },
        {
          hex: "#FFF59D"
        },
        {
          hex: "#FFF176"
        },
        {
          hex: "#FFEE58"
        },
        {
          hex: "#FFEB3B"
        },
        {
          hex: "#FDD835"
        },
        {
          hex: "#FBC02D"
        },
        {
          hex: "#F9A825"
        },
        {
          hex: "#F57F17"
        },
        {
          hex: "#FFFF8D"
        },
        {
          hex: "#FFFF00"
        },
        {
          hex: "#FFEA00"
        },
        {
          hex: "#FFD600"
        }
      ]
    },
    {
      name: "AMBER",
      hex: "#FFC107",
      shades: [
        {
          hex: "#FFF8E1"
        },
        {
          hex: "#FFECB3"
        },
        {
          hex: "#FFE082"
        },
        {
          hex: "#FFD54F"
        },
        {
          hex: "#FFCA28"
        },
        {
          hex: "#FFC107"
        },
        {
          hex: "#FFB300"
        },
        {
          hex: "#FFA000"
        },
        {
          hex: "#FF8F00"
        },
        {
          hex: "#FF6F00"
        },
        {
          hex: "#FFE57F"
        },
        {
          hex: "#FFD740"
        },
        {
          hex: "#FFC400"
        },
        {
          hex: "#FFAB00"
        }
      ]
    },
    {
      name: "ORANGE",
      hex: "#FF9800",
      shades: [
        {
          hex: "#FFF3E0"
        },
        {
          hex: "#FFE0B2"
        },
        {
          hex: "#FFCC80"
        },
        {
          hex: "#FFB74D"
        },
        {
          hex: "#FFA726"
        },
        {
          hex: "#FF9800"
        },
        {
          hex: "#FB8C00"
        },
        {
          hex: "#F57C00"
        },
        {
          hex: "#EF6C00"
        },
        {
          hex: "#E65100"
        },
        {
          hex: "#FFD180"
        },
        {
          hex: "#FFAB40"
        },
        {
          hex: "#FF9100"
        },
        {
          hex: "#FF6D00"
        }
      ]
    },
    {
      name: "DEEP ORANGE",
      hex: "#FF5722",
      shades: [
        {
          hex: "#FBE9E7"
        },
        {
          hex: "#FFCCBC"
        },
        {
          hex: "#FFAB91"
        },
        {
          hex: "#FF8A65"
        },
        {
          hex: "#FF7043"
        },
        {
          hex: "#FF5722"
        },
        {
          hex: "#F4511E"
        },
        {
          hex: "#E64A19"
        },
        {
          hex: "#D84315"
        },
        {
          hex: "#BF360C"
        },
        {
          hex: "#FF9E80"
        },
        {
          hex: "#FF6E40"
        },
        {
          hex: "#FF3D00"
        },
        {
          hex: "#DD2C00"
        }
      ]
    },
    {
      name: "BROWN",
      hex: "#795548",
      shades: [
        {
          hex: "#EFEBE9"
        },
        {
          hex: "#D7CCC8"
        },
        {
          hex: "#BCAAA4"
        },
        {
          hex: "#A1887F"
        },
        {
          hex: "#8D6E63"
        },
        {
          hex: "#795548"
        },
        {
          hex: "#6D4C41"
        },
        {
          hex: "#5D4037"
        },
        {
          hex: "#4E342E"
        },
        {
          hex: "#3E2723"
        }
      ]
    },
    {
      name: "GREY",
      hex: "#9E9E9E",
      shades: [
        {
          hex: "#FAFAFA"
        },
        {
          hex: "#F5F5F5"
        },
        {
          hex: "#EEEEEE"
        },
        {
          hex: "#E0E0E0"
        },
        {
          hex: "#BDBDBD"
        },
        {
          hex: "#9E9E9E"
        },
        {
          hex: "#757575"
        },
        {
          hex: "#616161"
        },
        {
          hex: "#424242"
        },
        {
          hex: "#212121"
        }
      ]
    },
    {
      name: "BLUE GREY",
      hex: "#607D8B",
      shades: [
        {
          hex: "#ECEFF1"
        },
        {
          hex: "#CFD8DC"
        },
        {
          hex: "#B0BEC5"
        },
        {
          hex: "#90A4AE"
        },
        {
          hex: "#78909C"
        },
        {
          hex: "#607D8B"
        },
        {
          hex: "#546E7A"
        },
        {
          hex: "#455A64"
        },
        {
          hex: "#37474F"
        },
        {
          hex: "#263238"
        }
      ]
    }
  ];
  var currentColor;
  var colorpalette = {
    picker: {
      show: function(jsonData, pItemID) {
        try {
          // remove existing if exist
          if ($("#matDesignColors").length == 1) {
            $("#matDesignColors").fadeOut();
            $("#matDesignColors").remove();
          }

          // set blur handling active
          $("#matDesignColors").data("bluractive", true);
          //create a new one
          var offset = $("#" + pItemID).offset();
          var left = offset.left + "px";
          var top = offset.top + "px";
          var color = $("<div></div>")
            .attr("id", "matDesignColors")
            .css("max-width", "90%")
            .css("position", "absolute")
            .css("top", top)
            .css("left", left)
            .css("z-index", "9999")
            .css("padding", "10px")
            .css("display", "block")
            .css("overflow-wrap", "break-word")
            .css("word-wrap", "break-word")
            .css("-ms-hyphens", "auto")
            .css("-moz-hyphens", "auto")
            .css("-webkit-hyphens", "auto")
            .css("hyphens", "auto");
          $("body").append(color);

          // fill the color first wit preview color
          $.each(jsonData, function(index, value) {
            $("#matDesignColors").append(
              '<div class="circle pre" style ="background-color:' +
                value.hex +
                '">&nbsp;</div>'
            );
            // on click with color for selection
            $("#matDesignColors")
              .children()
              .last()
              .on("click", function(event) {
                if (value.hasOwnProperty("shades")) {
                  // a pre selelected color is clicked replace the preselction colors with the gradient color  of the selction
                  $.each(value.shades, function(index, value) {
                    $("#matDesignColors").append(
                      '<div class="circle" style ="background-color:' +
                        value.hex +
                        '">&nbsp;</div>'
                    );
                    $("#matDesignColors")
                      .children()
                      .last()
                      .on("click", function(event) {
                        colorpalette.picker.setColor(pItemID, value.hex);
                      });
                  });
                  $("div").remove(".pre");
                  $("#" + pItemID).focus();
                } else {
                  colorpalette.picker.setColor(pItemID, value.hex);
                }
              });

            // blur handling
            $("#matDesignColors").on("mouseenter", function(e) {
              $("#matDesignColors").data("bluractive", false);
            });
            $("#matDesignColors").on("mouseleave", function(e) {
              $("#matDesignColors").data("bluractive", true);
            });
            $("#" + pItemID).on("blur", function(e) {
              if ($("#matDesignColors").data("bluractive")) {
                $("#matDesignColors").fadeOut();
                $("#matDesignColors").remove();

                // reset with last existing valuecolorpalette.picker.setColor(pItemID, currentColor);
              }
            });
          });

          // after create div set it visible
          $("#matDesignColors").css("visibility", "visible");
        } catch (e) {
          util.debug.error("Error while try to show colors");
          util.debug.error(e);
        }
      },
      // remove the container on blur and click
      remove: function() {
        $("#matDesignColors").remove();
      },

      // set the preview color and writ the name in the item
      setColor: function(pItemID, bgColor, setValue) {
        if (typeof setValue === "undefined" || setValue === null) {
          setValue = true;
        }
        // the container exists -> set the color close the div
        $("#matDesignColors").fadeOut();
        $("#matDesignColors").remove();
        $("#" + pItemID + "_bgcolor").css("background-color", bgColor);
        if (setValue) {
          apex.item(pItemID).setValue(bgColor);
          currentColor = bgColor;
        }
      }
    }
  };
  return {
    // Initialize function for cards
    initialize: function(pItemID, pData) {
      var jsonData;
      try {
        if (pData == null || pData.length == 0) {
          jsonData = colors;
        } else {
          jsonData = JSON.parse(pData);
        }
        // catch the element
        var inputElement = "#" + pItemID;
        var inputContainer = $(inputElement);

        // set color
        setInputColor($("#" + pItemID).val());

        // the position of the preview item & text
        var heightContainer = inputContainer
          .closest(".t-Form-itemWrapper")
          .height();
        $("#" + pItemID + "_bgcolor").css("margin", heightContainer / 2 - 7);
        inputContainer.css("padding-left", heightContainer);
        $("#" + pItemID + "_DISPLAY").css("padding-left", heightContainer);

        // on click show the picker
        inputContainer.click(function(e) {
          colorpalette.picker.show(jsonData, pItemID);
        });
        $("#" + pItemID + "_button").click(function(e) {
          colorpalette.picker.show(jsonData, pItemID);
        });

        // set check the value if color set it else white
        function setInputColor(bgColor) {
          var isOk = /(^#[0-9A-F]{6}$)|(^#[0-9A-F]{3}$)/i.test(bgColor);
          if (isOk) {
            colorpalette.picker.setColor(pItemID, bgColor);
          } else {
            colorpalette.picker.setColor(pItemID, "#FFFFFF", false);
          }
        }
      } catch (e) {
        util.debug.error("Error while try to show colors");
        util.debug.error(e);
      }
    }
  };
})();
