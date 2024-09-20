import{s as it,a as k,e as _,b as D,t as U,c as v,h as rt,d as h,f as s,k as z,l as j,w as K,g as u,i as m,j as L,v as J,n as A,x as V,y as at,z as W,A as nt,B as Z}from"../chunks/scheduler.BnnKGQZ_.js";import{S as ot,i as lt}from"../chunks/index.CZcT0KoH.js";import{p as st}from"../chunks/stores.BHe3hxJV.js";import{s as ct,p as ut,r as $,Q as O,t as tt}from"../chunks/index.kWrU6Xq4.js";import{w as mt}from"../chunks/entry.CaBaf316.js";import{I as pt,C as ft}from"../chunks/globalContexts.1hDlTDmj.js";import{p as dt}from"../chunks/profile.BW8tN6E9.js";function _t(f){let a,l=c.title+"",i;return{c(){a=_("h1"),i=U(l),this.h()},l(e){a=h(e,"H1",{class:!0});var n=z(a);i=j(n,l),n.forEach(s),this.h()},h(){u(a,"class","title")},m(e,n){m(e,a,n),L(a,i)},p:A,d(e){e&&s(a)}}}function ht(f){return{c(){this.h()},l(a){this.h()},h(){document.title="Evidence"},m:A,p:A,d:A}}function yt(f){let a,l,i,e,n;return document.title=a=c.title,{c(){l=k(),i=_("meta"),e=k(),n=_("meta"),this.h()},l(t){l=v(t),i=h(t,"META",{property:!0,content:!0}),e=v(t),n=h(t,"META",{name:!0,content:!0}),this.h()},h(){var t,r;u(i,"property","og:title"),u(i,"content",((t=c.og)==null?void 0:t.title)??c.title),u(n,"name","twitter:title"),u(n,"content",((r=c.og)==null?void 0:r.title)??c.title)},m(t,r){m(t,l,r),m(t,i,r),m(t,e,r),m(t,n,r)},p(t,r){r&0&&a!==(a=c.title)&&(document.title=a)},d(t){t&&(s(l),s(i),s(e),s(n))}}}function Tt(f){var n,t;let a,l,i=(c.description||((n=c.og)==null?void 0:n.description))&&kt(),e=((t=c.og)==null?void 0:t.image)&&vt();return{c(){i&&i.c(),a=k(),e&&e.c(),l=D()},l(r){i&&i.l(r),a=v(r),e&&e.l(r),l=D()},m(r,d){i&&i.m(r,d),m(r,a,d),e&&e.m(r,d),m(r,l,d)},p(r,d){var b,M;(c.description||(b=c.og)!=null&&b.description)&&i.p(r,d),(M=c.og)!=null&&M.image&&e.p(r,d)},d(r){r&&(s(a),s(l)),i&&i.d(r),e&&e.d(r)}}}function kt(f){let a,l,i,e,n;return{c(){a=_("meta"),l=k(),i=_("meta"),e=k(),n=_("meta"),this.h()},l(t){a=h(t,"META",{name:!0,content:!0}),l=v(t),i=h(t,"META",{property:!0,content:!0}),e=v(t),n=h(t,"META",{name:!0,content:!0}),this.h()},h(){var t,r,d;u(a,"name","description"),u(a,"content",c.description??((t=c.og)==null?void 0:t.description)),u(i,"property","og:description"),u(i,"content",((r=c.og)==null?void 0:r.description)??c.description),u(n,"name","twitter:description"),u(n,"content",((d=c.og)==null?void 0:d.description)??c.description)},m(t,r){m(t,a,r),m(t,l,r),m(t,i,r),m(t,e,r),m(t,n,r)},p:A,d(t){t&&(s(a),s(l),s(i),s(e),s(n))}}}function vt(f){let a,l,i;return{c(){a=_("meta"),l=k(),i=_("meta"),this.h()},l(e){a=h(e,"META",{property:!0,content:!0}),l=v(e),i=h(e,"META",{name:!0,content:!0}),this.h()},h(){var e,n;u(a,"property","og:image"),u(a,"content",(e=c.og)==null?void 0:e.image),u(i,"name","twitter:image"),u(i,"content",(n=c.og)==null?void 0:n.image)},m(e,n){m(e,a,n),m(e,l,n),m(e,i,n)},p:A,d(e){e&&(s(a),s(l),s(i))}}}function bt(f){let a,l,i,e,n,t,r,d,b=f[0].ticker.toUpperCase()+"",M,x,y,S='<a href="#overview">Overview</a>',Q,E,T,F=f[0].ticker.toUpperCase()+"",q,N,w,X='<a href="#data">Data</a>',P,g,Y='<a href="#daily-performance">Daily Performance</a>',C=typeof c<"u"&&c.title&&c.hide_title!==!0&&_t();function et(o,p){return typeof c<"u"&&c.title?yt:ht}let I=et()(f),H=typeof c=="object"&&Tt();return{c(){C&&C.c(),a=k(),I.c(),l=_("meta"),i=_("meta"),H&&H.c(),e=D(),n=k(),t=_("h1"),r=_("a"),d=U("Report for "),M=U(b),x=k(),y=_("h2"),y.innerHTML=S,Q=k(),E=_("p"),T=U("This is a report for "),q=U(F),N=k(),w=_("h2"),w.innerHTML=X,P=k(),g=_("h3"),g.innerHTML=Y,this.h()},l(o){C&&C.l(o),a=v(o);const p=rt("svelte-1j2izld",document.head);I.l(p),l=h(p,"META",{name:!0,content:!0}),i=h(p,"META",{name:!0,content:!0}),H&&H.l(p),e=D(),p.forEach(s),n=v(o),t=h(o,"H1",{class:!0,id:!0});var B=z(t);r=h(B,"A",{href:!0});var R=z(r);d=j(R,"Report for "),M=j(R,b),R.forEach(s),B.forEach(s),x=v(o),y=h(o,"H2",{class:!0,id:!0,"data-svelte-h":!0}),K(y)!=="svelte-16zqni9"&&(y.innerHTML=S),Q=v(o),E=h(o,"P",{class:!0});var G=z(E);T=j(G,"This is a report for "),q=j(G,F),G.forEach(s),N=v(o),w=h(o,"H2",{class:!0,id:!0,"data-svelte-h":!0}),K(w)!=="svelte-1ouuc1c"&&(w.innerHTML=X),P=v(o),g=h(o,"H3",{class:!0,id:!0,"data-svelte-h":!0}),K(g)!=="svelte-58lwmp"&&(g.innerHTML=Y),this.h()},h(){u(l,"name","twitter:card"),u(l,"content","summary"),u(i,"name","twitter:site"),u(i,"content","@evidence_dev"),u(r,"href","#report-for--paramstickertouppercase-"),u(t,"class","markdown"),u(t,"id","report-for--paramstickertouppercase-"),u(y,"class","markdown"),u(y,"id","overview"),u(E,"class","markdown"),u(w,"class","markdown"),u(w,"id","data"),u(g,"class","markdown"),u(g,"id","daily-performance")},m(o,p){C&&C.m(o,p),m(o,a,p),I.m(document.head,null),L(document.head,l),L(document.head,i),H&&H.m(document.head,null),L(document.head,e),m(o,n,p),m(o,t,p),L(t,r),L(r,d),L(r,M),m(o,x,p),m(o,y,p),m(o,Q,p),m(o,E,p),L(E,T),L(E,q),m(o,N,p),m(o,w,p),m(o,P,p),m(o,g,p)},p(o,[p]){typeof c<"u"&&c.title&&c.hide_title!==!0&&C.p(o,p),I.p(o,p),typeof c=="object"&&H.p(o,p),p&1&&b!==(b=o[0].ticker.toUpperCase()+"")&&J(M,b),p&1&&F!==(F=o[0].ticker.toUpperCase()+"")&&J(q,F)},i:A,o:A,d(o){o&&(s(a),s(n),s(t),s(x),s(y),s(Q),s(E),s(N),s(w),s(P),s(g)),C&&C.d(o),I.d(o),s(l),s(i),H&&H.d(o),s(e)}}}const c={title:"A Stock Page"};function Et(f,a,l){let i,e;V(f,st,T=>l(3,i=T)),V(f,$,T=>l(9,e=T));let{data:n}=a,{data:t={},customFormattingSettings:r,__db:d,inputs:b}=n;at($,e="486489c9e417be20b05084ea4b458823",e);let M=mt(b);W(pt,M),nt(M.subscribe(T=>b=T)),W(ft,{getCustomFormats:()=>r.customFormats||[]}),ct((T,F)=>dt(d.query,T,{query_name:F}));let y;const S=()=>{y||(y=setTimeout(()=>{tt.add({id:"LoadingToast",title:"",message:"Loading...",status:"info"},0)},3e3))},Q=()=>{y?(clearTimeout(y),y=null):tt.dismiss("LoadingToast")};Z(()=>(O.addEventListener("inFlightQueryStart",S),O.addEventListener("inFlightQueryEnd",Q),O.QueriesLoading&&S(),()=>{O.removeEventListener("inFlightQueryStart",S),O.removeEventListener("inFlightQueryEnd",Q)}));let E=i.params;return Z(()=>!0),f.$$set=T=>{"data"in T&&l(1,n=T.data)},f.$$.update=()=>{f.$$.dirty&2&&l(2,{data:t={},customFormattingSettings:r,__db:d}=n,t),f.$$.dirty&4&&ut.set(Object.keys(t).length>0),f.$$.dirty&8&&l(0,E=i.params)},[E,n,t,i]}class Ft extends ot{constructor(a){super(),lt(this,a,Et,bt,it,{data:1})}}export{Ft as component};