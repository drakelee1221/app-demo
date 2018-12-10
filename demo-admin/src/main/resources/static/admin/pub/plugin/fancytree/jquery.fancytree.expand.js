;
(function ($) {

    $.ui.fancytree.prototype.options = $.extend(true, {}, $.ui.fancytree.prototype.options, {
        extensions: ["glyph", "clones"],
        clickFolderMode: 1,
        glyph: {
            map: {
                doc: "glyphicon glyphicon-file",
                docOpen: "glyphicon glyphicon-file",
                checkbox: "glyphicon glyphicon-unchecked",
                checkboxSelected: "glyphicon glyphicon-check",
                checkboxUnknown: "glyphicon glyphicon-share",
                error: "glyphicon glyphicon-warning-sign",
                expanderClosed: "glyphicon glyphicon-plus-sign",
                expanderLazy: "glyphicon glyphicon-plus-sign",
                // expanderLazy: "glyphicon glyphicon-expand",
                expanderOpen: "glyphicon glyphicon-minus-sign",
                // expanderOpen: "glyphicon glyphicon-collapse-down",
                folder: "glyphicon glyphicon-folder-close",
                folderOpen: "glyphicon glyphicon-folder-open",
                loading: "glyphicon glyphicon-refresh"
                // loading: "icon-spinner icon-spin"
            }
        },
        wide: {
            iconWidth: "1em",     // Adjust this if @fancy-icon-width != "16px"
            iconSpacing: "0.5em", // Adjust this if @fancy-icon-spacing != "3px"
            levelOfs: "1.5em"     // Adjust this if ul padding != "16px"
        },
        strings: {
            loading: "载入中&#8230;",
            loadError: "加载错误!"
        }
    });

})(jQuery);
