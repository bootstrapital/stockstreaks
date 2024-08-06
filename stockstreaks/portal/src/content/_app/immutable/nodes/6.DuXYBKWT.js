import{A as ue,B as ie,C as W,D as fe,s as ne,b as P,j as g,f as d,t as S,e as y,u as A,d as w,r as T,i as I,k as v,n as B,a as L,c as N,E as G,w as se,g as Y}from"../chunks/scheduler.C_HEsO_p.js";import{g as H,b as E,d as R,t as $,S as ce,i as oe,c as O,a as x,m as D,e as j}from"../chunks/index.D9LHQAU-.js";import{e as U,u as z,I as q,D as _e,o as J,T as he,A as me,a as de,b as pe,_ as be}from"../chunks/VennDiagram.svelte_svelte_type_style_lang.R_puw089.js";import"../chunks/index.BN-V9tMM.js";import"../chunks/entry.BrPh2iM0.js";function ge(u,e){const l=e.token={};function t(r,o,_,c){if(e.token!==l)return;e.resolved=c;let n=e.ctx;_!==void 0&&(n=n.slice(),n[_]=c);const a=r&&(e.current=r)(n);let s=!1;e.block&&(e.blocks?e.blocks.forEach((m,f)=>{f!==o&&m&&(H(),E(m,1,1,()=>{e.blocks[f]===m&&(e.blocks[f]=null)}),R())}):e.block.d(1),a.c(),$(a,1),a.m(e.mount(),e.anchor),s=!0),e.block=a,e.blocks&&(e.blocks[o]=a),s&&fe()}if(ue(u)){const r=ie();if(u.then(o=>{W(r),t(e.then,1,e.value,o),W(null)},o=>{if(W(r),t(e.catch,2,e.error,o),W(null),!e.hasCatch)throw o}),e.current!==e.pending)return t(e.pending,0),!0}else{if(e.current!==e.then)return t(e.then,1,e.value,u),!0;e.resolved=u}}function ke(u,e,l){const t=e.slice(),{resolved:r}=u;u.current===u.then&&(t[u.value]=r),u.current===u.catch&&(t[u.error]=r),u.block.p(t,l)}function Q(u,e,l){const t=u.slice();return t[8]=e[l][0],t[9]=e[l][1],t}function X(u,e,l){const t=u.slice();return t[12]=e[l][0],t[13]=e[l][1],t}function Z(u,e,l){const t=u.slice();return t[16]=e[l],t}function $e(u){let e,l,t=u[19].message+"",r;return{c(){e=S(`An error was encountered while loading project schema.

	`),l=y("pre"),r=S(t),this.h()},l(o){e=A(o,`An error was encountered while loading project schema.

	`),l=w(o,"PRE",{class:!0});var _=T(l);r=A(_,t),_.forEach(d),this.h()},h(){I(l,"class","px-4 py-2 bg-red-800 text-white")},m(o,_){g(o,e,_),g(o,l,_),v(l,r)},p:B,i:B,o:B,d(o){o&&(d(e),d(l))}}}function ve(u){let e,l,t,r=[],o=new Map,_,c=U(Object.entries(u[7]));const n=a=>a[8];for(let a=0;a<c.length;a+=1){let s=Q(u,c,a),m=n(s);o.set(m,r[a]=ae(m,s))}return{c(){e=y("section"),l=y("div"),t=y("ul");for(let a=0;a<r.length;a+=1)r[a].c();this.h()},l(a){e=w(a,"SECTION",{});var s=T(e);l=w(s,"DIV",{});var m=T(l);t=w(m,"UL",{class:!0});var f=T(t);for(let b=0;b<r.length;b+=1)r[b].l(f);f.forEach(d),m.forEach(d),s.forEach(d),this.h()},h(){I(t,"class","list-none m-0 p-0 flex flex-col gap-1 mb-1")},m(a,s){g(a,e,s),v(e,l),v(l,t);for(let m=0;m<r.length;m+=1)r[m]&&r[m].m(t,null);_=!0},p(a,s){s&7&&(c=U(Object.entries(a[7])),H(),r=z(r,s,n,1,a,c,o,t,J,ae,null,Q),R())},i(a){if(!_){for(let s=0;s<c.length;s+=1)$(r[s]);_=!0}},o(a){for(let s=0;s<r.length;s+=1)E(r[s]);_=!1},d(a){a&&d(e);for(let s=0;s<r.length;s+=1)r[s].d()}}}function ee(u){let e,l=[],t=new Map,r,o,_=U(Object.entries(u[9]));const c=n=>n[12];for(let n=0;n<_.length;n+=1){let a=X(u,_,n),s=c(a);t.set(s,l[n]=re(s,a))}return{c(){e=y("ul");for(let n=0;n<l.length;n+=1)l[n].c();r=L(),this.h()},l(n){e=w(n,"UL",{class:!0});var a=T(e);for(let s=0;s<l.length;s+=1)l[s].l(a);r=N(a),a.forEach(d),this.h()},h(){I(e,"class","list-none m-0 flex flex-col gap-1")},m(n,a){g(n,e,a);for(let s=0;s<l.length;s+=1)l[s]&&l[s].m(e,null);v(e,r),o=!0},p(n,a){a&5&&(_=U(Object.entries(n[9])),H(),l=z(l,a,c,1,n,_,t,e,J,re,r,X),R())},i(n){if(!o){for(let a=0;a<_.length;a+=1)$(l[a]);o=!0}},o(n){for(let a=0;a<l.length;a+=1)E(l[a]);o=!1},d(n){n&&d(e);for(let a=0;a<l.length;a+=1)l[a].d()}}}function te(u){let e,l=[],t=new Map,r,o=U(u[13].columns);const _=c=>c[16].column_name;for(let c=0;c<o.length;c+=1){let n=Z(u,o,c),a=_(n);t.set(a,l[c]=le(a,n))}return{c(){e=y("ul");for(let c=0;c<l.length;c+=1)l[c].c();this.h()},l(c){e=w(c,"UL",{class:!0});var n=T(e);for(let a=0;a<l.length;a+=1)l[a].l(n);n.forEach(d),this.h()},h(){I(e,"class","list-none m-0 flex flex-col gap-1")},m(c,n){g(c,e,n);for(let a=0;a<l.length;a+=1)l[a]&&l[a].m(e,null);r=!0},p(c,n){n&4&&(o=U(c[13].columns),H(),l=z(l,n,_,1,c,o,t,e,J,le,null,Z),R())},i(c){if(!r){for(let n=0;n<o.length;n+=1)$(l[n]);r=!0}},o(c){for(let n=0;n<l.length;n+=1)E(l[n]);r=!1},d(c){c&&d(e);for(let n=0;n<l.length;n+=1)l[n].d()}}}function ye(u){let e,l;return e=new q({props:{src:me,class:"text-gray-700 w-5 h-5"}}),{c(){O(e.$$.fragment)},l(t){x(e.$$.fragment,t)},m(t,r){D(e,t,r),l=!0},i(t){l||($(e.$$.fragment,t),l=!0)},o(t){E(e.$$.fragment,t),l=!1},d(t){j(e,t)}}}function we(u){let e,l;return e=new q({props:{src:de,class:"text-gray-700 w-5 h-5"}}),{c(){O(e.$$.fragment)},l(t){x(e.$$.fragment,t)},m(t,r){D(e,t,r),l=!0},i(t){l||($(e.$$.fragment,t),l=!0)},o(t){E(e.$$.fragment,t),l=!1},d(t){j(e,t)}}}function Ee(u){let e,l;return e=new q({props:{src:pe,class:"text-gray-700 w-5 h-5"}}),{c(){O(e.$$.fragment)},l(t){x(e.$$.fragment,t)},m(t,r){D(e,t,r),l=!0},i(t){l||($(e.$$.fragment,t),l=!0)},o(t){E(e.$$.fragment,t),l=!1},d(t){j(e,t)}}}function Te(u){let e,l;return e=new q({props:{src:be,class:"text-gray-700 w-5 h-5"}}),{c(){O(e.$$.fragment)},l(t){x(e.$$.fragment,t)},m(t,r){D(e,t,r),l=!0},i(t){l||($(e.$$.fragment,t),l=!0)},o(t){E(e.$$.fragment,t),l=!1},d(t){j(e,t)}}}function le(u,e){let l,t,r,o,_,c,n,a=e[16].column_name+"",s,m,f=e[16].data_type+"",b,i;const h=[Te,Ee,we,ye],p=[];function C(k,M){return k[16].data_type==="INT"||k[16].data_type==="BIGINT"||k[16].data_type==="SMALLINT"||k[16].data_type==="TINYINT"||k[16].data_type==="DOUBLE"?0:k[16].data_type==="DATE"||k[16].data_type==="DATETIME"||k[16].data_type==="TIMESTAMP"?1:k[16].data_type==="BOOLEAN"?2:3}return r=C(e),o=p[r]=h[r](e),{key:u,first:null,c(){l=y("li"),t=y("div"),o.c(),_=L(),c=y("div"),n=y("b"),s=S(a),m=S("  "),b=S(f),this.h()},l(k){l=w(k,"LI",{class:!0});var M=T(l);t=w(M,"DIV",{class:!0});var V=T(t);o.l(V),_=N(V),c=w(V,"DIV",{class:!0});var F=T(c);n=w(F,"B",{});var K=T(n);s=A(K,a),K.forEach(d),m=A(F,"  "),b=A(F,f),F.forEach(d),V.forEach(d),M.forEach(d),this.h()},h(){I(c,"class","pl-2 lowercase"),I(t,"class","flex px-2 py-1 rounded w-full hover:bg-blue-50"),I(l,"class","font-mono text-sm ml-6 rounded flex flex-row"),this.first=l},m(k,M){g(k,l,M),v(l,t),p[r].m(t,null),v(t,_),v(t,c),v(c,n),v(n,s),v(c,m),v(c,b),i=!0},p(k,M){e=k},i(k){i||($(o),i=!0)},o(k){E(o),i=!1},d(k){k&&d(l),p[r].d()}}}function re(u,e){let l,t,r,o,_=e[12]+"",c,n,a,s,m,f;r=new q({props:{src:he,class:"text-gray-700 w-5 h-5 mr-1"}});function b(){return e[5](e[13])}let i=e[0]===e[13]&&te(e);return{key:u,first:null,c(){l=y("li"),t=y("button"),O(r.$$.fragment),o=L(),c=S(_),n=L(),i&&i.c(),a=P(),this.h()},l(h){l=w(h,"LI",{class:!0});var p=T(l);t=w(p,"BUTTON",{class:!0});var C=T(t);x(r.$$.fragment,C),o=N(C),c=A(C,_),C.forEach(d),p.forEach(d),n=N(h),i&&i.l(h),a=P(),this.h()},h(){I(t,"class","bg-gray-200 px-2 py-1 rounded flex w-full hover:bg-blue-200"),G(t,"bg-blue-200",e[0]===e[13]),I(l,"class","font-mono m-0 text-sm font-bold ml-3"),this.first=l},m(h,p){g(h,l,p),v(l,t),D(r,t,null),v(t,o),v(t,c),g(h,n,p),i&&i.m(h,p),g(h,a,p),s=!0,m||(f=se(t,"click",b),m=!0)},p(h,p){e=h,(!s||p&5)&&G(t,"bg-blue-200",e[0]===e[13]),e[0]===e[13]?i?(i.p(e,p),p&1&&$(i,1)):(i=te(e),i.c(),$(i,1),i.m(a.parentNode,a)):i&&(H(),E(i,1,1,()=>{i=null}),R())},i(h){s||($(r.$$.fragment,h),$(i),s=!0)},o(h){E(r.$$.fragment,h),E(i),s=!1},d(h){h&&(d(l),d(n),d(a)),j(r),i&&i.d(h),m=!1,f()}}}function ae(u,e){let l,t,r,o,_=e[8]+"",c,n,a,s,m,f;r=new q({props:{src:_e,class:"text-white w-5 h-5 mr-1"}});function b(){return e[4](e[8])}let i=e[1]===e[8]&&ee(e);return{key:u,first:null,c(){l=y("li"),t=y("button"),O(r.$$.fragment),o=L(),c=S(_),n=L(),i&&i.c(),a=P(),this.h()},l(h){l=w(h,"LI",{class:!0});var p=T(l);t=w(p,"BUTTON",{class:!0});var C=T(t);x(r.$$.fragment,C),o=N(C),c=A(C,_),C.forEach(d),p.forEach(d),n=N(h),i&&i.l(h),a=P(),this.h()},h(){I(t,"class","bg-gray-500 px-2 py-1 rounded font-bold flex w-full hover:bg-blue-500"),G(t,"bg-blue-500",e[1]===e[8]),I(l,"class","font-mono m-0 text-sm text-white"),this.first=l},m(h,p){g(h,l,p),v(l,t),D(r,t,null),v(t,o),v(t,c),g(h,n,p),i&&i.m(h,p),g(h,a,p),s=!0,m||(f=se(t,"click",b),m=!0)},p(h,p){e=h,(!s||p&6)&&G(t,"bg-blue-500",e[1]===e[8]),e[1]===e[8]?i?(i.p(e,p),p&2&&$(i,1)):(i=ee(e),i.c(),$(i,1),i.m(a.parentNode,a)):i&&(H(),E(i,1,1,()=>{i=null}),R())},i(h){s||($(r.$$.fragment,h),$(i),s=!0)},o(h){E(r.$$.fragment,h),E(i),s=!1},d(h){h&&(d(l),d(n),d(a)),j(r),i&&i.d(h),m=!1,f()}}}function Ie(u){let e;return{c(){e=S("Loading Schema Information...")},l(l){e=A(l,"Loading Schema Information...")},m(l,t){g(l,e,t)},p:B,i:B,o:B,d(l){l&&d(e)}}}function Ce(u){let e,l,t={ctx:u,current:null,token:null,hasCatch:!0,pending:Ie,then:ve,catch:$e,value:7,error:19,blocks:[,,,]};return ge(u[2](),t),{c(){e=P(),t.block.c()},l(r){e=P(),t.block.l(r)},m(r,o){g(r,e,o),t.block.m(r,t.anchor=o),t.mount=()=>e.parentNode,t.anchor=e,l=!0},p(r,[o]){u=r,ke(t,u,o)},i(r){l||($(t.block),l=!0)},o(r){for(let o=0;o<3;o+=1){const _=t.blocks[o];E(_)}l=!1},d(r){r&&d(e),t.block.d(r),t.token=null,t=null}}}function Le(u,e,l){let{data:t}=e,{__db:r}=t;async function o(){const s=await r.query("SELECT * FROM information_schema.tables WHERE table_catalog = 'memory' AND table_name != 'stats'"),m={};return await Promise.all(s.map(async f=>{const b=await r.query(`SELECT * FROM information_schema.columns WHERE table_name = '${f.table_name}' AND table_schema = '${f.table_schema}'`);m[f.table_schema]||(m[f.table_schema]={}),m[f.table_schema][f.table_name]={table:f,columns:b}})),m}let _="",c="";const n=s=>{l(1,c=c===s?"":s),l(0,_="")},a=s=>{l(0,_=_===s?"":s)};return u.$$set=s=>{"data"in s&&l(3,t=s.data)},[_,c,o,t,n,a]}class Ne extends ce{constructor(e){super(),oe(this,e,Le,Ce,ne,{data:3})}}function Se(u){let e,l="Project Schema",t,r,o="This page details the tables and columns that are currently loaded in your project.",_,c,n="Sources",a,s,m;return s=new Ne({props:{data:u[0]}}),{c(){e=y("h1"),e.textContent=l,t=L(),r=y("p"),r.textContent=o,_=L(),c=y("h2"),c.textContent=n,a=L(),O(s.$$.fragment),this.h()},l(f){e=w(f,"H1",{class:!0,"data-svelte-h":!0}),Y(e)!=="svelte-15777oi"&&(e.textContent=l),t=N(f),r=w(f,"P",{class:!0,"data-svelte-h":!0}),Y(r)!=="svelte-ak948l"&&(r.textContent=o),_=N(f),c=w(f,"H2",{class:!0,"data-svelte-h":!0}),Y(c)!=="svelte-9qt1ro"&&(c.textContent=n),a=N(f),x(s.$$.fragment,f),this.h()},h(){I(e,"class","markdown"),I(r,"class","markdown"),I(c,"class","markdown")},m(f,b){g(f,e,b),g(f,t,b),g(f,r,b),g(f,_,b),g(f,c,b),g(f,a,b),D(s,f,b),m=!0},p(f,[b]){const i={};b&1&&(i.data=f[0]),s.$set(i)},i(f){m||($(s.$$.fragment,f),m=!0)},o(f){E(s.$$.fragment,f),m=!1},d(f){f&&(d(e),d(t),d(r),d(_),d(c),d(a)),j(s,f)}}}function Ae(u,e,l){let{data:t}=e;return u.$$set=r=>{"data"in r&&l(0,t=r.data)},[t]}class Be extends ce{constructor(e){super(),oe(this,e,Ae,Se,ne,{data:0})}}export{Be as component};
