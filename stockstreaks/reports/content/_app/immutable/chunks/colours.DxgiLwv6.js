const __vite__fileDeps=["./VennDiagram.svelte_svelte_type_style_lang.CjRDHdby.js","./index.R8ovVqwX.js","./entry.E1jLJAl4.js","./scheduler.Dt70P_FP.js","./index.ACu_ga9F.js","./preload-helper.D6kgxu3v.js","../assets/VennDiagram.C_JA5_WR.css","./prism-svelte.DbFOxZsF.js"],__vite__mapDeps=i=>i.map(i=>__vite__fileDeps[i]);
import{s as L,e as v,b as w,p as Z,h,i as D,z as T,q as we,g as p,r as S,al as Te,ak as Ce,c as M,u as P,m as O,n as R,d as k,w as I,a as x,x as V,f as U,j as g,y as A,R as re,U as ne,ah as le,l as ke,Y as Se,G,H as W,L as Ie,P as oe}from"./scheduler.Dt70P_FP.js";import{S as j,i as B,j as Ve,g as z,a as y,c as F,t as b,b as Q,d as H,m as K,e as J,f as se}from"./index.ACu_ga9F.js";import{f as X}from"./index.CyNif0VK.js";import{Q as te,a8 as Ae,a9 as Le,aa as Me,ab as Pe}from"./VennDiagram.svelte_svelte_type_style_lang.CjRDHdby.js";import{a as Oe,t as Re,l as je,b as Be}from"./CopyIcon.D4Z9l8TE.js";import{_ as N}from"./preload-helper.D6kgxu3v.js";function qe(l){let t,n='<span class="sr-only">Loading...</span> <div class="h-full w-full bg-gray-200 rounded-md dark:bg-gray-400"></div>',e;return{c(){t=v("div"),t.innerHTML=n,this.h()},l(r){t=w(r,"DIV",{class:!0,"data-svelte-h":!0}),Z(t)!=="svelte-7iquaz"&&(t.innerHTML=n),this.h()},h(){h(t,"class","animate-pulse h-full w-full my-2")},m(r,o){D(r,t,o)},p:T,i(r){r&&(e||we(()=>{e=Ve(t,X,{}),e.start()}))},o:T,d(r){r&&p(t)}}}class ze extends j{constructor(t){super(),B(this,t,null,qe,L,{})}}function Fe(l){return!l||!l[0]||!l.length}const Ne=l=>({loaded:l&2}),ie=l=>({loaded:l[1]}),xe=l=>({loaded:l&2}),ae=l=>({loaded:l[1]}),Ue=l=>({loaded:l&2}),ue=l=>({loaded:l[1]}),Qe=l=>({loaded:l&2}),ce=l=>({loaded:l[1]}),He=l=>({loaded:l&1}),fe=l=>({loaded:l[0]}),Ke=l=>({loaded:l&1}),de=l=>({loaded:l[0]}),Je=l=>({loaded:l&1}),_e=l=>({loaded:l[0]});function Ye(l){let t;const n=l[5].default,e=M(n,l,l[4],ie);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&18)&&P(e,n,r,r[4],t?R(n,r[4],o,Ne):O(r[4]),ie)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function Ge(l){let t;const n=l[5].empty,e=M(n,l,l[4],ae);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&18)&&P(e,n,r,r[4],t?R(n,r[4],o,xe):O(r[4]),ae)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function We(l){let t;const n=l[5].error,e=M(n,l,l[4],ue);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&18)&&P(e,n,r,r[4],t?R(n,r[4],o,Ue):O(r[4]),ue)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function Ze(l){let t;const n=l[5].skeleton,e=M(n,l,l[4],ce),r=e||et();return{c(){r&&r.c()},l(o){r&&r.l(o)},m(o,i){r&&r.m(o,i),t=!0},p(o,i){e&&e.p&&(!t||i&18)&&P(e,n,o,o[4],t?R(n,o[4],i,Qe):O(o[4]),ce)},i(o){t||(b(r,o),t=!0)},o(o){y(r,o),t=!1},d(o){r&&r.d(o)}}}function Xe(l){let t,n,e,r,o;const i=[rt,tt],a=[];function u(s,d){return d&5&&(t=null),t==null&&(t=!!((Array.isArray(s[0])||!s[0])&&Fe(s[0])&&s[2].empty)),t?0:1}return n=u(l,-1),e=a[n]=i[n](l),{c(){e.c(),r=S()},l(s){e.l(s),r=S()},m(s,d){a[n].m(s,d),D(s,r,d),o=!0},p(s,d){let c=n;n=u(s,d),n===c?a[n].p(s,d):(z(),y(a[c],1,1,()=>{a[c]=null}),F(),e=a[n],e?e.p(s,d):(e=a[n]=i[n](s),e.c()),b(e,1),e.m(r.parentNode,r))},i(s){o||(b(e),o=!0)},o(s){y(e),o=!1},d(s){s&&p(r),a[n].d(s)}}}function $e(l){let t;const n=l[5].default,e=M(n,l,l[4],_e);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&17)&&P(e,n,r,r[4],t?R(n,r[4],o,Je):O(r[4]),_e)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function et(l){let t,n,e;return n=new ze({}),{c(){t=v("div"),Q(n.$$.fragment),this.h()},l(r){t=w(r,"DIV",{class:!0});var o=k(t);H(n.$$.fragment,o),o.forEach(p),this.h()},h(){h(t,"class","w-full h-64")},m(r,o){D(r,t,o),K(n,t,null),e=!0},p:T,i(r){e||(b(n.$$.fragment,r),e=!0)},o(r){y(n.$$.fragment,r),e=!1},d(r){r&&p(t),J(n)}}}function tt(l){let t;const n=l[5].default,e=M(n,l,l[4],fe);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&17)&&P(e,n,r,r[4],t?R(n,r[4],o,He):O(r[4]),fe)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function rt(l){let t;const n=l[5].empty,e=M(n,l,l[4],de);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&17)&&P(e,n,r,r[4],t?R(n,r[4],o,Ke):O(r[4]),de)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function nt(l){let t,n,e,r,o;const i=[$e,Xe,Ze,We,Ge,Ye],a=[];function u(s,d){return d&1&&(t=null),s[0]?(t==null&&(t=!te.isQuery(s[0])),t?1:!s[1]||!s[1].dataLoaded&&!s[1].error?2:s[1].error&&s[2].error?3:!s[1].length&&!s[1].error&&s[2].empty?4:5):0}return n=u(l,-1),e=a[n]=i[n](l),{c(){e.c(),r=S()},l(s){e.l(s),r=S()},m(s,d){a[n].m(s,d),D(s,r,d),o=!0},p(s,[d]){let c=n;n=u(s,d),n===c?a[n].p(s,d):(z(),y(a[c],1,1,()=>{a[c]=null}),F(),e=a[n],e?e.p(s,d):(e=a[n]=i[n](s),e.c()),b(e,1),e.m(r.parentNode,r))},i(s){o||(b(e),o=!0)},o(s){y(e),o=!1},d(s){s&&p(r),a[n].d(s)}}}function lt(l,t,n){let{$$slots:e={},$$scope:r}=t;const o=Te(e);let{data:i}=t,a=()=>{},u;return Ce(a),l.$$set=s=>{"data"in s&&n(0,i=s.data),"$$scope"in s&&n(4,r=s.$$scope)},l.$$.update=()=>{l.$$.dirty&9&&te.isQuery(i)&&(i.fetch(),a(),n(3,a=i.subscribe(s=>{n(1,u=s)})))},[i,u,o,a,r,e]}class lr extends j{constructor(t){super(),B(this,t,lt,nt,L,{data:0})}}function ot(l,t){return l<t?-1:l>t?1:l>=t?0:NaN}function*st(l,t){if(t===void 0)for(let n of l)n!=null&&(n=+n)>=n&&(yield n);else{let n=-1;for(let e of l)(e=t(e,++n,l))!=null&&(e=+e)>=e&&(yield e)}}class it{constructor(){this._partials=new Float64Array(32),this._n=0}add(t){const n=this._partials;let e=0;for(let r=0;r<this._n&&r<32;r++){const o=n[r],i=t+o,a=Math.abs(t)<Math.abs(o)?t-(i-o):o-(i-t);a&&(n[e++]=a),t=i}return n[e]=t,this._n=e+1,this}valueOf(){const t=this._partials;let n=this._n,e,r,o,i=0;if(n>0){for(i=t[--n];n>0&&(e=i,r=t[--n],i=e+r,o=r-(i-e),!o););n>0&&(o<0&&t[n-1]<0||o>0&&t[n-1]>0)&&(r=o*2,e=i+r,r==e-i&&(i=e))}return i}}function Ee(l,t){const n=new it;if(t===void 0)for(let e of l)(e=+e)&&n.add(e);else{let e=-1;for(let r of l)(r=+t(r,++e,l))&&n.add(r)}return+n}function $(l,t){let n;if(t===void 0)for(const e of l)e!=null&&(n<e||n===void 0&&e>=e)&&(n=e);else{let e=-1;for(let r of l)(r=t(r,++e,l))!=null&&(n<r||n===void 0&&r>=r)&&(n=r)}return n}function ee(l,t){let n;if(t===void 0)for(const e of l)e!=null&&(n>e||n===void 0&&e>=e)&&(n=e);else{let e=-1;for(let r of l)(r=t(r,++e,l))!=null&&(n>r||n===void 0&&r>=r)&&(n=r)}return n}function De(l,t,n=0,e=l.length-1,r=ot){for(;e>n;){if(e-n>600){const u=e-n+1,s=t-n+1,d=Math.log(u),c=.5*Math.exp(2*d/3),f=.5*Math.sqrt(d*c*(u-c)/u)*(s-u/2<0?-1:1),_=Math.max(n,Math.floor(t-s*c/u+f)),m=Math.min(e,Math.floor(t+(u-s)*c/u+f));De(l,t,_,m,r)}const o=l[t];let i=n,a=e;for(Y(l,n,t),r(l[e],o)>0&&Y(l,n,e);i<a;){for(Y(l,i,a),++i,--a;r(l[i],o)<0;)++i;for(;r(l[a],o)>0;)--a}r(l[n],o)===0?Y(l,n,a):(++a,Y(l,a,e)),a<=t&&(n=a+1),t<=a&&(e=a-1)}return l}function Y(l,t,n){const e=l[t];l[t]=l[n],l[n]=e}function at(l,t,n){if(l=Float64Array.from(st(l,n)),!!(e=l.length)){if((t=+t)<=0||e<2)return ee(l);if(t>=1)return $(l);var e,r=(e-1)*t,o=Math.floor(r),i=$(De(l,o).subarray(0,o+1)),a=ee(l.subarray(o+1));return i+(a-i)*(r-o)}}function ut(l,t){return at(l,.5,t)}function me(l,t){return e=>{t=t??{};const r={},o=Object.keys(l);for(const i of o)r[i]=l[i](e);if(t.rest&&e.length){const i=Object.keys(e[0]);for(const a of i)o.includes(a)||(r[a]=t.rest(a)(e))}return[r]}}function he(l){if(l!=null&&l.predicate){const t=l.predicate;return n=>n.reduce((e,r,o)=>t(r,o,n)?e+1:e,0)}return t=>t.length}function ct(l,t){let n=typeof l=="function"?l:e=>e[l];return e=>Ee(e,n)}function ft(l,t){let n=0;for(let e=0;e<l.length;++e){const r=t(l[e],e,l);+r===r&&(n+=1)}return n?Ee(l,t)/n:void 0}function dt(l){const t=typeof l=="function"?l:n=>n[l];return n=>ee(n,t)}function _t(l){const t=typeof l=="function"?l:n=>n[l];return n=>$(n,t)}function mt(l){const t=typeof l=="function"?l:n=>n[l];return n=>ft(n,t)}function ht(l){const t=typeof l=="function"?l:n=>n[l];return n=>ut(n,t)}function pe(l,t={}){const n=typeof l=="function"?l:e=>e[l];return e=>{const r=new Map;let o=0,i=0;for(const a of e){const u=n(a,i++,e);if(!r.has(u)){if(!t.includeUndefined&&u===void 0||t.includeNull===!1&&u===null)continue;o+=1,r.set(u,!0)}}return o}}function pt(l,t){let n=Oe(l,t),e=["id","gdp"],r=["of","the","and","in","on"];function o(i){return i.replace(/\S*/g,function(a){return!e.includes(a)&&!r.includes(a)?a.charAt(0).toUpperCase()+a.substr(1).toLowerCase():e.includes(a)?a.toUpperCase():a.toLowerCase()})}return n=o(l.replace(/"/g,"").replace(/_/g," ")),n}function be(l,t,n=!0){const e=Re(l,me(n?{count:he(t),countDistinct:pe(t),min:dt(t),max:_t(t),median:ht(t),mean:mt(t),sum:ct(t)}:{count:he(t),countDistinct:pe(t)}))[0],{maxDecimals:r,unitType:o}=bt(l.map(i=>i[t]));return{min:e.min,max:e.max,median:e.median,mean:e.mean,count:e.count,countDistinct:e.countDistinct,sum:e.sum,maxDecimals:r,unitType:o}}function bt(l){var t;if(l==null||l.length===0)return{maxDecimals:0,unitType:"unknown"};{let n=0;for(const e of l){const r=(t=e==null?void 0:e.toString().split(".")[1])==null?void 0:t.length;r>n&&(n=r)}return{maxDecimals:n,unitType:"number"}}}function or(l,t="object"){const n={},e=Ae(l);for(const r of Object.keys(l[0])){const o=e.find(s=>{var d;return((d=s.name)==null?void 0:d.toLowerCase())===(r==null?void 0:r.toLowerCase())})??{name:r,evidenceType:Le.NUMBER,typeFidelity:Me.INFERRED},i=o.evidenceType;let a=o.evidenceType==="number"?be(l,r,!0):be(l,r,!1);o.evidenceType!=="number"&&(a.maxDecimals=0,a.unitType=o.evidenceType);const u=je(r,o,a);n[r]={title:pt(r,u),type:i,evidenceColumnType:o,format:u,columnUnitSummary:a}}return t!=="object"?Object.entries(n).map(([r,o])=>({id:r,...o})):n}var gt={BASE_URL:"./",MODE:"production",DEV:!1,PROD:!0,SSR:!1};const sr=Symbol(),yt=gt.VITE_BUILD_STRICT==="true";function vt(l){let t,n,e="View environment variables →";return{c(){t=v("br"),n=v("a"),n.textContent=e,this.h()},l(r){t=w(r,"BR",{}),n=w(r,"A",{class:!0,href:!0,"data-svelte-h":!0}),Z(n)!=="svelte-16l7o12"&&(n.textContent=e),this.h()},h(){h(n,"class","credentials-link svelte-1no0yro"),h(n,"href","https://docs.evidence.dev/cli/#environment-variables")},m(r,o){D(r,t,o),D(r,n,o)},d(r){r&&(p(t),p(n))}}}function wt(l){let t,n,e,r,o,i,a,u,s;function d(_,m){if(_[0]===kt)return vt}let c=d(l),f=c&&c(l);return{c(){t=v("div"),n=v("div"),e=v("div"),r=I(l[1]),o=x(),i=v("div"),a=I(l[0]),u=x(),f&&f.c(),this.h()},l(_){t=w(_,"DIV",{width:!0,class:!0});var m=k(t);n=w(m,"DIV",{class:!0});var E=k(n);e=w(E,"DIV",{class:!0});var C=k(e);r=V(C,l[1]),C.forEach(p),o=U(E),i=w(E,"DIV",{class:!0});var q=k(i);a=V(q,l[0]),u=U(q),f&&f.l(q),q.forEach(p),E.forEach(p),m.forEach(p),this.h()},h(){h(e,"class","font-bold text-center text-lg"),h(i,"class","text-center [word-wrap:break-work] text-xs"),h(n,"class","m-auto w-full"),h(t,"width","100%"),h(t,"class",s="grid grid-rows-auto box-content grid-cols-1 justify-center bg-red-50 text-grey-700 font-ui font-normal rounded border border-red-200 min-h-["+l[2]+"px] py-5 px-8 my-5 print:break-inside-avoid svelte-1no0yro")},m(_,m){D(_,t,m),g(t,n),g(n,e),g(e,r),g(n,o),g(n,i),g(i,a),g(i,u),f&&f.m(i,null)},p(_,[m]){m&2&&A(r,_[1]),m&1&&A(a,_[0]),c!==(c=d(_))&&(f&&f.d(1),f=c&&c(_),f&&(f.c(),f.m(i,null))),m&4&&s!==(s="grid grid-rows-auto box-content grid-cols-1 justify-center bg-red-50 text-grey-700 font-ui font-normal rounded border border-red-200 min-h-["+_[2]+"px] py-5 px-8 my-5 print:break-inside-avoid svelte-1no0yro")&&h(t,"class",s)},i:T,o:T,d(_){_&&p(t),f&&f.d()}}}const kt="SQL Error: Missing database connection; set the EVIDENCE_DATABASE environment variable.";function Et(l,t,n){let{error:e}=t,{chartType:r}=t,{minHeight:o="150"}=t;return l.$$set=i=>{"error"in i&&n(0,e=i.error),"chartType"in i&&n(1,r=i.chartType),"minHeight"in i&&n(2,o=i.minHeight)},[e,r,o]}class Dt extends j{constructor(t){super(),B(this,t,Et,wt,L,{error:0,chartType:1,minHeight:2})}}function ir(l,t,n){var o,i,a,u,s;let e=[];if(l===void 0)throw Error("No data provided");if(typeof l!="object")throw Error("'"+l+"' is not a recognized query result. Data should be provided in the format: data = {"+l.replace("data.","")+"}");if(l[0]===void 0||l.length===0)throw Error("Dataset is empty: query ran successfully, but no data was returned from the database");if(((i=(o=l[0])==null?void 0:o.error_object)==null?void 0:i.error)!=null)throw Error("SQL Error: "+((s=(u=(a=l[0])==null?void 0:a.error_object)==null?void 0:u.error)==null?void 0:s.message));if(t!=null){if(!(t instanceof Array))throw Error("reqCols must be passed in as an array");for(var r=0;r<t.length;r++)if(t[r]==null)throw Error("Missing required columns");if(te.isQuery(l))if(!l.columnsLoaded&&l.dataLoaded){const c=Object.keys(l[0]);for(const f of c)e.push(f)}else for(const c of l.columns)e.push(c.column_name);else for(const c of Object.keys(l[0]))e.push(c);let d;for(r=0;r<t.length;r++)if(d=t[r],!e.includes(d))throw Error("'"+d+"' is not a column in the dataset")}}function ge(l){let t,n,e,r,o,i,a,u,s,d;const c=l[7].default,f=M(c,l,l[6],null),_=f||Tt();return{c(){t=v("div"),n=v("button"),e=v("span"),r=I(l[2]),o=x(),_&&_.c(),this.h()},l(m){t=w(m,"DIV",{});var E=k(t);n=w(E,"BUTTON",{type:!0,"aria-label":!0,class:!0});var C=k(n);e=w(C,"SPAN",{});var q=k(e);r=V(q,l[2]),q.forEach(p),o=U(C),_&&_.l(C),C.forEach(p),E.forEach(p),this.h()},h(){h(n,"type","button"),h(n,"aria-label",l[2]),h(n,"class",i=le(l[4].class)+" svelte-p80uux")},m(m,E){D(m,t,E),g(t,n),g(n,e),g(e,r),g(n,o),_&&_.m(n,null),u=!0,s||(d=ke(n,"click",function(){Se(l[3](l[1]))&&l[3](l[1]).apply(this,arguments)}),s=!0)},p(m,E){l=m,(!u||E&4)&&A(r,l[2]),f&&f.p&&(!u||E&64)&&P(f,c,l,l[6],u?R(c,l[6],E,null):O(l[6]),null),(!u||E&4)&&h(n,"aria-label",l[2]),(!u||E&16&&i!==(i=le(l[4].class)+" svelte-p80uux"))&&h(n,"class",i)},i(m){u||(b(_,m),m&&we(()=>{u&&(a||(a=se(t,X,{duration:200},!0)),a.run(1))}),u=!0)},o(m){y(_,m),m&&(a||(a=se(t,X,{duration:200},!1)),a.run(0)),u=!1},d(m){m&&p(t),_&&_.d(m),m&&a&&a.end(),s=!1,d()}}}function Tt(l){let t,n;return{c(){t=G("svg"),n=G("path"),this.h()},l(e){t=W(e,"svg",{width:!0,height:!0,viewBox:!0,fill:!0,"stroke-width":!0,"stroke-linecap":!0,"stroke-linejoin":!0});var r=k(t);n=W(r,"path",{d:!0}),k(n).forEach(p),r.forEach(p),this.h()},h(){h(n,"d","M3 15v4c0 1.1.9 2 2 2h14a2 2 0 0 0 2-2v-4M17 9l-5 5-5-5M12 12.8V2.5"),h(t,"width","12"),h(t,"height","12"),h(t,"viewBox","0 0 24 24"),h(t,"fill","none"),h(t,"stroke-width","2"),h(t,"stroke-linecap","round"),h(t,"stroke-linejoin","round")},m(e,r){D(e,t,r),g(t,n)},p:T,d(e){e&&p(t)}}}function Ct(l){let t,n,e=l[0]&&ge(l);return{c(){e&&e.c(),t=S()},l(r){e&&e.l(r),t=S()},m(r,o){e&&e.m(r,o),D(r,t,o),n=!0},p(r,[o]){r[0]?e?(e.p(r,o),o&1&&b(e,1)):(e=ge(r),e.c(),b(e,1),e.m(t.parentNode,t)):e&&(z(),y(e,1,1,()=>{e=null}),F())},i(r){n||(b(e),n=!0)},o(r){y(e),n=!1},d(r){r&&p(t),e&&e.d(r)}}}function St(l,t,n){let{$$slots:e={},$$scope:r}=t,{data:o=void 0}=t,{queryID:i=void 0}=t,{text:a="Download"}=t,{display:u=!0}=t;const s=new Date,d=new Date(s.getTime()-s.getTimezoneOffset()*6e4).toISOString().slice(0,19).replaceAll(":","-");let{downloadData:c=f=>{const _={fieldSeparator:",",quoteStrings:'"',decimalSeparator:".",showLabels:!0,showTitle:!1,filename:(i??"evidence_download")+` ${d}`,useTextFile:!1,useBom:!0,useKeysAsHeaders:!0},m=JSON.parse(JSON.stringify(Array.from(f)));new Pe.ExportToCsv(_).generateCsv(m)}}=t;return l.$$set=f=>{n(4,t=re(re({},t),ne(f))),"data"in f&&n(1,o=f.data),"queryID"in f&&n(5,i=f.queryID),"text"in f&&n(2,a=f.text),"display"in f&&n(0,u=f.display),"downloadData"in f&&n(3,c=f.downloadData),"$$scope"in f&&n(6,r=f.$$scope)},l.$$.update=()=>{l.$$.dirty&1&&n(0,u=u==="true"||u===!0)},t=ne(t),[u,o,a,c,t,i,r,e]}class ar extends j{constructor(t){super(),B(this,t,St,Ct,L,{data:1,queryID:5,text:2,display:0,downloadData:3})}}const ye=async()=>{const l=(await N(()=>import("./VennDiagram.svelte_svelte_type_style_lang.CjRDHdby.js").then(t=>t.p),__vite__mapDeps([0,1,2,3,4,5,6]),import.meta.url)).default;return await N(()=>import("./prism-bash.DTkDXsAh.js"),[],import.meta.url),await N(()=>import("./prism-sql.AgAyy5H_.js"),[],import.meta.url),await N(()=>import("./prism-python.DhmbaUsA.js"),[],import.meta.url),await N(()=>import("./prism-markdown.4MKFcK2x.js"),[],import.meta.url),await N(()=>import("./prism-svelte.DbFOxZsF.js"),__vite__mapDeps([7,0,1,2,3,4,5,6]),import.meta.url),l};function It(l){let t,n;return{c(){t=G("svg"),n=G("path"),this.h()},l(e){t=W(e,"svg",{class:!0,viewBox:!0,fill:!0,width:!0,height:!0,preserveAspectRatio:!0});var r=k(t);n=W(r,"path",{d:!0}),k(n).forEach(p),r.forEach(p),this.h()},h(){h(n,"d","M21,7L9,19L3.5,13.5L4.91,12.09L9,16.17L19.59,5.59L21,7Z"),h(t,"class","copyButtonSuccessIcon"),h(t,"viewBox","0 0 24 24"),h(t,"fill",l[0]),h(t,"width","100%"),h(t,"height","100%"),h(t,"preserveAspectRatio","xMidYMid meet")},m(e,r){D(e,t,r),g(t,n)},p(e,[r]){r&1&&h(t,"fill",e[0])},i:T,o:T,d(e){e&&p(t)}}}function Vt(l,t,n){let{color:e="green"}=t;return l.$$set=r=>{"color"in r&&n(0,e=r.color)},[e]}class At extends j{constructor(t){super(),B(this,t,Vt,It,L,{color:0})}}function ve(l){let t,n,e,r,o,i,a;const u=[Mt,Lt],s=[];function d(c,f){return c[3]?0:1}return n=d(l),e=s[n]=u[n](l),{c(){t=v("button"),e.c(),this.h()},l(c){t=w(c,"BUTTON",{class:!0});var f=k(t);e.l(f),f.forEach(p),this.h()},h(){h(t,"class",r="absolute opacity-0 bg-gray-50 rounded-sm p-1 group-hover:opacity-100 top-4 right-6 h-6 w-6 z-10 transition-all duration-200 ease-in-out"+(l[3],""))},m(c,f){D(c,t,f),s[n].m(t,null),o=!0,i||(a=ke(t,"click",l[7]),i=!0)},p(c,f){let _=n;n=d(c),n!==_&&(z(),y(s[_],1,1,()=>{s[_]=null}),F(),e=s[n],e||(e=s[n]=u[n](c),e.c()),b(e,1),e.m(t,null)),(!o||f&8&&r!==(r="absolute opacity-0 bg-gray-50 rounded-sm p-1 group-hover:opacity-100 top-4 right-6 h-6 w-6 z-10 transition-all duration-200 ease-in-out"+(c[3],"")))&&h(t,"class",r)},i(c){o||(b(e),o=!0)},o(c){y(e),o=!1},d(c){c&&p(t),s[n].d(),i=!1,a()}}}function Lt(l){let t,n;return t=new Be({}),{c(){Q(t.$$.fragment)},l(e){H(t.$$.fragment,e)},m(e,r){K(t,e,r),n=!0},i(e){n||(b(t.$$.fragment,e),n=!0)},o(e){y(t.$$.fragment,e),n=!1},d(e){J(t,e)}}}function Mt(l){let t,n;return t=new At({props:{color:"var(--green-500)"}}),{c(){Q(t.$$.fragment)},l(e){H(t.$$.fragment,e)},m(e,r){K(t,e,r),n=!0},i(e){n||(b(t.$$.fragment,e),n=!0)},o(e){y(t.$$.fragment,e),n=!1},d(e){J(t,e)}}}function Pt(l){let t;const n=l[6].default,e=M(n,l,l[5],null);return{c(){e&&e.c()},l(r){e&&e.l(r)},m(r,o){e&&e.m(r,o),t=!0},p(r,o){e&&e.p&&(!t||o&32)&&P(e,n,r,r[5],t?R(n,r[5],o,null):O(r[5]),null)},i(r){t||(b(e,r),t=!0)},o(r){y(e,r),t=!1},d(r){e&&e.d(r)}}}function Ot(l){let t;return{c(){t=I(l[0])},l(n){t=V(n,l[0])},m(n,e){D(n,t,e)},p(n,e){e&1&&A(t,n[0])},i:T,o:T,d(n){n&&p(t)}}}function Rt(l){let t,n,e,r,o,i,a,u,s=l[1]&&ve(l);const d=[Ot,Pt],c=[];function f(_,m){return _[0]?0:1}return o=f(l),i=c[o]=d[o](l),{c(){t=v("div"),s&&s.c(),n=x(),e=v("pre"),r=v("code"),i.c(),this.h()},l(_){t=w(_,"DIV",{class:!0});var m=k(t);s&&s.l(m),n=U(m),e=w(m,"PRE",{class:!0});var E=k(e);r=w(E,"CODE",{class:!0});var C=k(r);i.l(C),C.forEach(p),E.forEach(p),m.forEach(p),this.h()},h(){h(r,"class",a="language-"+l[2]+" text-sm"),h(e,"class","overflow-auto max-h-64 pretty-scrollbar"),h(t,"class","my-5 bg-gray-50 border border-gray-200 rounded px-3 py-1 relative group")},m(_,m){D(_,t,m),s&&s.m(t,null),g(t,n),g(t,e),g(e,r),c[o].m(r,null),u=!0},p(_,[m]){_[1]?s?(s.p(_,m),m&2&&b(s,1)):(s=ve(_),s.c(),b(s,1),s.m(t,n)):s&&(z(),y(s,1,1,()=>{s=null}),F());let E=o;o=f(_),o===E?c[o].p(_,m):(z(),y(c[E],1,1,()=>{c[E]=null}),F(),i=c[o],i?i.p(_,m):(i=c[o]=d[o](_),i.c()),b(i,1),i.m(r,null)),(!u||m&4&&a!==(a="language-"+_[2]+" text-sm"))&&h(r,"class",a)},i(_){u||(b(s),b(i),u=!0)},o(_){y(s),y(i),u=!1},d(_){_&&p(t),s&&s.d(),c[o].d()}}}function jt(l,t,n){let{$$slots:e={},$$scope:r}=t,{source:o}=t,{copyToClipboard:i=!1}=t,{language:a=void 0}=t,u=!1;const s=function(){n(3,u=!1)};async function d(){try{await navigator.clipboard.writeText(o),n(3,u=!0),setTimeout(s,1500)}catch{}}Ie(async()=>{const f=await ye();typeof f<"u"?(await oe(),document.querySelectorAll(`pre code${a?`.language-${a}`:""}`).forEach(m=>{f.highlightElement(m,!1)})):console.error("Prism is not defined on mount")});const c=()=>{o!==void 0&&d()};return l.$$set=f=>{"source"in f&&n(0,o=f.source),"copyToClipboard"in f&&n(1,i=f.copyToClipboard),"language"in f&&n(2,a=f.language),"$$scope"in f&&n(5,r=f.$$scope)},l.$$.update=()=>{l.$$.dirty&4&&oe().then(async()=>{const f=await ye();typeof f<"u"?document.querySelectorAll(`pre code${a?`.language-${a}`:""}`).forEach(m=>{f.highlightElement(m,!1)}):console.error("Prism is not defined in reactive statement")})},[o,i,a,u,d,r,e,c]}class ur extends j{constructor(t){super(),B(this,t,jt,Rt,L,{source:0,copyToClipboard:1,language:2})}}function Bt(l){let t,n,e="error",r,o,i;return{c(){t=v("span"),n=v("span"),n.textContent=e,r=x(),o=v("span"),i=I(l[0]),this.h()},l(a){t=w(a,"SPAN",{class:!0});var u=k(t);n=w(u,"SPAN",{class:!0,"data-svelte-h":!0}),Z(n)!=="svelte-1927df"&&(n.textContent=e),r=U(u),o=w(u,"SPAN",{class:!0});var s=k(o);i=V(s,l[0]),s.forEach(p),u.forEach(p),this.h()},h(){h(n,"class","inline font-sans font-medium text-xs text-red-600"),h(o,"class","hidden text-white font-sans group-hover:inline absolute -top-1 left-[105%] text-sm z-10 px-2 py-1 bg-gray-800/80 leading-relaxed min-w-[150px] max-w-[400px] rounded-md"),h(t,"class","group inline-flex items-center relative cursor-help cursor-helpfont-sans px-1 border border-red-200 py-[1px] bg-red-50 rounded")},m(a,u){D(a,t,u),g(t,n),g(t,r),g(t,o),g(o,i)},p(a,[u]){u&1&&A(i,a[0])},i:T,o:T,d(a){a&&p(t)}}}function qt(l,t,n){let{error:e=void 0}=t;return l.$$set=r=>{"error"in r&&n(0,e=r.error)},[e]}class zt extends j{constructor(t){super(),B(this,t,qt,Bt,L,{error:0})}}function Ft(l){let t,n,e="Big Value",r,o,i,a,u,s;return{c(){t=v("div"),n=v("div"),n.textContent=e,r=x(),o=v("div"),i=v("div"),a=I(`error
			`),u=v("span"),s=I(l[0]),this.h()},l(d){t=w(d,"DIV",{width:!0,class:!0});var c=k(t);n=w(c,"DIV",{class:!0,"data-svelte-h":!0}),Z(n)!=="svelte-f1i116"&&(n.textContent=e),r=U(c),o=w(c,"DIV",{class:!0});var f=k(o);i=w(f,"DIV",{class:!0});var _=k(i);a=V(_,`error
			`),u=w(_,"SPAN",{class:!0});var m=k(u);s=V(m,l[0]),m.forEach(p),_.forEach(p),f.forEach(p),c.forEach(p),this.h()},h(){h(n,"class","font-bold text-center text-sm"),h(u,"class","hidden text-white font-sans group-hover:inline-block absolute top-[50%] left-[50%] text-sm z-10 px-2 py-1 bg-gray-800/80 leading-relaxed min-w-[150px] max-w-[400px] rounded-md z-50 overflow-visible"),h(i,"class","text-center [word-wrap:break-work] w-full font-medium text-xs text-red-600"),h(o,"class","m-auto w-[100px]"),h(t,"width","100%"),h(t,"class","inline-block group w-[100px] relative cursor-help cursor-helpfont-sans box-content grid-cols-1 justify-center bg-red-50 text-grey-700 font-ui font-normal rounded border border-red-200 h-[38px] mt-0.5 py-3 px-3 print:break-inside-avoid")},m(d,c){D(d,t,c),g(t,n),g(t,r),g(t,o),g(o,i),g(i,a),g(i,u),g(u,s)},p(d,[c]){c&1&&A(s,d[0])},i:T,o:T,d(d){d&&p(t)}}}function Nt(l,t,n){let{error:e}=t;return l.$$set=r=>{"error"in r&&n(0,e=r.error)},[e]}class xt extends j{constructor(t){super(),B(this,t,Nt,Ft,L,{error:0})}}function Ut(l){let t,n;return t=new Dt({props:{chartType:l[3],error:l[4]}}),{c(){Q(t.$$.fragment)},l(e){H(t.$$.fragment,e)},m(e,r){K(t,e,r),n=!0},p(e,r){const o={};r&8&&(o.chartType=e[3]),r&16&&(o.error=e[4]),t.$set(o)},i(e){n||(b(t.$$.fragment,e),n=!0)},o(e){y(t.$$.fragment,e),n=!1},d(e){J(t,e)}}}function Qt(l){let t,n;return t=new xt({props:{error:l[4]}}),{c(){Q(t.$$.fragment)},l(e){H(t.$$.fragment,e)},m(e,r){K(t,e,r),n=!0},p(e,r){const o={};r&16&&(o.error=e[4]),t.$set(o)},i(e){n||(b(t.$$.fragment,e),n=!0)},o(e){y(t.$$.fragment,e),n=!1},d(e){J(t,e)}}}function Ht(l){let t,n;return t=new zt({props:{error:l[4]}}),{c(){Q(t.$$.fragment)},l(e){H(t.$$.fragment,e)},m(e,r){K(t,e,r),n=!0},p(e,r){const o={};r&16&&(o.error=e[4]),t.$set(o)},i(e){n||(b(t.$$.fragment,e),n=!0)},o(e){y(t.$$.fragment,e),n=!1},d(e){J(t,e)}}}function Kt(l){let t;function n(o,i){return o[3]==="Value"?Gt:o[3]==="Big Value"?Yt:Jt}let e=n(l),r=e(l);return{c(){r.c(),t=S()},l(o){r.l(o),t=S()},m(o,i){r.m(o,i),D(o,t,i)},p(o,i){e===(e=n(o))&&r?r.p(o,i):(r.d(1),r=e(o),r&&(r.c(),r.m(t.parentNode,t)))},i:T,o:T,d(o){o&&p(t),r.d(o)}}}function Jt(l){let t,n;return{c(){t=v("p"),n=I(l[2]),this.h()},l(e){t=w(e,"P",{class:!0});var r=k(t);n=V(r,l[2]),r.forEach(p),this.h()},h(){h(t,"class","text-xs text-gray-500 p-2 my-2 w-full border border-dashed rounded")},m(e,r){D(e,t,r),g(t,n)},p(e,r){r&4&&A(n,e[2])},d(e){e&&p(t)}}}function Yt(l){let t,n;return{c(){t=v("p"),n=I(l[2]),this.h()},l(e){t=w(e,"P",{class:!0});var r=k(t);n=V(r,l[2]),r.forEach(p),this.h()},h(){h(t,"class","text-xs text-gray-500 p-2 pt-[32px] my-0 text-center w-full align-middle h-[80px] border border-dashed rounded min-w-[120px]")},m(e,r){D(e,t,r),g(t,n)},p(e,r){r&4&&A(n,e[2])},d(e){e&&p(t)}}}function Gt(l){let t,n;return{c(){t=v("span"),n=I(l[2]),this.h()},l(e){t=w(e,"SPAN",{class:!0});var r=k(t);n=V(r,l[2]),r.forEach(p),this.h()},h(){h(t,"class","text-xs text-gray-500 p-2 my-2 w-full border border-dashed rounded")},m(e,r){D(e,t,r),g(t,n)},p(e,r){r&4&&A(n,e[2])},d(e){e&&p(t)}}}function Wt(l){let t,n,e,r,o;const i=[Kt,Ht,Qt,Ut],a=[];function u(s,d){return d&3&&(t=null),t==null&&(t=!!(["warn","pass"].includes(s[1])||!s[0])),t?0:s[3]==="Value"?1:s[3]==="Big Value"?2:3}return n=u(l,-1),e=a[n]=i[n](l),{c(){e.c(),r=S()},l(s){e.l(s),r=S()},m(s,d){a[n].m(s,d),D(s,r,d),o=!0},p(s,[d]){let c=n;n=u(s,d),n===c?a[n].p(s,d):(z(),y(a[c],1,1,()=>{a[c]=null}),F(),e=a[n],e?e.p(s,d):(e=a[n]=i[n](s),e.c()),b(e,1),e.m(r.parentNode,r))},i(s){o||(b(e),o=!0)},o(s){y(e),o=!1},d(s){s&&p(r),a[n].d(s)}}}function Zt(l,t,n){let{isInitial:e=!0}=t,{emptySet:r="error"}=t,{emptyMessage:o="No Records"}=t,{chartType:i="Component"}=t,a="Dataset is empty - query ran successfully, but no data was returned from the database";if(i==="Big Value"&&(a="Dataset is empty"),r==="error"&&e){if(console.error("\x1B[31m%s\x1B[0m",`Error in ${i}: ${a}`),yt)throw Error(a)}else r==="warn"&&e&&console.warn(`Warning in ${i}: Dataset is empty - query ran successfully, but no data was returned from the database`);return l.$$set=u=>{"isInitial"in u&&n(0,e=u.isInitial),"emptySet"in u&&n(1,r=u.emptySet),"emptyMessage"in u&&n(2,o=u.emptyMessage),"chartType"in u&&n(3,i=u.chartType)},[e,r,o,i,a]}class cr extends j{constructor(t){super(),B(this,t,Zt,Wt,L,{isInitial:0,emptySet:1,emptyMessage:2,chartType:3})}}const fr={blue100:"hsla(202, 100%, 95%, 1)",blue200:"hsla(204, 100%, 85%, 1)",blue300:"hsla(206, 95%, 72%, 1)",blue400:"hsla(208, 90%, 63%, 1)",blue500:"hsla(210, 85%, 54%, 1)",blue600:"hsla(212, 96%, 44%, 1)",blue700:"hsla(214, 98%, 38%, 1)",blue800:"hsla(217, 98%, 33%, 1)",blue900:"hsla(220, 99%, 24%, 1)",blue999:"hsla(222, 100%, 18%, 1)",bluelink:"hsla(205, 62%, 38%, 1)",green100:"hsla(167, 100%, 94%, 1)",green200:"hsla(166, 100%, 87%, 1)",green300:"hsla(163, 93%, 76%, 1)",green400:"hsla(161, 90%, 63%, 1)",green500:"hsla(159, 88%, 44%, 1)",green600:"hsla(158, 91%, 35%, 1)",green700:"hsla(156, 93%, 28%, 1)",green800:"hsla(154, 95%, 23%, 1)",green900:"hsla(152, 100%, 18%, 1)",green999:"hsla(150, 100%, 14%, 1)",grey100:"hsla(217, 33%, 97%, 1)",grey200:"hsla(215, 15%, 91%, 1)",grey300:"hsla(211, 16%, 82%, 1)",grey400:"hsla(212, 13%, 65%, 1)",grey500:"hsla(212, 10%, 53%, 1)",grey600:"hsla(212, 12%, 43%, 1)",grey700:"hsla(210, 14%, 37%, 1)",grey800:"hsla(210, 18%, 30%, 1)",grey900:"hsla(210, 20%, 25%, 1)",grey999:"hsla(211, 24%, 16%, 1)",yellow100:"hsl(49, 100%, 96%, 1)",yellow200:"hsl(48, 100%, 88%, 1)",yellow300:"hsl(48, 95%, 76%, 1)",yellow400:"hsl(48, 94%, 68%, 1)",yellow500:"hsl(44, 92%, 63%, 1)",yellow600:"hsl(42, 87%, 55%, 1)",yellow700:"hsl(36, 77%, 49%, 1)",yellow800:"hsl(29, 80%, 44%, 1)",yellow900:"hsl(22, 82%, 39%, 1)",yellow999:"hsl(15, 86%, 30%, 1)"},dr=["hsla(207, 65%, 39%, 1)","hsla(195, 49%, 51%, 1)","hsla(207, 69%, 79%, 1)","hsla(202, 28%, 65%, 1)","hsla(179, 37%, 65%, 1)","hsla(40, 30%, 75%, 1)","hsla(38, 89%, 62%, 1)","hsla(342, 40%, 40%, 1)","hsla(207, 86%, 70%, 1)","hsla(160, 40%, 46%, 1)","#71777d","#7e848a","#8c9196","#9a9fa3","#a8acb0","#b7babd","#c5c8ca","#d4d6d7","#e3e4e5","#f3f3f3"];export{ur as C,ar as D,cr as E,lr as Q,ze as S,zt as V,Dt as a,dr as b,ir as c,pt as f,or as g,sr as p,yt as s,fr as u};