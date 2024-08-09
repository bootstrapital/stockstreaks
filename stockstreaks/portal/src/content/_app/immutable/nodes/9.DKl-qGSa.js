import{s as it,a as k,e as _,b as R,t as O,c as v,h as rt,d as h,f as s,r as D,u as U,g as K,i as u,j as m,k as L,v as J,n as A,l as V,m as at,o as W,p as ot,q as Z}from"../chunks/scheduler.C_HEsO_p.js";import{S as nt,i as lt}from"../chunks/index.D9LHQAU-.js";import{p as st}from"../chunks/stores.ChHw-fSg.js";import{s as ct,p as ut,r as $,Q as I,t as tt}from"../chunks/index.CDrlHU0_.js";import{w as mt}from"../chunks/entry.CJvMc-5g.js";import{I as pt,C as ft}from"../chunks/globalContexts.1hDlTDmj.js";import{p as dt}from"../chunks/profile.BW8tN6E9.js";function _t(f){let a,l=c.title+"",i;return{c(){a=_("h1"),i=O(l),this.h()},l(e){a=h(e,"H1",{class:!0});var o=D(a);i=U(o,l),o.forEach(s),this.h()},h(){u(a,"class","title")},m(e,o){m(e,a,o),L(a,i)},p:A,d(e){e&&s(a)}}}function ht(f){return{c(){this.h()},l(a){this.h()},h(){document.title="Evidence"},m:A,p:A,d:A}}function yt(f){let a,l,i,e,o;return document.title=a=c.title,{c(){l=k(),i=_("meta"),e=k(),o=_("meta"),this.h()},l(t){l=v(t),i=h(t,"META",{property:!0,content:!0}),e=v(t),o=h(t,"META",{name:!0,content:!0}),this.h()},h(){var t,r;u(i,"property","og:title"),u(i,"content",((t=c.og)==null?void 0:t.title)??c.title),u(o,"name","twitter:title"),u(o,"content",((r=c.og)==null?void 0:r.title)??c.title)},m(t,r){m(t,l,r),m(t,i,r),m(t,e,r),m(t,o,r)},p(t,r){r&0&&a!==(a=c.title)&&(document.title=a)},d(t){t&&(s(l),s(i),s(e),s(o))}}}function Tt(f){var o,t;let a,l,i=(c.description||((o=c.og)==null?void 0:o.description))&&kt(),e=((t=c.og)==null?void 0:t.image)&&vt();return{c(){i&&i.c(),a=k(),e&&e.c(),l=R()},l(r){i&&i.l(r),a=v(r),e&&e.l(r),l=R()},m(r,d){i&&i.m(r,d),m(r,a,d),e&&e.m(r,d),m(r,l,d)},p(r,d){var b,M;(c.description||(b=c.og)!=null&&b.description)&&i.p(r,d),(M=c.og)!=null&&M.image&&e.p(r,d)},d(r){r&&(s(a),s(l)),i&&i.d(r),e&&e.d(r)}}}function kt(f){let a,l,i,e,o;return{c(){a=_("meta"),l=k(),i=_("meta"),e=k(),o=_("meta"),this.h()},l(t){a=h(t,"META",{name:!0,content:!0}),l=v(t),i=h(t,"META",{property:!0,content:!0}),e=v(t),o=h(t,"META",{name:!0,content:!0}),this.h()},h(){var t,r,d;u(a,"name","description"),u(a,"content",c.description??((t=c.og)==null?void 0:t.description)),u(i,"property","og:description"),u(i,"content",((r=c.og)==null?void 0:r.description)??c.description),u(o,"name","twitter:description"),u(o,"content",((d=c.og)==null?void 0:d.description)??c.description)},m(t,r){m(t,a,r),m(t,l,r),m(t,i,r),m(t,e,r),m(t,o,r)},p:A,d(t){t&&(s(a),s(l),s(i),s(e),s(o))}}}function vt(f){let a,l,i;return{c(){a=_("meta"),l=k(),i=_("meta"),this.h()},l(e){a=h(e,"META",{property:!0,content:!0}),l=v(e),i=h(e,"META",{name:!0,content:!0}),this.h()},h(){var e,o;u(a,"property","og:image"),u(a,"content",(e=c.og)==null?void 0:e.image),u(i,"name","twitter:image"),u(i,"content",(o=c.og)==null?void 0:o.image)},m(e,o){m(e,a,o),m(e,l,o),m(e,i,o)},p:A,d(e){e&&(s(a),s(l),s(i))}}}function bt(f){let a,l,i,e,o,t,r,d,b=f[0].ticker.toUpperCase()+"",M,x,y,S='<a href="#overview">Overview</a>',Q,E,T,F=f[0].ticker.toUpperCase()+"",j,N,g,X='<a href="#data">Data</a>',P,w,Y='<a href="#daily-performance">Daily Performance</a>',C=typeof c<"u"&&c.title&&c.hide_title!==!0&&_t();function et(n,p){return typeof c<"u"&&c.title?yt:ht}let q=et()(f),H=typeof c=="object"&&Tt();return{c(){C&&C.c(),a=k(),q.c(),l=_("meta"),i=_("meta"),H&&H.c(),e=R(),o=k(),t=_("h1"),r=_("a"),d=O("Report for "),M=O(b),x=k(),y=_("h2"),y.innerHTML=S,Q=k(),E=_("p"),T=O("This is a report for "),j=O(F),N=k(),g=_("h2"),g.innerHTML=X,P=k(),w=_("h3"),w.innerHTML=Y,this.h()},l(n){C&&C.l(n),a=v(n);const p=rt("svelte-1j2izld",document.head);q.l(p),l=h(p,"META",{name:!0,content:!0}),i=h(p,"META",{name:!0,content:!0}),H&&H.l(p),e=R(),p.forEach(s),o=v(n),t=h(n,"H1",{class:!0,id:!0});var B=D(t);r=h(B,"A",{href:!0});var z=D(r);d=U(z,"Report for "),M=U(z,b),z.forEach(s),B.forEach(s),x=v(n),y=h(n,"H2",{class:!0,id:!0,"data-svelte-h":!0}),K(y)!=="svelte-16zqni9"&&(y.innerHTML=S),Q=v(n),E=h(n,"P",{class:!0});var G=D(E);T=U(G,"This is a report for "),j=U(G,F),G.forEach(s),N=v(n),g=h(n,"H2",{class:!0,id:!0,"data-svelte-h":!0}),K(g)!=="svelte-1ouuc1c"&&(g.innerHTML=X),P=v(n),w=h(n,"H3",{class:!0,id:!0,"data-svelte-h":!0}),K(w)!=="svelte-58lwmp"&&(w.innerHTML=Y),this.h()},h(){u(l,"name","twitter:card"),u(l,"content","summary"),u(i,"name","twitter:site"),u(i,"content","@evidence_dev"),u(r,"href","#report-for--paramstickertouppercase-"),u(t,"class","markdown"),u(t,"id","report-for--paramstickertouppercase-"),u(y,"class","markdown"),u(y,"id","overview"),u(E,"class","markdown"),u(g,"class","markdown"),u(g,"id","data"),u(w,"class","markdown"),u(w,"id","daily-performance")},m(n,p){C&&C.m(n,p),m(n,a,p),q.m(document.head,null),L(document.head,l),L(document.head,i),H&&H.m(document.head,null),L(document.head,e),m(n,o,p),m(n,t,p),L(t,r),L(r,d),L(r,M),m(n,x,p),m(n,y,p),m(n,Q,p),m(n,E,p),L(E,T),L(E,j),m(n,N,p),m(n,g,p),m(n,P,p),m(n,w,p)},p(n,[p]){typeof c<"u"&&c.title&&c.hide_title!==!0&&C.p(n,p),q.p(n,p),typeof c=="object"&&H.p(n,p),p&1&&b!==(b=n[0].ticker.toUpperCase()+"")&&J(M,b),p&1&&F!==(F=n[0].ticker.toUpperCase()+"")&&J(j,F)},i:A,o:A,d(n){n&&(s(a),s(o),s(t),s(x),s(y),s(Q),s(E),s(N),s(g),s(P),s(w)),C&&C.d(n),q.d(n),s(l),s(i),H&&H.d(n),s(e)}}}const c={title:"A Stock Page"};function Et(f,a,l){let i,e;V(f,st,T=>l(3,i=T)),V(f,$,T=>l(9,e=T));let{data:o}=a,{data:t={},customFormattingSettings:r,__db:d,inputs:b}=o;at($,e="486489c9e417be20b05084ea4b458823",e);let M=mt(b);W(pt,M),ot(M.subscribe(T=>b=T)),W(ft,{getCustomFormats:()=>r.customFormats||[]}),ct((T,F)=>dt(d.query,T,{query_name:F}));let y;const S=()=>{y||(y=setTimeout(()=>{tt.add({id:"LoadingToast",title:"",message:"Loading...",status:"info"},0)},3e3))},Q=()=>{y?(clearTimeout(y),y=null):tt.dismiss("LoadingToast")};Z(()=>(I.addEventListener("inFlightQueryStart",S),I.addEventListener("inFlightQueryEnd",Q),I.QueriesLoading&&S(),()=>{I.removeEventListener("inFlightQueryStart",S),I.removeEventListener("inFlightQueryEnd",Q)}));let E=i.params;return Z(()=>!0),f.$$set=T=>{"data"in T&&l(1,o=T.data)},f.$$.update=()=>{f.$$.dirty&2&&l(2,{data:t={},customFormattingSettings:r,__db:d}=o,t),f.$$.dirty&4&&ut.set(Object.keys(t).length>0),f.$$.dirty&8&&l(0,E=i.params)},[E,o,t,i]}class Ft extends nt{constructor(a){super(),lt(this,a,Et,bt,it,{data:1})}}export{Ft as component};