import{P as e}from"./VennDiagram.svelte_svelte_type_style_lang.Ho_Zb4Vt.js";const g="(if|else if|await|then|catch|each|html|debug)";e.languages.svelte=e.languages.extend("markup",{each:{pattern:new RegExp("{[#/]each(?:(?:\\{(?:(?:\\{(?:[^{}])*\\})|(?:[^{}]))*\\})|(?:[^{}]))*}"),inside:{"language-javascript":[{pattern:/(as[\s\S]*)\([\s\S]*\)(?=\s*\})/,lookbehind:!0,inside:e.languages.javascript},{pattern:/(as[\s]*)[\s\S]*(?=\s*)/,lookbehind:!0,inside:e.languages.javascript},{pattern:/(#each[\s]*)[\s\S]*(?=as)/,lookbehind:!0,inside:e.languages.javascript}],keyword:/[#/]each|as/,punctuation:/{|}/}},if:{pattern:new RegExp("{[#/]if(?:(?:\\{(?:(?:\\{(?:[^{}])*\\})|(?:[^{}]))*\\})|(?:[^{}]))*}"),inside:{"language-javascript":[{pattern:/(as[\s\S]*)\([\s\S]*\)(?=\s*\})/,lookbehind:!0,inside:e.languages.javascript},{pattern:/(as[\s]*)[\s\S]*(?=\s*)/,lookbehind:!0,inside:e.languages.javascript},{pattern:/(#if[\s]*)[\s\S]*(?=as)/,lookbehind:!0,inside:e.languages.javascript}],keyword:/[#/]if|as/,punctuation:/{|}/}},block:{pattern:new RegExp("{[#:/@]/s"+g+"(?:(?:\\{(?:(?:\\{(?:[^{}])*\\})|(?:[^{}]))*\\})|(?:[^{}]))*}"),inside:{punctuation:/^{|}$/,keyword:[new RegExp("[#:/@]"+g+"( )*"),/as/,/then/],"language-javascript":{pattern:/[\s\S]*/,inside:e.languages.javascript}}},tag:{pattern:/<\/?(?!\d)[^\s>\/=$<%]+(?:\s(?:\s*[^\s>\/=]+(?:\s*=\s*(?:(?:"[^"]*"|'[^']*'|[^\s'">=]+(?=[\s>]))|(?:"[^"]*"|'[^']*'|{[\s\S]+?}(?=[\s/>])))|(?=[\s/>])))+)?\s*\/?>/i,greedy:!0,inside:{tag:{pattern:/^<\/?[^\s>\/]+/i,inside:{punctuation:/^<\/?/,namespace:/^[^\s>\/:]+:/}},"language-javascript":{pattern:/\{(?:(?:\{(?:(?:\{(?:[^{}])*\})|(?:[^{}]))*\})|(?:[^{}]))*\}/,inside:e.languages.javascript},"attr-value":{pattern:/=\s*(?:"[^"]*"|'[^']*'|[^\s'">=]+)/i,inside:{punctuation:[/^=/,{pattern:/^(\s*)["']|["']$/,lookbehind:!0}],"language-javascript":{pattern:/{[\s\S]+}/,inside:e.languages.javascript}}},punctuation:/\/?>/,"attr-name":{pattern:/[^\s>\/]+/,inside:{namespace:/^[^\s>\/:]+:/}}}},"language-javascript":{pattern:/\{(?:(?:\{(?:(?:\{(?:[^{}])*\})|(?:[^{}]))*\})|(?:[^{}]))*\}/,lookbehind:!0,inside:e.languages.javascript}});e.languages.svelte.tag.inside["attr-value"].inside.entity=e.languages.svelte.entity;e.hooks.add("wrap",a=>{a.type==="entity"&&(a.attributes.title=a.content.replace(/&amp;/,"&"))});Object.defineProperty(e.languages.svelte.tag,"addInlined",{value:function(n,s){const t={};t["language-"+s]={pattern:/(^<!\[CDATA\[)[\s\S]+?(?=\]\]>$)/i,lookbehind:!0,inside:e.languages[s]},t.cdata=/^<!\[CDATA\[|\]\]>$/i;const i={"included-cdata":{pattern:/<!\[CDATA\[[\s\S]*?\]\]>/i,inside:t}};i["language-"+s]={pattern:/[\s\S]+/,inside:e.languages[s]};const r={};r[n]={pattern:RegExp(/(<__[\s\S]*?>)(?:<!\[CDATA\[[\s\S]*?\]\]>\s*|[\s\S])*?(?=<\/__>)/.source.replace(/__/g,n),"i"),lookbehind:!0,greedy:!0,inside:i},e.languages.insertBefore("svelte","cdata",r)}});e.languages.svelte.tag.addInlined("style","css");e.languages.svelte.tag.addInlined("script","javascript");
