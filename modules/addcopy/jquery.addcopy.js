/**
 * @author Dmitry Bashkatov
 * @desc Adds a links to the copied text. Based on jquery.addtocopy by Falchenko Maxim aka be3.
 *       Requires rangy (http://code.google.com/p/rangy/).
 * @version 1.0
 * @example
 * $(document).addcopy();
 * @license free
 **/

jQuery.fn.addcopy = function(opts) {
    var options = {
        middle: ' <a href="'+window.location.href+'">'+window.location.href+'</a> ',
        footer: '<br/>Source: <a href="'+window.location.href+'">'+window.location.href+'</a>',
        minlen: 25
    };
    $.extend(options, opts);

    var createMiddle = function() {
        var sp = document.createElement('span');
        sp.className = 'addcopy-mid';
        sp.innerHTML = options.middle;
        return sp;
    };

    var createFooter = function() {
        var sp = document.createElement('span');
        sp.className = 'addcopy-foot';
        sp.innerHTML = options.footer;
        return sp;
    };

    var getCommonAncestor = function(a, b) {
        var parents= $(a).parents().andSelf();
        while (b) {
            var ix= parents.index(b);
            if (ix!==-1)
                return b;
            b= b.parentNode;
        }
        return null;
    };

    var getElementsBetweenTree = function(start, end) {
        var ancestor= getCommonAncestor(start, end);

        var before= [];
        while (start.parentNode!==ancestor) {
            var el= start;
            while (el.nextSibling)
                before.push(el= el.nextSibling);
            start= start.parentNode;
        }

        var after= [];
        while (end.parentNode!==ancestor) {
            var el= end;
            while (el.previousSibling)
                after.push(el= el.previousSibling);
            end= end.parentNode;
        }
        after.reverse();

        while ((start= start.nextSibling)!==end)
            before.push(start);
        return before.concat(after);
    };

    var onMouseUp = function() {
        var sel = rangy.getSelection();
        var seltxt = sel.toString();
        if (!seltxt || seltxt.length < options.minlen) {
            return;
        }

        var anchors = [];
        var selectionLength = 0;
        var addAnchorsFromTextNode = function(node, startOffset, endOffset) {
            if (node.nodeType != /*Node.TEXT_NODE*/3) {
                return;
            }

            var text = node.nodeValue;
            if (startOffset != undefined) {
                text = text.slice(startOffset);
            } else {
                startOffset = 0;
            }
            if (endOffset != undefined) {
                text = text.slice(0, endOffset-startOffset);
            }

            text.replace(/(\. )|(, )|(\? )|(! )|(- )|(: )/g, function(str) {
                var offset = arguments[arguments.length-2];
                var offsetInTheNode = startOffset + offset;
                var offsetInTheSelection = selectionLength + offsetInTheNode;
                anchors.push([node, offsetInTheNode+2, offsetInTheSelection+2]);
                return str;
            });

            selectionLength += text.length;
        };

        var addAnchorsFromNode = function(node) {
            if (node.nodeType == /*Node.TEXT_NODE*/3) {
                addAnchorsFromTextNode(node);
            } else {
                $.each(node.childNodes, function() {
                    addAnchorsFromNode(this);
                });
            }
        };

        var range = sel.getRangeAt(0);
        if (range.startContainer != range.endContainer) {
            addAnchorsFromTextNode(range.startContainer, range.startOffset);
            var elements = getElementsBetweenTree(range.startContainer, range.endContainer);
            $(elements).each(function() {
                addAnchorsFromNode(this);
            });
            addAnchorsFromTextNode(range.endContainer, undefined, range.endOffset);
        } else {
            addAnchorsFromTextNode(range.startContainer, range.startOffset, range.endOffset);
        }

        var insertCopy = function(target, offset, copy) {
            if (target.nodeType != /*Node.TEXT_NODE*/3) {
                return;
            }
            var text = target.nodeValue;
            var text1 = text.slice(0, offset);
            var text2 = text.slice(offset);
            var node1 = document.createTextNode(text1);
            var node2 = document.createTextNode(text2);
            $(target).before(node1);
            $(target).before(copy);
            $(target).before(node2);
            if (target == range.startContainer) {
                range.setStart(node1, range.startOffset);
            }
            if (target == range.endContainer) {
                range.setEnd(node2, range.endOffset-text1.length);
            }
            $(target).remove();
        };

        if (anchors.length > 0) {
            var perfectOffset = selectionLength / 2;
            var bestIndex = 0;
            $.each(anchors, function(idx, anchor) {
                var offset = anchor[2];
                var bestOffset = anchors[bestIndex][2];
                if (Math.abs(perfectOffset - offset) <
                    Math.abs(perfectOffset - bestOffset)) {
                    bestIndex = idx;
                }
            });

            /* MIDDLE */
            var bestAnchor = anchors[bestIndex];
            insertCopy(bestAnchor[0], bestAnchor[1], createMiddle());
        }

        /* FOOTER */
        if (options.footer) {
            //insertCopy(range.endContainer, range.endOffset, createFooter());
            var endPos = range.cloneRange();
            endPos.collapse(/* to start = */false);
            var footer = createFooter();
            endPos.insertNode(footer);
            range.setEndAfter(footer);
        }

        sel.removeAllRanges();
        sel.addRange(range);
    };

    return this.mousedown(function() {
        $('.addcopy-mid').remove();
        $('.addcopy-foot').remove();

    }).mouseup(function() {
        if ($.browser.opera) {
            setTimeout(onMouseUp, 20);
        } else {
            onMouseUp();
        }
    });
};
