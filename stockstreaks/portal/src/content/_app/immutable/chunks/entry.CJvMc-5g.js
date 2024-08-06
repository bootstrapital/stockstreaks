import{n as B,al as ge,Z as me,s as _e,_ as ye,J as wt}from"./scheduler.C_HEsO_p.js";new URL("sveltekit-internal://");function we(t,n){return t==="/"||n==="ignore"?t:n==="never"?t.endsWith("/")?t.slice(0,-1):t:n==="always"&&!t.endsWith("/")?t+"/":t}function ve(t){return t.split("%25").map(decodeURI).join("%25")}function be(t){for(const n in t)t[n]=decodeURIComponent(t[n]);return t}function gt({href:t}){return t.split("#")[0]}const Ee=["href","pathname","search","toString","toJSON"];function ke(t,n,e){const r=new URL(t);Object.defineProperty(r,"searchParams",{value:new Proxy(r.searchParams,{get(a,o){if(o==="get"||o==="getAll"||o==="has")return s=>(e(s),a[o](s));n();const i=Reflect.get(a,o);return typeof i=="function"?i.bind(a):i}}),enumerable:!0,configurable:!0});for(const a of Ee)Object.defineProperty(r,a,{get(){return n(),t[a]},enumerable:!0,configurable:!0});return r}const Ae="/__data.json",Se=".html__data.json";function Re(t){return t.endsWith(".html")?t.replace(/\.html$/,Se):t.replace(/\/$/,"")+Ae}function Ie(...t){let n=5381;for(const e of t)if(typeof e=="string"){let r=e.length;for(;r;)n=n*33^e.charCodeAt(--r)}else if(ArrayBuffer.isView(e)){const r=new Uint8Array(e.buffer,e.byteOffset,e.byteLength);let a=r.length;for(;a;)n=n*33^r[--a]}else throw new TypeError("value must be a string or TypedArray");return(n>>>0).toString(36)}function Le(t){const n=atob(t),e=new Uint8Array(n.length);for(let r=0;r<n.length;r++)e[r]=n.charCodeAt(r);return e.buffer}const Bt=window.fetch;window.fetch=(t,n)=>((t instanceof Request?t.method:(n==null?void 0:n.method)||"GET")!=="GET"&&H.delete(At(t)),Bt(t,n));const H=new Map;function Pe(t,n){const e=At(t,n),r=document.querySelector(e);if(r!=null&&r.textContent){let{body:a,...o}=JSON.parse(r.textContent);const i=r.getAttribute("data-ttl");return i&&H.set(e,{body:a,init:o,ttl:1e3*Number(i)}),r.getAttribute("data-b64")!==null&&(a=Le(a)),Promise.resolve(new Response(a,o))}return window.fetch(t,n)}function Ue(t,n,e){if(H.size>0){const r=At(t,e),a=H.get(r);if(a){if(performance.now()<a.ttl&&["default","force-cache","only-if-cached",void 0].includes(e==null?void 0:e.cache))return new Response(a.body,a.init);H.delete(r)}}return window.fetch(n,e)}function At(t,n){let r=`script[data-sveltekit-fetched][data-url=${JSON.stringify(t instanceof Request?t.url:t)}]`;if(n!=null&&n.headers||n!=null&&n.body){const a=[];n.headers&&a.push([...new Headers(n.headers)].join(",")),n.body&&(typeof n.body=="string"||ArrayBuffer.isView(n.body))&&a.push(n.body),r+=`[data-hash="${Ie(...a)}"]`}return r}const xe=/^(\[)?(\.\.\.)?(\w+)(?:=(\w+))?(\])?$/;function Te(t){const n=[];return{pattern:t==="/"?/^\/$/:new RegExp(`^${Oe(t).map(r=>{const a=/^\[\.\.\.(\w+)(?:=(\w+))?\]$/.exec(r);if(a)return n.push({name:a[1],matcher:a[2],optional:!1,rest:!0,chained:!0}),"(?:/(.*))?";const o=/^\[\[(\w+)(?:=(\w+))?\]\]$/.exec(r);if(o)return n.push({name:o[1],matcher:o[2],optional:!0,rest:!1,chained:!0}),"(?:/([^/]+))?";if(!r)return;const i=r.split(/\[(.+?)\](?!\])/);return"/"+i.map((c,l)=>{if(l%2){if(c.startsWith("x+"))return mt(String.fromCharCode(parseInt(c.slice(2),16)));if(c.startsWith("u+"))return mt(String.fromCharCode(...c.slice(2).split("-").map(f=>parseInt(f,16))));const u=xe.exec(c),[,h,p,d,g]=u;return n.push({name:d,matcher:g,optional:!!h,rest:!!p,chained:p?l===1&&i[0]==="":!1}),p?"(.*?)":h?"([^/]*)?":"([^/]+?)"}return mt(c)}).join("")}).join("")}/?$`),params:n}}function Ne(t){return!/^\([^)]+\)$/.test(t)}function Oe(t){return t.slice(1).split("/").filter(Ne)}function je(t,n,e){const r={},a=t.slice(1),o=a.filter(s=>s!==void 0);let i=0;for(let s=0;s<n.length;s+=1){const c=n[s];let l=a[s-i];if(c.chained&&c.rest&&i&&(l=a.slice(s-i,s+1).filter(u=>u).join("/"),i=0),l===void 0){c.rest&&(r[c.name]="");continue}if(!c.matcher||e[c.matcher](l)){r[c.name]=l;const u=n[s+1],h=a[s+1];u&&!u.rest&&u.optional&&h&&c.chained&&(i=0),!u&&!h&&Object.keys(r).length===o.length&&(i=0);continue}if(c.optional&&c.chained){i++;continue}return}if(!i)return r}function mt(t){return t.normalize().replace(/[[\]]/g,"\\$&").replace(/%/g,"%25").replace(/\//g,"%2[Ff]").replace(/\?/g,"%3[Ff]").replace(/#/g,"%23").replace(/[.*+?^${}()|\\]/g,"\\$&")}function $e({nodes:t,server_loads:n,dictionary:e,matchers:r}){const a=new Set(n);return Object.entries(e).map(([s,[c,l,u]])=>{const{pattern:h,params:p}=Te(s),d={id:s,exec:g=>{const f=h.exec(g);if(f)return je(f,p,r)},errors:[1,...u||[]].map(g=>t[g]),layouts:[0,...l||[]].map(i),leaf:o(c)};return d.errors.length=d.layouts.length=Math.max(d.errors.length,d.layouts.length),d});function o(s){const c=s<0;return c&&(s=~s),[c,t[s]]}function i(s){return s===void 0?s:[a.has(s),t[s]]}}function Ht(t,n=JSON.parse){try{return n(sessionStorage[t])}catch{}}function Ot(t,n,e=JSON.stringify){const r=e(n);try{sessionStorage[t]=r}catch{}}const j=[];function De(t,n){return{subscribe:ot(t,n).subscribe}}function ot(t,n=B){let e;const r=new Set;function a(s){if(_e(t,s)&&(t=s,e)){const c=!j.length;for(const l of r)l[1](),j.push(l,t);if(c){for(let l=0;l<j.length;l+=2)j[l][0](j[l+1]);j.length=0}}}function o(s){a(s(t))}function i(s,c=B){const l=[s,c];return r.add(l),r.size===1&&(e=n(a,o)||B),s(t),()=>{r.delete(l),r.size===0&&e&&(e(),e=null)}}return{set:a,update:o,subscribe:i}}function fn(t,n,e){const r=!Array.isArray(t),a=r?[t]:t;if(!a.every(Boolean))throw new Error("derived() expects stores as input, got a falsy value");const o=n.length<2;return De(e,(i,s)=>{let c=!1;const l=[];let u=0,h=B;const p=()=>{if(u)return;h();const g=n(r?l[0]:l,i,s);o?i(g):h=ye(g)?g:B},d=a.map((g,f)=>ge(g,_=>{l[f]=_,u&=~(1<<f),c&&p()},()=>{u|=1<<f}));return c=!0,p(),function(){me(d),h(),c=!1}})}function un(t){return{subscribe:t.subscribe.bind(t)}}var Gt;const P=((Gt=globalThis.__sveltekit_63q5lc)==null?void 0:Gt.base)??"";var Mt;const Ce=((Mt=globalThis.__sveltekit_63q5lc)==null?void 0:Mt.assets)??P,Ve="1722641485988",Jt="sveltekit:snapshot",Kt="sveltekit:scroll",zt="sveltekit:states",qe="sveltekit:pageurl",C="sveltekit:history",K="sveltekit:navigation",Q={tap:1,hover:2,viewport:3,eager:4,off:-1,false:-1},X=location.origin;function Yt(t){if(t instanceof URL)return t;let n=document.baseURI;if(!n){const e=document.getElementsByTagName("base");n=e.length?e[0].href:document.URL}return new URL(t,n)}function St(){return{x:pageXOffset,y:pageYOffset}}function $(t,n){return t.getAttribute(`data-sveltekit-${n}`)}const jt={...Q,"":Q.hover};function Wt(t){let n=t.assignedSlot??t.parentNode;return(n==null?void 0:n.nodeType)===11&&(n=n.host),n}function Xt(t,n){for(;t&&t!==n;){if(t.nodeName.toUpperCase()==="A"&&t.hasAttribute("href"))return t;t=Wt(t)}}function vt(t,n){let e;try{e=new URL(t instanceof SVGAElement?t.href.baseVal:t.href,document.baseURI)}catch{}const r=t instanceof SVGAElement?t.target.baseVal:t.target,a=!e||!!r||st(e,n)||(t.getAttribute("rel")||"").split(/\s+/).includes("external"),o=(e==null?void 0:e.origin)===X&&t.hasAttribute("download");return{url:e,external:a,target:r,download:o}}function tt(t){let n=null,e=null,r=null,a=null,o=null,i=null,s=t;for(;s&&s!==document.documentElement;)r===null&&(r=$(s,"preload-code")),a===null&&(a=$(s,"preload-data")),n===null&&(n=$(s,"keepfocus")),e===null&&(e=$(s,"noscroll")),o===null&&(o=$(s,"reload")),i===null&&(i=$(s,"replacestate")),s=Wt(s);function c(l){switch(l){case"":case"true":return!0;case"off":case"false":return!1;default:return}}return{preload_code:jt[r??"off"],preload_data:jt[a??"off"],keepfocus:c(n),noscroll:c(e),reload:c(o),replace_state:c(i)}}function $t(t){const n=ot(t);let e=!0;function r(){e=!0,n.update(i=>i)}function a(i){e=!1,n.set(i)}function o(i){let s;return n.subscribe(c=>{(s===void 0||e&&c!==s)&&i(s=c)})}return{notify:r,set:a,subscribe:o}}function Fe(){const{set:t,subscribe:n}=ot(!1);let e;async function r(){clearTimeout(e);try{const a=await fetch(`${Ce}/_app/version.json`,{headers:{pragma:"no-cache","cache-control":"no-cache"}});if(!a.ok)return!1;const i=(await a.json()).version!==Ve;return i&&(t(!0),clearTimeout(e)),i}catch{return!1}}return{subscribe:n,check:r}}function st(t,n){return t.origin!==X||!t.pathname.startsWith(n)}const Ge=-1,Me=-2,Be=-3,He=-4,Je=-5,Ke=-6;function dn(t,n){return Zt(JSON.parse(t),n)}function Zt(t,n){if(typeof t=="number")return a(t,!0);if(!Array.isArray(t)||t.length===0)throw new Error("Invalid input");const e=t,r=Array(e.length);function a(o,i=!1){if(o===Ge)return;if(o===Be)return NaN;if(o===He)return 1/0;if(o===Je)return-1/0;if(o===Ke)return-0;if(i)throw new Error("Invalid input");if(o in r)return r[o];const s=e[o];if(!s||typeof s!="object")r[o]=s;else if(Array.isArray(s))if(typeof s[0]=="string"){const c=s[0],l=n==null?void 0:n[c];if(l)return r[o]=l(a(s[1]));switch(c){case"Date":r[o]=new Date(s[1]);break;case"Set":const u=new Set;r[o]=u;for(let d=1;d<s.length;d+=1)u.add(a(s[d]));break;case"Map":const h=new Map;r[o]=h;for(let d=1;d<s.length;d+=2)h.set(a(s[d]),a(s[d+1]));break;case"RegExp":r[o]=new RegExp(s[1],s[2]);break;case"Object":r[o]=Object(s[1]);break;case"BigInt":r[o]=BigInt(s[1]);break;case"null":const p=Object.create(null);r[o]=p;for(let d=1;d<s.length;d+=2)p[s[d]]=a(s[d+1]);break;default:throw new Error(`Unknown type ${c}`)}}else{const c=new Array(s.length);r[o]=c;for(let l=0;l<s.length;l+=1){const u=s[l];u!==Me&&(c[l]=a(u))}}else{const c={};r[o]=c;for(const l in s){const u=s[l];c[l]=a(u)}}return r[o]}return a(0)}const Qt=new Set(["load","prerender","csr","ssr","trailingSlash","config"]);[...Qt];const ze=new Set([...Qt]);[...ze];function Ye(t){return t.filter(n=>n!=null)}class it{constructor(n,e){this.status=n,typeof e=="string"?this.body={message:e}:e?this.body=e:this.body={message:`Error: ${n}`}}toString(){return JSON.stringify(this.body)}}class te{constructor(n,e){this.status=n,this.location=e}}class Rt extends Error{constructor(n,e,r){super(r),this.status=n,this.text=e}}const We="x-sveltekit-invalidated",Xe="x-sveltekit-trailing-slash";function et(t){return t instanceof it||t instanceof Rt?t.status:500}function Ze(t){return t instanceof Rt?t.text:"Internal Error"}const O=Ht(Kt)??{},z=Ht(Jt)??{},x={url:$t({}),page:$t({}),navigating:ot(null),updated:Fe()};function It(t){O[t]=St()}function Qe(t,n){let e=t+1;for(;O[e];)delete O[e],e+=1;for(e=n+1;z[e];)delete z[e],e+=1}function q(t){return location.href=t.href,new Promise(()=>{})}function Dt(){}let ct,bt,nt,U,Et,G;const ee=[],rt=[];let I=null;const ne=[],tn=[];let D=[],y={branch:[],error:null,url:null},Lt=!1,at=!1,Ct=!0,Y=!1,M=!1,re=!1,lt=!1,N,A,L,S,F;const J=new Set;let _t;async function hn(t,n,e){var a,o;document.URL!==location.href&&(location.href=location.href),G=t,ct=$e(t),U=document.documentElement,Et=n,bt=t.nodes[0],nt=t.nodes[1],bt(),nt(),A=(a=history.state)==null?void 0:a[C],L=(o=history.state)==null?void 0:o[K],A||(A=L=Date.now(),history.replaceState({...history.state,[C]:A,[K]:L},""));const r=O[A];r&&(history.scrollRestoration="manual",scrollTo(r.x,r.y)),e?await cn(Et,e):on(location.href,{replaceState:!0}),sn()}async function en(){if(await(_t||(_t=Promise.resolve())),!_t)return;_t=null;const t=dt(y.url,!0);I=null;const n=F={},e=t&&await xt(t);if(!(!e||n!==F)){if(e.type==="redirect")return ft(new URL(e.location,y.url).href,{},1,n);e.props.page&&(S=e.props.page),y=e.state,ae(),N.$set(e.props)}}function ae(){ee.length=0,lt=!1}function oe(t){rt.some(n=>n==null?void 0:n.snapshot)&&(z[t]=rt.map(n=>{var e;return(e=n==null?void 0:n.snapshot)==null?void 0:e.capture()}))}function se(t){var n;(n=z[t])==null||n.forEach((e,r)=>{var a,o;(o=(a=rt[r])==null?void 0:a.snapshot)==null||o.restore(e)})}function Vt(){It(A),Ot(Kt,O),oe(L),Ot(Jt,z)}async function ft(t,n,e,r){return Z({type:"goto",url:Yt(t),keepfocus:n.keepFocus,noscroll:n.noScroll,replace_state:n.replaceState,state:n.state,redirect_count:e,nav_token:r,accept:()=>{n.invalidateAll&&(lt=!0)}})}async function nn(t){if(t.id!==(I==null?void 0:I.id)){const n={};J.add(n),I={id:t.id,token:n,promise:xt({...t,preload:n}).then(e=>(J.delete(n),e.type==="loaded"&&e.state.error&&(I=null),e))}}return I.promise}async function yt(t){const n=ct.find(e=>e.exec(le(t)));n&&await Promise.all([...n.layouts,n.leaf].map(e=>e==null?void 0:e[1]()))}function ie(t,n){var a;y=t.state;const e=document.querySelector("style[data-sveltekit]");e&&e.remove(),S=t.props.page,N=new G.root({target:n,props:{...t.props,stores:x,components:rt},hydrate:!0}),se(L);const r={from:null,to:{params:y.params,route:{id:((a=y.route)==null?void 0:a.id)??null},url:new URL(location.href)},willUnload:!1,type:"enter",complete:Promise.resolve()};D.forEach(o=>o(r)),at=!0}async function W({url:t,params:n,branch:e,status:r,error:a,route:o,form:i}){let s="never";if(P&&(t.pathname===P||t.pathname===P+"/"))s="always";else for(const d of e)(d==null?void 0:d.slash)!==void 0&&(s=d.slash);t.pathname=we(t.pathname,s),t.search=t.search;const c={type:"loaded",state:{url:t,params:n,branch:e,error:a,route:o},props:{constructors:Ye(e).map(d=>d.node.component),page:S}};i!==void 0&&(c.props.form=i);let l={},u=!S,h=0;for(let d=0;d<Math.max(e.length,y.branch.length);d+=1){const g=e[d],f=y.branch[d];(g==null?void 0:g.data)!==(f==null?void 0:f.data)&&(u=!0),g&&(l={...l,...g.data},u&&(c.props[`data_${h}`]=l),h+=1)}return(!y.url||t.href!==y.url.href||y.error!==a||i!==void 0&&i!==S.form||u)&&(c.props.page={error:a,params:n,route:{id:(o==null?void 0:o.id)??null},state:{},status:r,url:new URL(t),form:i??null,data:u?l:S.data}),c}async function Pt({loader:t,parent:n,url:e,params:r,route:a,server_data_node:o}){var u,h,p;let i=null,s=!0;const c={dependencies:new Set,params:new Set,parent:!1,route:!1,url:!1,search_params:new Set},l=await t();if((u=l.universal)!=null&&u.load){let d=function(...f){for(const _ of f){const{href:b}=new URL(_,e);c.dependencies.add(b)}};const g={route:new Proxy(a,{get:(f,_)=>(s&&(c.route=!0),f[_])}),params:new Proxy(r,{get:(f,_)=>(s&&c.params.add(_),f[_])}),data:(o==null?void 0:o.data)??null,url:ke(e,()=>{s&&(c.url=!0)},f=>{s&&c.search_params.add(f)}),async fetch(f,_){let b;f instanceof Request?(b=f.url,_={body:f.method==="GET"||f.method==="HEAD"?void 0:await f.blob(),cache:f.cache,credentials:f.credentials,headers:f.headers,integrity:f.integrity,keepalive:f.keepalive,method:f.method,mode:f.mode,redirect:f.redirect,referrer:f.referrer,referrerPolicy:f.referrerPolicy,signal:f.signal,..._}):b=f;const R=new URL(b,e);return s&&d(R.href),R.origin===e.origin&&(b=R.href.slice(e.origin.length)),at?Ue(b,R.href,_):Pe(b,_)},setHeaders:()=>{},depends:d,parent(){return s&&(c.parent=!0),n()},untrack(f){s=!1;try{return f()}finally{s=!0}}};i=await l.universal.load.call(null,g)??null}return{node:l,loader:t,server:o,universal:(h=l.universal)!=null&&h.load?{type:"data",data:i,uses:c}:null,data:i??(o==null?void 0:o.data)??null,slash:((p=l.universal)==null?void 0:p.trailingSlash)??(o==null?void 0:o.slash)}}function qt(t,n,e,r,a,o){if(lt)return!0;if(!a)return!1;if(a.parent&&t||a.route&&n||a.url&&e)return!0;for(const i of a.search_params)if(r.has(i))return!0;for(const i of a.params)if(o[i]!==y.params[i])return!0;for(const i of a.dependencies)if(ee.some(s=>s(new URL(i))))return!0;return!1}function Ut(t,n){return(t==null?void 0:t.type)==="data"?t:(t==null?void 0:t.type)==="skip"?n??null:null}function rn(t,n){if(!t)return new Set(n.searchParams.keys());const e=new Set([...t.searchParams.keys(),...n.searchParams.keys()]);for(const r of e){const a=t.searchParams.getAll(r),o=n.searchParams.getAll(r);a.every(i=>o.includes(i))&&o.every(i=>a.includes(i))&&e.delete(r)}return e}function Ft({error:t,url:n,route:e,params:r}){return{type:"loaded",state:{error:t,url:n,route:e,params:r,branch:[]},props:{page:S,constructors:[]}}}async function xt({id:t,invalidating:n,url:e,params:r,route:a,preload:o}){if((I==null?void 0:I.id)===t)return J.delete(I.token),I.promise;const{errors:i,layouts:s,leaf:c}=a,l=[...s,c];i.forEach(m=>m==null?void 0:m().catch(()=>{})),l.forEach(m=>m==null?void 0:m[1]().catch(()=>{}));let u=null;const h=y.url?t!==y.url.pathname+y.url.search:!1,p=y.route?a.id!==y.route.id:!1,d=rn(y.url,e);let g=!1;const f=l.map((m,v)=>{var T;const E=y.branch[v],k=!!(m!=null&&m[0])&&((E==null?void 0:E.loader)!==m[1]||qt(g,p,h,d,(T=E.server)==null?void 0:T.uses,r));return k&&(g=!0),k});if(f.some(Boolean)){try{u=await de(e,f)}catch(m){const v=await V(m,{url:e,params:r,route:{id:t}});return J.has(o)?Ft({error:v,url:e,params:r,route:a}):ut({status:et(m),error:v,url:e,route:a})}if(u.type==="redirect")return u}const _=u==null?void 0:u.nodes;let b=!1;const R=l.map(async(m,v)=>{var ht;if(!m)return;const E=y.branch[v],k=_==null?void 0:_[v];if((!k||k.type==="skip")&&m[1]===(E==null?void 0:E.loader)&&!qt(b,p,h,d,(ht=E.universal)==null?void 0:ht.uses,r))return E;if(b=!0,(k==null?void 0:k.type)==="error")throw k;return Pt({loader:m[1],url:e,params:r,route:a,parent:async()=>{var Nt;const Tt={};for(let pt=0;pt<v;pt+=1)Object.assign(Tt,(Nt=await R[pt])==null?void 0:Nt.data);return Tt},server_data_node:Ut(k===void 0&&m[0]?{type:"skip"}:k??null,m[0]?E==null?void 0:E.server:void 0)})});for(const m of R)m.catch(()=>{});const w=[];for(let m=0;m<l.length;m+=1)if(l[m])try{w.push(await R[m])}catch(v){if(v instanceof te)return{type:"redirect",location:v.location};if(J.has(o))return Ft({error:await V(v,{params:r,url:e,route:{id:a.id}}),url:e,params:r,route:a});let E=et(v),k;if(_!=null&&_.includes(v))E=v.status??E,k=v.error;else if(v instanceof it)k=v.body;else{if(await x.updated.check())return await q(e);k=await V(v,{params:r,url:e,route:{id:a.id}})}const T=await ce(m,w,i);return T?await W({url:e,params:r,branch:w.slice(0,T.idx).concat(T.node),status:E,error:k,route:a}):await ue(e,{id:a.id},k,E)}else w.push(void 0);return await W({url:e,params:r,branch:w,status:200,error:null,route:a,form:n?void 0:null})}async function ce(t,n,e){for(;t--;)if(e[t]){let r=t;for(;!n[r];)r-=1;try{return{idx:r+1,node:{node:await e[t](),loader:e[t],data:{},server:null,universal:null}}}catch{continue}}}async function ut({status:t,error:n,url:e,route:r}){const a={};let o=null;if(G.server_loads[0]===0)try{const l=await de(e,[!0]);if(l.type!=="data"||l.nodes[0]&&l.nodes[0].type!=="data")throw 0;o=l.nodes[0]??null}catch{(e.origin!==X||e.pathname!==location.pathname||Lt)&&await q(e)}const s=await Pt({loader:bt,url:e,params:a,route:r,parent:()=>Promise.resolve({}),server_data_node:Ut(o)}),c={node:await nt(),loader:nt,universal:null,server:null,data:null};return await W({url:e,params:a,branch:[s,c],status:t,error:n,route:null})}function dt(t,n){if(!t||st(t,P))return;let e;try{e=G.hooks.reroute({url:new URL(t)})??t.pathname}catch{return}const r=le(e);for(const a of ct){const o=a.exec(r);if(o)return{id:t.pathname+t.search,invalidating:n,route:a,params:be(o),url:t}}}function le(t){return ve(t.slice(P.length)||"/")}function fe({url:t,type:n,intent:e,delta:r}){let a=!1;const o=pe(y,e,t,n);r!==void 0&&(o.navigation.delta=r);const i={...o.navigation,cancel:()=>{a=!0,o.reject(new Error("navigation cancelled"))}};return Y||ne.forEach(s=>s(i)),a?null:o}async function Z({type:t,url:n,popped:e,keepfocus:r,noscroll:a,replace_state:o,state:i={},redirect_count:s=0,nav_token:c={},accept:l=Dt,block:u=Dt}){const h=dt(n,!1),p=fe({url:n,type:t,delta:e==null?void 0:e.delta,intent:h});if(!p){u();return}const d=A,g=L;l(),Y=!0,at&&x.navigating.set(p.navigation),F=c;let f=h&&await xt(h);if(!f){if(st(n,P))return await q(n);f=await ue(n,{id:null},await V(new Rt(404,"Not Found",`Not found: ${n.pathname}`),{url:n,params:{},route:{id:null}}),404)}if(n=(h==null?void 0:h.url)||n,F!==c)return p.reject(new Error("navigation aborted")),!1;if(f.type==="redirect")if(s>=20)f=await ut({status:500,error:await V(new Error("Redirect loop"),{url:n,params:{},route:{id:null}}),url:n,route:{id:null}});else return ft(new URL(f.location,n).href,{},s+1,c),!1;else f.props.page.status>=400&&await x.updated.check()&&await q(n);if(ae(),It(d),oe(g),f.props.page.url.pathname!==n.pathname&&(n.pathname=f.props.page.url.pathname),i=e?e.state:i,!e){const w=o?0:1,m={[C]:A+=w,[K]:L+=w,[zt]:i};(o?history.replaceState:history.pushState).call(history,m,"",n),o||Qe(A,L)}if(I=null,f.props.page.state=i,at){y=f.state,f.props.page&&(f.props.page.url=n);const w=(await Promise.all(tn.map(m=>m(p.navigation)))).filter(m=>typeof m=="function");if(w.length>0){let m=function(){D=D.filter(v=>!w.includes(v))};w.push(m),D.push(...w)}N.$set(f.props),re=!0}else ie(f,Et);const{activeElement:_}=document;await wt();const b=e?e.scroll:a?St():null;if(Ct){const w=n.hash&&document.getElementById(decodeURIComponent(n.hash.slice(1)));b?scrollTo(b.x,b.y):w?w.scrollIntoView():scrollTo(0,0)}const R=document.activeElement!==_&&document.activeElement!==document.body;!r&&!R&&kt(),Ct=!0,f.props.page&&(S=f.props.page),Y=!1,t==="popstate"&&se(L),p.fulfil(void 0),D.forEach(w=>w(p.navigation)),x.navigating.set(null)}async function ue(t,n,e,r){return t.origin===X&&t.pathname===location.pathname&&!Lt?await ut({status:r,error:e,url:t,route:n}):await q(t)}function an(){let t;U.addEventListener("mousemove",o=>{const i=o.target;clearTimeout(t),t=setTimeout(()=>{r(i,2)},20)});function n(o){r(o.composedPath()[0],1)}U.addEventListener("mousedown",n),U.addEventListener("touchstart",n,{passive:!0});const e=new IntersectionObserver(o=>{for(const i of o)i.isIntersecting&&(yt(i.target.href),e.unobserve(i.target))},{threshold:0});function r(o,i){const s=Xt(o,U);if(!s)return;const{url:c,external:l,download:u}=vt(s,P);if(l||u)return;const h=tt(s);if(!h.reload)if(i<=h.preload_data){const p=dt(c,!1);p&&nn(p)}else i<=h.preload_code&&yt(c.pathname)}function a(){e.disconnect();for(const o of U.querySelectorAll("a")){const{url:i,external:s,download:c}=vt(o,P);if(s||c)continue;const l=tt(o);l.reload||(l.preload_code===Q.viewport&&e.observe(o),l.preload_code===Q.eager&&yt(i.pathname))}}D.push(a),a()}function V(t,n){if(t instanceof it)return t.body;const e=et(t),r=Ze(t);return G.hooks.handleError({error:t,event:n,status:e,message:r})??{message:r}}function on(t,n={}){return t=Yt(t),t.origin!==X?Promise.reject(new Error("goto: invalid URL")):ft(t,n,0)}function pn(){return lt=!0,en()}async function gn(t){if(t.type==="error"){const n=new URL(location.href),{branch:e,route:r}=y;if(!r)return;const a=await ce(y.branch.length,e,r.errors);if(a){const o=await W({url:n,params:y.params,branch:e.slice(0,a.idx).concat(a.node),status:t.status??500,error:t.error,route:r});y=o.state,N.$set(o.props),wt().then(kt)}}else t.type==="redirect"?ft(t.location,{invalidateAll:!0},0):(N.$set({form:null,page:{...S,form:t.data,status:t.status}}),await wt(),N.$set({form:t.data}),t.type==="success"&&kt())}function sn(){var n;history.scrollRestoration="manual",addEventListener("beforeunload",e=>{let r=!1;if(Vt(),!Y){const a=pe(y,void 0,null,"leave"),o={...a.navigation,cancel:()=>{r=!0,a.reject(new Error("navigation cancelled"))}};ne.forEach(i=>i(o))}r?(e.preventDefault(),e.returnValue=""):history.scrollRestoration="auto"}),addEventListener("visibilitychange",()=>{document.visibilityState==="hidden"&&Vt()}),(n=navigator.connection)!=null&&n.saveData||an(),U.addEventListener("click",e=>{var p;if(e.button||e.which!==1||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey||e.defaultPrevented)return;const r=Xt(e.composedPath()[0],U);if(!r)return;const{url:a,external:o,target:i,download:s}=vt(r,P);if(!a)return;if(i==="_parent"||i==="_top"){if(window.parent!==window)return}else if(i&&i!=="_self")return;const c=tt(r);if(!(r instanceof SVGAElement)&&a.protocol!==location.protocol&&!(a.protocol==="https:"||a.protocol==="http:")||s)return;if(o||c.reload){fe({url:a,type:"link"})?Y=!0:e.preventDefault();return}const[u,h]=a.href.split("#");if(h!==void 0&&u===gt(location)){const[,d]=y.url.href.split("#");if(d===h){e.preventDefault(),h===""||h==="top"&&r.ownerDocument.getElementById("top")===null?window.scrollTo({top:0}):(p=r.ownerDocument.getElementById(h))==null||p.scrollIntoView();return}if(M=!0,It(A),t(a),!c.replace_state)return;M=!1}e.preventDefault(),Z({type:"link",url:a,keepfocus:c.keepfocus,noscroll:c.noscroll,replace_state:c.replace_state??a.href===location.href})}),U.addEventListener("submit",e=>{if(e.defaultPrevented)return;const r=HTMLFormElement.prototype.cloneNode.call(e.target),a=e.submitter;if(((a==null?void 0:a.formMethod)||r.method)!=="get")return;const i=new URL((a==null?void 0:a.hasAttribute("formaction"))&&(a==null?void 0:a.formAction)||r.action);if(st(i,P))return;const s=e.target,c=tt(s);if(c.reload)return;e.preventDefault(),e.stopPropagation();const l=new FormData(s),u=a==null?void 0:a.getAttribute("name");u&&l.append(u,(a==null?void 0:a.getAttribute("value"))??""),i.search=new URLSearchParams(l).toString(),Z({type:"form",url:i,keepfocus:c.keepfocus,noscroll:c.noscroll,replace_state:c.replace_state??i.href===location.href})}),addEventListener("popstate",async e=>{var r;if((r=e.state)!=null&&r[C]){const a=e.state[C];if(F={},a===A)return;const o=O[a],i=e.state[zt]??{},s=new URL(e.state[qe]??location.href),c=e.state[K],l=gt(location)===gt(y.url);if(c===L&&(re||l)){t(s),O[A]=St(),o&&scrollTo(o.x,o.y),i!==S.state&&(S={...S,state:i},N.$set({page:S})),A=a;return}const h=a-A;await Z({type:"popstate",url:s,popped:{state:i,scroll:o,delta:h},accept:()=>{A=a,L=c},block:()=>{history.go(-h)},nav_token:F})}else if(!M){const a=new URL(location.href);t(a)}}),addEventListener("hashchange",()=>{M&&(M=!1,history.replaceState({...history.state,[C]:++A,[K]:L},"",location.href))});for(const e of document.querySelectorAll("link"))e.rel==="icon"&&(e.href=e.href);addEventListener("pageshow",e=>{e.persisted&&x.navigating.set(null)});function t(e){y.url=e,x.page.set({...S,url:e}),x.page.notify()}}async function cn(t,{status:n=200,error:e,node_ids:r,params:a,route:o,data:i,form:s}){Lt=!0;const c=new URL(location.href);({params:a={},route:o={id:null}}=dt(c,!1)||{});let l;try{const u=r.map(async(d,g)=>{const f=i[g];return f!=null&&f.uses&&(f.uses=he(f.uses)),Pt({loader:G.nodes[d],url:c,params:a,route:o,parent:async()=>{const _={};for(let b=0;b<g;b+=1)Object.assign(_,(await u[b]).data);return _},server_data_node:Ut(f)})}),h=await Promise.all(u),p=ct.find(({id:d})=>d===o.id);if(p){const d=p.layouts;for(let g=0;g<d.length;g++)d[g]||h.splice(g,0,void 0)}l=await W({url:c,params:a,branch:h,status:n,error:e,form:s,route:p??null})}catch(u){if(u instanceof te){await q(new URL(u.location,location.href));return}l=await ut({status:et(u),error:await V(u,{url:c,params:a,route:o}),url:c,route:o})}l.props.page&&(l.props.page.state={}),ie(l,t)}async function de(t,n){var a;const e=new URL(t);e.pathname=Re(t.pathname),t.pathname.endsWith("/")&&e.searchParams.append(Xe,"1"),e.searchParams.append(We,n.map(o=>o?"1":"0").join(""));const r=await Bt(e.href);if(!r.ok){let o;throw(a=r.headers.get("content-type"))!=null&&a.includes("application/json")?o=await r.json():r.status===404?o="Not Found":r.status===500&&(o="Internal Error"),new it(r.status,o)}return new Promise(async o=>{var h;const i=new Map,s=r.body.getReader(),c=new TextDecoder;function l(p){return Zt(p,{Promise:d=>new Promise((g,f)=>{i.set(d,{fulfil:g,reject:f})})})}let u="";for(;;){const{done:p,value:d}=await s.read();if(p&&!u)break;for(u+=!d&&u?`
`:c.decode(d,{stream:!0});;){const g=u.indexOf(`
`);if(g===-1)break;const f=JSON.parse(u.slice(0,g));if(u=u.slice(g+1),f.type==="redirect")return o(f);if(f.type==="data")(h=f.nodes)==null||h.forEach(_=>{(_==null?void 0:_.type)==="data"&&(_.uses=he(_.uses),_.data=l(_.data))}),o(f);else if(f.type==="chunk"){const{id:_,data:b,error:R}=f,w=i.get(_);i.delete(_),R?w.reject(l(R)):w.fulfil(l(b))}}}})}function he(t){return{dependencies:new Set((t==null?void 0:t.dependencies)??[]),params:new Set((t==null?void 0:t.params)??[]),parent:!!(t!=null&&t.parent),route:!!(t!=null&&t.route),url:!!(t!=null&&t.url),search_params:new Set((t==null?void 0:t.search_params)??[])}}function kt(){const t=document.querySelector("[autofocus]");if(t)t.focus();else{const n=document.body,e=n.getAttribute("tabindex");n.tabIndex=-1,n.focus({preventScroll:!0,focusVisible:!1}),e!==null?n.setAttribute("tabindex",e):n.removeAttribute("tabindex");const r=getSelection();if(r&&r.type!=="None"){const a=[];for(let o=0;o<r.rangeCount;o+=1)a.push(r.getRangeAt(o));setTimeout(()=>{if(r.rangeCount===a.length){for(let o=0;o<r.rangeCount;o+=1){const i=a[o],s=r.getRangeAt(o);if(i.commonAncestorContainer!==s.commonAncestorContainer||i.startContainer!==s.startContainer||i.endContainer!==s.endContainer||i.startOffset!==s.startOffset||i.endOffset!==s.endOffset)return}r.removeAllRanges()}})}}}function pe(t,n,e,r){var c,l;let a,o;const i=new Promise((u,h)=>{a=u,o=h});return i.catch(()=>{}),{navigation:{from:{params:t.params,route:{id:((c=t.route)==null?void 0:c.id)??null},url:t.url},to:e&&{params:(n==null?void 0:n.params)??null,route:{id:((l=n==null?void 0:n.route)==null?void 0:l.id)??null},url:e},willUnload:!n,type:r,complete:i},fulfil:a,reject:o}}export{gn as a,De as b,hn as c,fn as d,pn as i,dn as p,un as r,x as s,ot as w};
