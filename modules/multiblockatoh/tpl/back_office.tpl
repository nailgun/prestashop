
{*
Copyright (C) 2011 by phrasespot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*}
<!-- multiblockatoh -->
{literal}
    <link type="text/css" rel="stylesheet" href="{/literal}{$module_dir}{literal}css/mbatoh.css" />
    <!--[if lte IE 7]>
    <style type="text/css">
        #multiblockatoh h2 a {position:relative; height:1%}
    </style>
    <![endif]-->
    <script type="text/javascript" src="{/literal}{$module_dir}{literal}js/expand.js"></script>
    <!--[if lte IE 6]>
    <script type="text/javascript">//<![CDATA[
        try {document.execCommand( "BackgroundImageCache", false, true);} catch(e) {/*ignore*/};
    //]]>
    </script>
    <![endif]-->
    <script type="text/javascript">//<![CDATA[
    $(function(){$("#multiblockatoh h2.expand").toggler();});
    $(function(){$("#multiblockatoh #block_hook").change(function(){
            var str = "Insert content in ";
            $("#multiblockatoh #block_hook option:selected").each(function(){
                str += $(this).text().toLowerCase();});
            $("#multiblockatoh #block_hook_help").text(str);}).trigger("change");});
    //]]>
    </script>
{/literal}
<div id="multiblockatoh">
    {if isset($submitResult)}
        {$submitResult}
    {/if}
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.module}" />{l s='Multi Block Arbitrary Text Or HTML' mod='multiblockatoh'}</h2>
    <div class="collapse shown">
        <p>{l s='This module allows you to insert arbitrary text or HTML content into almost 30 places at the front and back office.' mod='multiblockatoh'}</p>        
        <p><strong>Version</strong>: {$assignedVars.version} - <a href="{$assignedVars.links.update}">Check for update</a></p>
    </div>
    <div>
        <div id="side-includes">
            {include file="{$assignedVars.includes.donateTpl}"}
            {include file="{$assignedVars.includes.contactTpl}"}
        </div>
        <form action="{$assignedVars.links.self}" method="post">
            <fieldset>
                <legend>{l s='Add a new block' mod='multiblockatoh'}</legend>
                <div class="clear">&nbsp;</div>
                {if empty($assignedVars.hook.remaining)}
                    <p>{l s='All available hooks are assigned a block. ' mod='multiblockatoh'}</p>
                    <p>You can use <a href="{$assignedVars.links.positionsTab}">Positions tab</a> to delete or unhook some and then try again.</p>
                {else}
                    <div>
                        <label for="block_hook">{l s='Block position' mod='multiblockatoh'}</label>
                        <select id="block_hook" name="block_hook">
                            {foreach $assignedVars.hook.remaining as $hookName=>$niceName}
                                <option value="{$hookName}">{$niceName}</option>
                            {/foreach}
                        </select>
                        <p class="small field-help" id="block_hook_help">&nbsp;</p>
                    </div>
                    <div class="clear">&nbsp;</div>
                    <div>
                        <label>{l s='Block body' mod='multiblockatoh'}</label>
                        {foreach $assignedVars.lang.all as $lang}
                            <div id="block_body_wrapper_{$lang.id_lang}" name="block_body_wrapper_{$lang.id_lang}" {if $lang.id_lang == $assignedVars.lang.default}class="defaultlanguage"{else}class="otherlanguage"{/if}>
                                <textarea cols="75" rows="13" id="block_body_{$lang.id_lang}" name="block_body_{$lang.id_lang}"></textarea>
                            </div>
                        {/foreach}
                        {$assignedVars.lang.flags}
                        <p class="small field-help">{l s='Can be text or HTML, required field. No structure or styling is added.' mod='multiblockatoh'}</p>
                        <div class="clear">&nbsp;</div>
                    </div>
                    <input class="button" type="submit" id="save-block" name="save-block" value="Save"></input>
                {/if}
            </fieldset>
        </form>
    </div>
    <div class="clear">&nbsp;</div>
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.usage}" />{l s='Usage' mod='multiblockatoh'}</h2>
    <div class="collapse">
        <h3>Adding a block</h3>
        <p>To insert a block, select the position into which you want to insert the block from the <strong>Block position</strong> drop-down field. Enter the content you want to appear in the selected position into the <strong>Block body</strong> field. If your shop is in more than one language and you want the displayed block to change with changing language, click on the flag, select the language from the expanding flag box and re-enter the content in that language (if you leave any language blank, the default language content will be displayed when blocks are viewed in the language that was left empty). Once you finish entering the content press the <strong>Save</strong> button. The block is now saved and should appear at its position.</p>
        <p>You can download a <a href="http://goo.gl/yni77">.zip file (2.5 MB)</a>, or a <a href="http://goo.gl/asm6Z">.rar file (2.5 MB)</a>, or a <a href="http://goo.gl/oxctj">.7z file (2.4 MB)</a> if you prefer, containing screen captures showing every position where a block can be added. This file is too large to be a part of the module, therefore it is provided as a separate download.</p>
        <h3>Removing/editing a block</h3>
        <p>You can unhook/delete (the same thing) any block you created using <span class="underlined"><strong>Manage hooks</strong></span> link at the top of this page, or by visiting <a href="{$assignedVars.links.positionsTab}">Back Office > Modules > Positions</a>. On the same page you can also change the block's position with reference to other blocks (first show all modules and then use up/down arrows drag-and-drop), or add location exceptions (use edit icon) for the locations in which you do not want the block to be displayed, just like any other module.</p>
        <p><em>One word of caution</em>, do not try to modify the position of the blocks you created with <strong>LiveEdit</strong>, or using <strong>Transplant a module</strong> features. Prestashop assumes that each module has a single presence. If you use LiveEdit or Transplant, the behaviour of this module and created blocks is undefined.</p>
        <p>If you want to modify the position or content of a block you created, first delete it using <a href="{$assignedVars.links.positionsTab}">Back Office > Modules > Positions</a> and then recreate it with different content/at different position.</p>
        <p>There can be only one block for each position.</p>
        <h3>Troubleshooting</h3>
        <p>If your block does not appear, or appears wrong, there are few things you can do/check.</p>
        <ul>
            <li>Did you select the position you thought you did from the drop-down field? Occupied positions do not show in the drop-down.</li>
            <li>Does the block you created show in <a href="{$assignedVars.links.positionsTab}">Positions tab</a>?</li>
            <li>Does your CSS styling clash with Prestashop's native CSS?</li>
            <li>If you entered HTML as content is your HTML free of errros?</li>
            <li>Did you try deleting and recreating the block?</li>
            <li>Did you try reseting the module?</li>
            <li>Did you try uninstalling and reinstalling the module?</li>
        </ul>
        <p>If are having a problem you cannot solve, you can contact me for help and I will try to help as the time permits.</p>
    </div>
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.examples}" />{l s='Examples' mod='multiblockatoh'}</h2>
    <div class="collapse">
        <p>You are only limited by your imagination and creativity. Below are some examples to get you started.</p>
        <hr />
        <div>
            <p>This example makes a standard prestashop block using some built-in styles as well as adding its own styles. The block is then moved up above the other right column blocks using <a href="{$assignedVars.links.positionsTab}">Back Office > Modules > Positions</a>.</p>
            <p><strong>Block position:</strong> Right column blocks</p>
            <pre class="left"><strong>Block body:</strong>
