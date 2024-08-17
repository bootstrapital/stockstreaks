import{B as p,f as y,i as g,b as C,c as I,d as x}from"./index.B1zJWTyT.js";import{a3 as w}from"./scheduler.v_cXcvRN.js";import{C as b}from"./globalContexts.1hDlTDmj.js";function h(e,...t){if(typeof e=="function")throw new Error("You must supply the data as the first argument to tidy()");let r=e;for(const n of t)n&&(r=n(r));return r}function _(e){return r=>{const n=r.map(s=>({...s}));let i=0;for(const s of n){for(const f in e){const a=e[f],o=typeof a=="function"?a(s,i,n):a;s[f]=o}++i}return n}}function l(e){if(e&&typeof e=="string"){let t=e.split(" ");e.includes(":")||(e=e+"T00:00:00"),t.length>2&&(e=t[0]+" "+t[1]);const r=/\.([^\s]+)/;e=e.replace(r,""),e=e.replace("Z",""),e=e.replace(" ","T")}return e}function U(e,t){return e=h(e,_({[t]:r=>r[t]?new Date(l(r[t])):null})),e}const O="axis",u="value",c=()=>{var e;try{return((e=w(b))==null?void 0:e.getCustomFormats())||[]}catch{return[]}},$=(e,t,r)=>{let n=N(e);if(t.evidenceType==="string")return;if(n){let s=c(),f=[...p,...s].find(a=>{var o,d;return((o=a.formatTag)==null?void 0:o.toLowerCase())===((d=n==null?void 0:n.toLowerCase)==null?void 0:d.call(n))});if(f)return f}let i=y(e,t,r);if(i)return i};function D(e,t=void 0){let r=e,n=c(),i=[...p,...n].find(f=>{var a,o;return((a=f.formatTag)==null?void 0:a.toLowerCase())===((o=r==null?void 0:r.toLowerCase)==null?void 0:o.call(r))}),s={};return i||(s={formatTag:"custom",formatCode:r},t&&(s.valueType=t),s)}const V=(e,t=void 0,r=void 0)=>{try{return T(e,t,r,u)}catch(n){return console.warn(`Unexpected error calling applyFormatting(${e}, ${t}, ${u}, ${r}). Error=${n}`),e}},M=(e,t)=>{let r=e;if(e&&(t!=null&&t.formatTag)){let n=e.toLowerCase().lastIndexOf(`_${t.formatTag.toLowerCase()}`),i="";n>0&&(typeof(t==null?void 0:t.titleTagReplacement)=="string"&&(i=t.titleTagReplacement),r=e.substring(0,n)+i)}return r},E=e=>{switch(e){case"number":return 1234;case"date":return"2022-01-03";default:return}},z=e=>{var n,i;let r=((n=e.userInput)==null?void 0:n.trim())||e.exampleInput||E(e.valueType);if(r)try{let s;if(e.valueType==="number"){let f=Number(r);s={min:f,max:f,median:f,maxDecimals:((i=f.toString().split(".")[1])==null?void 0:i.length)||0,unitType:"number"}}return T(r,e,s,u)}catch{}return""};function T(e,t=void 0,r=void 0,n=u){if(e==null)return"-";let i;if(t)try{let s=m(t,n),f;try{t.valueType==="date"&&typeof e=="string"?f=new Date(l(e)):e instanceof Date?f=new Date(e.toISOString().slice(0,-1)):t.valueType==="number"&&typeof e!="number"&&!Number.isNaN(e)?f=Number(e):f=e}catch{f=e}if(g(t,s))try{i=C(f,t,r)}catch(a){console.warn(`Unexpected error applying auto formatting. Error=${a}`)}else i=I.format(s,f)}catch(s){console.warn(`Unexpected error applying formatting ${s}`)}return i===void 0&&(i=x(e)),i}function m(e,t=u){return typeof e=="string"?e:t===O&&(e!=null&&e.axisFormatCode)?e.axisFormatCode:e==null?void 0:e.formatCode}function N(e){let t=e.toLowerCase(),r=t.lastIndexOf("_");if(r>0)return t.substr(r).replace("_","")}export{M as a,z as b,U as c,E as d,V as f,D as g,$ as l,h as t};