&lt;div class="block"&gt;
  &lt;h4&gt;&lt;img src="star.gif" /&gt;&nbsp;It just works!&lt;/h4&gt;
  &lt;div class="block_content"&gt;
    &lt;p style="padding:0.6em 0 0.5em 0;"&gt;Lorem ipsum dolor sit amet...&lt;p&gt;
      &lt;ul class="bullet"&gt;
        &lt;li&gt;Moe&lt;/li&gt;
        &lt;li&gt;Larry&lt;/li&gt;
        &lt;li&gt;Curly&lt;/li&gt;
      &lt;/ul&gt;
  &lt;/div&gt;
&lt;/div&gt;</pre>
            <img class="example1" src="{$assignedVars.links.examples.1}" />
            <div class="clear">&nbsp;</div>
        </div>
        <hr />
        <div>
            <p>This example makes a standard prestashop block using some built-in styles as well as adding its own styles. Google's chart API is used to make a QR code (hardlink) encoding shop URL that can be captured by mobile devices. The block is then moved up above the other left column blocks using <a href="{$assignedVars.links.positionsTab}">Back Office > Modules > Positions</a>.</p>
            <p><strong>Block position:</strong> Left column blocks</p>
            <pre class="left"><strong>Block body:</strong>
&lt;div class="block"&gt;
  &lt;h4&gt;&lt;img style="padding-right:5px" src="qr.gif"&gt;Mobile snap&lt;/h4&gt;
  &lt;div class="block_content"&gt;
    &lt;center&gt;&lt;img style="padding-top:5px;" src="http://goo.gl/N9JjF" /&gt;&lt;/center&gt;
  &lt;/div&gt;
&lt;/div&gt;</pre>
            <img class="example2" src="{$assignedVars.links.examples.2}" />
            <div class="clear">&nbsp;</div>
        </div>
        <hr />
        <div>
            <p>This example displays a maintenance notice at the top of each page. It adds a style element for its own styling.</p>
            <p><strong>Block position:</strong> Header of pages</p>
            <pre class="left"><strong>Block body:</strong>
&lt;style type="text/css"&gt;
  #maintenance-notice {
    background-color: yellow;
    margin: 0.5em auto;
    width: 950px;
    text-align: center;}
  #maintenance-notice strong {
    color:red;}
&lt;/style&gt;
&lt;p id="maintenance-notice"&gt;
  &lt;strong&gt;Maintenance notice:&lt;/strong&gt; We will be carrying out essential maintenance this Friday from 12 am.
  Expected duration two hours. Apologies for any inconvenience caused.
&lt;/p&gt;</pre>
            <img class="example3" src="{$assignedVars.links.examples.3}" />
            <div class="clear">&nbsp;</div>
        </div>
    </div>
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.license}" />{l s='License' mod='multiblockatoh'}</h2>
    <div class="collapse">
        <pre>{$assignedVars.links.license}</pre>
    </div>
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.bugs}" />{l s='Bugs' mod='multiblockatoh'}</h2>
    <div class="collapse">
        <p>Please report all problems/bugs to <a href="mailto:postbox101@gmail.com?subject=mb bug">author</a>. </p>
    </div>
    <h2 class="expand"><img class="icon" src="{$assignedVars.icons.credits}" />{l s='Credits' mod='multiblockatoh'}</h2>
    <div class="collapse">
        <p>Module icons by <a href="http://www.famfamfam.com/">Mark James</a></p>
        <p>jQuery expandAll plugin by <a href="http://www.adipalaz.com/">Adriana Palazova</a>.</p>
    </div>
</div>
<!-- end multiblockatoh -->